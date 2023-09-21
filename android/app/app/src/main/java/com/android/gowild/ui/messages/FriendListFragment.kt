package com.android.gowild.ui.messages

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.fragment.app.viewModels
import androidx.viewbinding.ViewBinding
import com.android.gowild.adapters.HomeAdapter
import com.android.gowild.data.model.friends.MyFriendsDataModel
import com.android.gowild.databinding.FragmentFriendsListBinding
import com.android.gowild.interfaces.HomeCallback
import com.android.gowild.networking.Errors
import com.android.gowild.networking.NetworkResult
import com.android.gowild.ui.base.BaseFragment
import com.android.gowild.ui.home.FriendsListVM
import com.android.gowild.ui.user.dialog.ErrorDialog
import com.android.gowild.utils.extension.showBar
import com.android.gowild.utils.local.UserPrefs

class FriendListFragment : BaseFragment() {

    companion object {
        @JvmStatic
        fun newInstance() = FriendListFragment()
    }

    lateinit var binding: FragmentFriendsListBinding
    private val friendsListVM: FriendsListVM by viewModels()
    lateinit var homeAdapter: HomeAdapter
    var messagesInbox: ArrayList<MyFriendsDataModel> = ArrayList()
    private var homeDataList: ArrayList<Any> = ArrayList()

    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentFriendsListBinding.inflate(layoutInflater)
        init()
        return binding
    }

    fun init() {
        setAdapter()
        setCallbacks()
        observeMyFriendsResponse()
        friendsListVM.getFriends()
    }

    private fun setCallbacks() {
        binding.backIv.setOnClickListener {
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }
    }

    fun setAdapter() {
        homeAdapter = HomeAdapter(homeDataList, object : HomeCallback {
            override fun onClickMessage(data: MyFriendsDataModel, position: Int) {
                MessageActivity.start(
                    requireActivity(),
                    "",
                    data.to_user_id,
                    data.to_user.firstName + " " + data.to_user.lastName,
                    data.to_user.picture.toString()
                )
            }
        }, UserPrefs(requireContext()).getUser()!!.id!!)

        binding.rvFriends.itemAnimator = null
        binding.rvFriends.adapter = homeAdapter
    }

    private fun observeMyFriendsResponse() {
        friendsListVM.myFriendsResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    messagesInbox.clear()
                    messagesInbox.addAll(response.data!!.data)

                    homeDataList.clear()
                    homeDataList.addAll(messagesInbox)
                    homeAdapter.notifyDataSetChanged()
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
}