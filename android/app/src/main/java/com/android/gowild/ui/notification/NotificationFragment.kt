package com.android.gowild.ui.notification

import android.content.Intent
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.fragment.app.viewModels
import androidx.viewbinding.ViewBinding
import com.android.gowild.R
import com.android.gowild.data.model.notification.DataNotificationResponseModel
import com.android.gowild.databinding.FragmentNotificationBinding
import com.android.gowild.interfaces.SimpleCallbackValue
import com.android.gowild.networking.Errors
import com.android.gowild.networking.NetworkResult
import com.android.gowild.ui.base.BaseFragment
import com.android.gowild.ui.base.BindingRecyclerAdapter
import com.android.gowild.ui.main.MainActivity
import com.android.gowild.ui.user.dialog.ErrorDialog
import com.android.gowild.utils.extension.showBar
import com.android.gowild.utils.local.UserPrefs
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class NotificationFragment : BaseFragment() {

    companion object {
        @JvmStatic
        fun newInstance() = NotificationFragment()
    }

    lateinit var binding: FragmentNotificationBinding
    private val notificationVM: NotificationVM by viewModels()
    var dataList: ArrayList<DataNotificationResponseModel> = ArrayList()

    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentNotificationBinding.inflate(layoutInflater)

        init()

        return binding
    }

    fun init() {
        val userPref = UserPrefs(requireContext())
        notificationVM.getUserNotification(userPref.getUser()!!.id!!)
        setUpObserver()
        setCallbacks()
    }

    private fun setCallbacks() {
        binding.backIv.setOnClickListener {
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }
    }

    private fun setUpObserver() {
        notificationVM.notificationsResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    hideProgress()
                    dataList.addAll(response.data!!.data.reversed())
                    binding.rvNotification.adapter = BindingRecyclerAdapter(
                        R.layout.notification_row_design,
                        dataList,
                        null,
                        SimpleCallbackValue {
                            val data = it as DataNotificationResponseModel
                            startActivity(Intent(requireActivity(), MainActivity::class.java).putExtra("type", data.type))
                        }
                    )
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
}