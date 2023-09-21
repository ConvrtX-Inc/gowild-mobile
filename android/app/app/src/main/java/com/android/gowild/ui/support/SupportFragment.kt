package com.android.gowild.ui.support

import android.content.Intent
import android.provider.Settings
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.fragment.app.viewModels
import androidx.viewbinding.ViewBinding
import com.android.gowild.R
import com.android.gowild.data.model.support.SupportDataModel
import com.android.gowild.databinding.FragmentSupportBinding
import com.android.gowild.interfaces.SimpleCallbackValue
import com.android.gowild.networking.Errors
import com.android.gowild.networking.NetworkResult
import com.android.gowild.ui.base.BaseFragment
import com.android.gowild.ui.base.BindingRecyclerAdapter
import com.android.gowild.ui.setting.SettingsActivity
import com.android.gowild.ui.user.dialog.ErrorDialog
import com.android.gowild.utils.extension.setRecyclerViewAdapter
import com.android.gowild.utils.extension.showBar
import com.android.gowild.utils.local.UserPrefs

class SupportFragment : BaseFragment() {

    companion object {
        @JvmStatic
        fun newInstance() = SupportFragment()
    }

    private lateinit var adapter: BindingRecyclerAdapter<SupportDataModel, SimpleCallbackValue>
    lateinit var binding: FragmentSupportBinding
    private val supportVM: SupportVM by viewModels()
    val dataList: ArrayList<SupportDataModel> = ArrayList()

    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentSupportBinding.inflate(layoutInflater)
        init()
        return binding
    }

    fun init() {
        val userPrefs = UserPrefs(requireContext())
        setCallbacks()
        setupObservers()
        setAdapter()
        supportVM.getSupportTickets(userPrefs.getUser()!!.id!!)
    }

    private fun setAdapter() {
        adapter = binding.rvSupport.setRecyclerViewAdapter(
            R.layout.item_list_support_tickets,
            dataList,
            null,
            SimpleCallbackValue {
                startActivity(Intent(requireActivity(), SupportDetailsFragment::class.java).putExtra("ticketID", it as String))
            }
        )
    }

    private fun setCallbacks() {
        binding.btnSend.setOnClickListener {
            SettingsActivity.replaceFragment(
                requireActivity(),
                SendNewTicketFragment.newInstance()
            )
        }

        binding.backIv.setOnClickListener {
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }
    }

    private fun setupObservers() {
        supportVM.supportTicketResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    hideProgress()
                    dataList.clear()
                    dataList.addAll(response.data!!.data)
                    adapter.notifyDataSetChanged()
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