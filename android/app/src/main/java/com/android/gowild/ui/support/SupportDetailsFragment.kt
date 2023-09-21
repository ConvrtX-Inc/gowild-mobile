package com.android.gowild.ui.support

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.text.TextUtils
import androidx.activity.viewModels
import com.android.gowild.BuildConfig
import com.android.gowild.R
import com.android.gowild.data.model.support.SupportMessagesDataModel
import com.android.gowild.databinding.FragmentSupportDetailsBinding
import com.android.gowild.interfaces.SimpleCallbackValue
import com.android.gowild.networking.Errors
import com.android.gowild.networking.NetworkResult
import com.android.gowild.ui.base.BaseActivity
import com.android.gowild.ui.base.BindingRecyclerAdapter
import com.android.gowild.ui.user.dialog.ErrorDialog
import com.android.gowild.utils.constant.NameConst
import com.android.gowild.utils.extension.setRecyclerViewAdapter
import com.android.gowild.utils.extension.showBar
import com.android.gowild.utils.extension.toast
import com.android.gowild.utils.local.UserPrefs
import com.google.gson.Gson
import com.squareup.picasso.Picasso
import com.stfalcon.imageviewer.StfalconImageViewer
import dagger.hilt.android.AndroidEntryPoint
import io.socket.client.Ack
import io.socket.client.IO
import io.socket.client.Socket
import io.socket.emitter.Emitter
import io.socket.engineio.client.transports.Polling
import io.socket.engineio.client.transports.PollingXHR
import org.json.JSONException
import org.json.JSONObject
import timber.log.Timber
import java.net.URISyntaxException

@AndroidEntryPoint
class SupportDetailsFragment : BaseActivity() {

    private lateinit var adapter: BindingRecyclerAdapter<SupportMessagesDataModel, SimpleCallbackValue>
    lateinit var binding: FragmentSupportDetailsBinding

    //    private val supportDetailsVM: SupportDetailsVM by viewModels()
    private val supportDetailsVM by viewModels<SupportDetailsVM>()

    private var mSocket: Socket? = null

    private var isConnected = true

    var dataList: ArrayList<SupportMessagesDataModel> = ArrayList()

    lateinit var ticketID: String

//    companion object {
//        @JvmStatic
//        fun newInstance(ticketID: String): SupportDetailsFragment {
//            return SupportDetailsFragment().apply {
//                arguments = Bundle().apply {
//                    putString("ticketID", ticketID)
//                }
//            }
//        }
//    }

//    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
//        binding = FragmentSupportDetailsBinding.inflate(layoutInflater)
//        init()
//        return binding
//    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = FragmentSupportDetailsBinding.inflate(layoutInflater)
        setContentView(binding.root)
        init()
    }

    fun init() {
        ticketID = intent.extras!!.getString("ticketID")!!
        setCallbacks()
        connectSocketToURL()
        observeSupportChatResponse()
        setAdapter()
        supportDetailsVM.getSupportChat(ticketID)
    }

    fun setAdapter() {
        adapter = binding.rvSupportChat.setRecyclerViewAdapter(
            R.layout.item_list_support_chat,
            dataList,
            null,
            SimpleCallbackValue {
                handleAttachment(it as String)
            }
        )
    }

    private fun handleAttachment(attachment: String) {
        if (attachment.contains("pdf")) {
            val i = Intent(Intent.ACTION_VIEW)
            i.data = Uri.parse(BuildConfig.BASE_URL + attachment)
            startActivity(i)
        } else {
            StfalconImageViewer.Builder(this, mutableListOf(BuildConfig.BASE_URL + attachment)) { view, image_URL ->
                Picasso.get().load(image_URL).into(view)
            }.show()
        }
    }

    private fun setCallbacks() {
        binding.backIv.setOnClickListener {
            onBackPressedDispatcher.onBackPressed()
        }

        binding.sendButton.setOnClickListener {
            sendMsg()
        }
    }

    private fun sendMsg() {
        if (!mSocket!!.connected()) return
        val message: String = binding.messageInput.text.toString().trim { it <= ' ' }
        if (TextUtils.isEmpty(message)) {
            binding.messageInput.requestFocus()
            return
        }
        binding.messageInput.setText("")

        val messageJson = JSONObject()

        messageJson.put("ticket_id", ticketID)
        messageJson.put("user_id", "")
        messageJson.put("message", message)
        messageJson.put("token", "Bearer ${userPrefs.getUser()!!.accessToken}")

        addMessage(SupportMessagesDataModel(role = "user", id = ticketID, message = message, user = UserPrefs(applicationContext).getUser()))

        try {
            mSocket!!.emit("msgToUser", messageJson, Ack { args: Array<Any> ->
                val response = args[0] as JSONObject
                Timber.tag("MESSAGE_SOCKET").wtf("emit $response")
            })
        } catch (e: Exception) {
            Timber.tag("MESSAGE_SOCKET").wtf("emit ${e.message}")
        }
    }

    private fun observeSupportChatResponse() {
        supportDetailsVM.supportChatResponse.observe(this) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    hideProgress()
                    dataList.clear()
                    dataList.addAll(response.data!!.data)
                    adapter.notifyDataSetChanged()
                    scrollToBottom()
                }
                is NetworkResult.Failure -> {
                    hideProgress()
                    response.junkError?.let { junkErrors ->
                        ErrorDialog(mContext, junkErrors.errors!![0].map { it.value }).show()
                    } ?: kotlin.run {
                        binding.root.showBar(response.message ?: "Failure")
                    }
                }
                is NetworkResult.Loading -> {
                    showProgress()
                }
                is NetworkResult.Error -> {
                    when (response.error) {
                        is Errors.Error -> {
                            hideProgress()
                            binding.root.showBar("Please try again later")
                        }
                        is Errors.NetworkError -> {
                            hideProgress()
                            binding.root.showBar("Internet connection unavailable")
                        }
                        is Errors.ServerError -> {
                            hideProgress()
                            binding.root.showBar("Server error")
                        }
                        is Errors.TimeOutError -> {
                            hideProgress()
                            binding.root.showBar("Network time out")
                        }
                        null -> {
                            hideProgress()
                            binding.root.showBar("Please try again later")
                        }
                    }
                }
            }
        }
    }

    private fun connectSocketToURL() {
        try {
            val options = IO.Options.builder()
                .setTransports(arrayOf(Polling.NAME, PollingXHR.NAME))
                .build()
            mSocket = IO.socket(NameConst.SocketServer, options)
        } catch (e: URISyntaxException) {
            toast("Cant connect to socket server")
            onBackPressedDispatcher.onBackPressed()
        }

        mSocket!!.connect()
        mSocket!!.on(Socket.EVENT_CONNECT, onConnect)
        mSocket!!.on(Socket.EVENT_DISCONNECT, onDisconnect)
        mSocket!!.on(Socket.EVENT_CONNECT_ERROR, onConnectError)
        mSocket!!.on("msgSupport", onNewMessage)
//        mSocket!!.on("msgToClient", onNewMessage)
        mSocket!!.on("joinedSupport", onJoinedRoom)
    }

    private fun addMessage(message: SupportMessagesDataModel) {
        dataList.add(message)
        adapter.notifyDataSetChanged()
        scrollToBottom()
    }

    private fun scrollToBottom() {
        if (dataList.isNotEmpty())
            binding.rvSupportChat.smoothScrollToPosition(adapter.itemCount - 1)
    }

    private fun connectChat() {
        val messageJson = JSONObject()

        messageJson.put("ticket_id", ticketID)
        messageJson.put("sender_id", userPrefs.getUser()!!.id)

//        messageJson.put("token", "Bearer ${userPrefs.getUser()!!.accessToken}")

        Timber.tag("SUPPORT_SOCKET").wtf("messageJson $messageJson")

        mSocket!!.emit("supportUsers", messageJson)
    }

    private val onNewMessage =
        Emitter.Listener { args ->
            this.runOnUiThread(Runnable {
                Timber.tag("SUPPORT_SOCKET").wtf("onNewMessage")
                val data = args[0] as JSONObject
                try {
                    addMessage(Gson().fromJson(data.toString(), SupportMessagesDataModel::class.java))
                    Timber.tag("SUPPORT_SOCKET").wtf("onNewMessage success")
                } catch (e: JSONException) {
                    return@Runnable
                }
            })
        }

    private val onJoinedRoom =
        Emitter.Listener { args ->
            this.runOnUiThread(Runnable {
                val joinedID: String = args[0] as String
                Timber.tag("SUPPORT_SOCKET").wtf("onJoinedRoom $joinedID")
            })
        }

    private val onConnect = Emitter.Listener {
        this.runOnUiThread {
            Timber.tag("SUPPORT_SOCKET").wtf("onConnect")
            isConnected = true
            connectChat()
        }
    }

    private val onDisconnect = Emitter.Listener {
        this.runOnUiThread {
            Timber.tag("SUPPORT_SOCKET").wtf("onDisconnect")
        }
    }

    private val onConnectError = Emitter.Listener {
        this.runOnUiThread {
            Timber.tag("SUPPORT_SOCKET").wtf("onConnectError ${it.size}")
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        mSocket!!.close()
        mSocket!!.off("msgSupport", onNewMessage)
    }
}