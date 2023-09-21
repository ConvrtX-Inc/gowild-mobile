package com.android.gowild.ui.messages

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.text.TextUtils
import androidx.activity.viewModels
import androidx.recyclerview.widget.LinearLayoutManager
import com.android.gowild.BuildConfig
import com.android.gowild.data.model.message.MessageApiResponse
import com.android.gowild.databinding.FragmentMessagesBinding
import com.android.gowild.networking.Errors
import com.android.gowild.networking.NetworkResult
import com.android.gowild.ui.base.BaseActivity
import com.android.gowild.ui.user.dialog.ErrorDialog
import com.android.gowild.utils.constant.NameConst
import com.android.gowild.utils.extension.loadImage
import com.android.gowild.utils.extension.showBar
import com.android.gowild.utils.extension.toast
import com.google.gson.Gson
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
class MessageActivity : BaseActivity() {

    companion object {
        fun start(activity: Activity, roomId: String, userId: String, name: String, picture: String) {
            val intent = Intent(activity, MessageActivity::class.java)
            intent.putExtra("roomId", roomId)
            intent.putExtra("userId", userId)
            intent.putExtra("name", name)
            intent.putExtra("picture", picture)
            activity.startActivity(intent)
        }
    }

    private lateinit var binding: FragmentMessagesBinding

    private lateinit var adapter: MessagesAdapter
    var items = ArrayList<MessageApiResponse.MessageDetail>()

    private lateinit var userId: String
    private lateinit var roomId: String
    private lateinit var name: String
    private lateinit var picture: String

    private val messageListVM by viewModels<MessagesListVM>()

    private var mSocket: Socket? = null

    private var isConnected = true

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = FragmentMessagesBinding.inflate(layoutInflater)

        userId = intent.getStringExtra("userId").toString()
        roomId = intent.getStringExtra("roomId").toString()
        name = intent.getStringExtra("name").toString()
        picture = intent.getStringExtra("picture").toString()

        setUserData()
        observers()
        setCallbacks()

        binding.rvMessages.layoutManager = LinearLayoutManager(this)
        adapter = MessagesAdapter(items, userPrefs, name, picture)
        binding.rvMessages.adapter = adapter

        messageListVM.getMessages(userId)

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
        mSocket!!.on("msgToClient", onNewMessage)
        mSocket!!.on("joinedRoom", onJoinedRoom)

        setContentView(binding.root)
    }

    private fun setCallbacks() {
        binding.sendButton.setOnClickListener {
            sendMsg()
        }
        binding.backIv.setOnClickListener {
            this.onBackPressedDispatcher.onBackPressed()
        }
    }

    private fun setUserData() {
        binding.titleTv.text = name
        binding.profileImg.loadImage(BuildConfig.BASE_URL + picture)
    }

    private fun observers() {
        messageListVM.messageResponse.observe(this) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    if (response.data?.data != null) {
                        items.clear()
                        items.addAll(response.data.data.reversed())
                        adapter.notifyDataSetChanged()
                        scrollToBottom()
                    }
                    hideProgress()
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

    override fun onDestroy() {
        super.onDestroy()
        mSocket!!.close()
        mSocket!!.off("msgToServer", onNewMessage)
    }

    private fun scrollToBottom() {
        if (items.isNotEmpty())
            binding.rvMessages.smoothScrollToPosition(adapter.itemCount - 1)
    }

    private fun addMessage(message: MessageApiResponse.MessageDetail) {
        items.add(message)
        adapter.notifyItemInserted(items.size - 1)
        scrollToBottom()
    }

    private fun sendMsg() {
        if (!mSocket!!.connected()) return
        val message: String = binding.messageInput.getText().toString().trim { it <= ' ' }
        if (TextUtils.isEmpty(message)) {
            binding.messageInput.requestFocus()
            return
        }
        binding.messageInput.setText("")

        val messageJson = JSONObject()

        messageJson.put("user_id", userPrefs.getUser()!!.id)
        messageJson.put("message", message)
        messageJson.put("token", "Bearer ${userPrefs.getUser()!!.accessToken}")

        try {
            mSocket!!.emit("msgToServer", messageJson, Ack { args: Array<Any> ->
                val response = args[0] as JSONObject
                Timber.tag("MESSAGE_SOCKET").wtf("emit $response")
            })
        } catch (e: Exception) {
            Timber.tag("MESSAGE_SOCKET").wtf("emit ${e.message}")
        }
    }

    private fun connectChat() {
        val messageJson = JSONObject()

        messageJson.put("sender_id", userPrefs.getUser()!!.id)
        messageJson.put("receiver_id", userId)
        messageJson.put("token", "Bearer ${userPrefs.getUser()!!.accessToken}")

        Timber.tag("MESSAGE_SOCKET").wtf("messageJson $messageJson")

        mSocket!!.emit("connect_users", messageJson)
    }

    private val onNewMessage =
        Emitter.Listener { args ->
            this.runOnUiThread(Runnable {
                Timber.tag("MESSAGE_SOCKET").wtf("onNewMessage")
                val data = args[0] as JSONObject
                try {
                    addMessage(Gson().fromJson(data.toString(), MessageApiResponse.MessageDetail::class.java))
                    Timber.tag("MESSAGE_SOCKET").wtf("onNewMessage success")
                } catch (e: JSONException) {
                    return@Runnable
                }
            })
        }

    private val onJoinedRoom =
        Emitter.Listener { args ->
            this.runOnUiThread(Runnable {
                val joinedID: String = args[0] as String
                Timber.tag("MESSAGE_SOCKET").wtf("onJoinedRoom $joinedID")
            })
        }

    private val onConnect = Emitter.Listener {
        this.runOnUiThread {
            Timber.tag("MESSAGE_SOCKET").wtf("onConnect")
            isConnected = true
            connectChat()
        }
    }

    private val onDisconnect = Emitter.Listener {
        this.runOnUiThread {
            Timber.tag("MESSAGE_SOCKET").wtf("onDisconnect")
        }
    }

    private val onConnectError = Emitter.Listener {
        this.runOnUiThread {
            Timber.tag("MESSAGE_SOCKET").wtf("onConnectError ${it.size}")
        }
    }
}