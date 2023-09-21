package com.android.gowild.ui.home

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.core.widget.doAfterTextChanged
import androidx.fragment.app.viewModels
import androidx.recyclerview.widget.ConcatAdapter
import androidx.viewbinding.ViewBinding
import com.android.gowild.R
import com.android.gowild.data.model.friendRequestReceived.RecievedModel
import com.android.gowild.data.model.friends.FriendsDataModel
import com.android.gowild.databinding.FragmentFriendRequestBinding
import com.android.gowild.interfaces.FriendRequestCallback
import com.android.gowild.interfaces.FriendRequestReceivedCallback
import com.android.gowild.networking.Errors
import com.android.gowild.networking.NetworkResult
import com.android.gowild.ui.base.BaseFragment
import com.android.gowild.ui.base.BindingRecyclerAdapter
import com.android.gowild.ui.user.dialog.ErrorDialog
import com.android.gowild.utils.extension.showBar
import timber.log.Timber

class FriendRequestFragment : BaseFragment() {

    companion object {
        @JvmStatic
        fun newInstance() = FriendRequestFragment()
    }

    private lateinit var binding: FragmentFriendRequestBinding
    private val suggestedFriendsVM: SuggestedFriendsVM by viewModels()
    private val friendsListVM: FriendsListVM by viewModels()

    private lateinit var suggestedAdapter: BindingRecyclerAdapter<FriendsDataModel, FriendRequestCallback>
    private lateinit var requestedAdapter: BindingRecyclerAdapter<RecievedModel, FriendRequestReceivedCallback>
    private lateinit var suggestedHeaderAdapter: BindingRecyclerAdapter<String, Nothing>

    private var suggestedList: ArrayList<FriendsDataModel> = ArrayList()
    private var suggestedListTemp: ArrayList<FriendsDataModel> = ArrayList()
    private var requestedList: ArrayList<RecievedModel> = ArrayList()
    private var requestedListTemp: ArrayList<RecievedModel> = ArrayList()

    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentFriendRequestBinding.inflate(layoutInflater)
        init()
        return binding
    }

    private fun init() {
        setAdapters()
        setObservers()
        setCallbacks()
        suggestedFriendsVM.getSuggestedFriends()
        suggestedFriendsVM.getFriendRequests()
    }

    private fun setCallbacks() {
        binding.etSearch.doAfterTextChanged { text ->
            suggestedList.clear()
            suggestedList.addAll(suggestedListTemp.filter {
                it.firstName!!.lowercase().contains(text.toString().lowercase()) || it.lastName!!.lowercase().contains(text.toString().lowercase())
                        || (it.firstName.lowercase() + " " + it.lastName.lowercase()).contains(text.toString().lowercase())
            })
            suggestedAdapter.notifyDataSetChanged()

            requestedList.clear()
            requestedList.addAll(requestedListTemp.filter {
                it.firstName!!.lowercase().contains(text.toString().lowercase()) || it.lastName!!.lowercase().contains(text.toString().lowercase())
                        || (it.firstName.lowercase() + " " + it.lastName.lowercase()).contains(text.toString().lowercase())
            })
            requestedAdapter.notifyDataSetChanged()
            Timber.tag("SEARCH").wtf("-----------------------")
            Timber.tag("SEARCH").wtf("$text  =  suggested = ${suggestedList.size}")
            Timber.tag("SEARCH").wtf("$text  =  requested = ${requestedList.size}")
            Timber.tag("SEARCH").wtf("-----------------------")
        }

        binding.backIv.setOnClickListener {
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }
    }

    private fun setObservers() {
        observeSuggestedFriends()
        observeFriendRequestResponse()
        observeSendFriendRequestResponse()
        observeDeleteSuggestedFriendResponse()
        observeAcceptFriendRequestResponse()
        observeDeleteFriendRequestResponse()
    }

    private fun setAdapters() {
        requestedAdapter = BindingRecyclerAdapter(
            R.layout.list_item_friend_request_received,
            requestedList,
            listener = object : FriendRequestReceivedCallback {
                override fun onAdd(recieved: RecievedModel, position: Int) {
                    suggestedFriendsVM.acceptFriendRequest(recieved.id!!, position)
                }

                override fun onDelete(recieved: RecievedModel, position: Int) {
                    suggestedFriendsVM.deleteFriendRequest(recieved.id!!, position)
                }
            }
        )

        suggestedHeaderAdapter = BindingRecyclerAdapter(
            R.layout.list_item_suggested_header,
            arrayListOf("Suggested Friends")
        )

        suggestedAdapter = BindingRecyclerAdapter(
            R.layout.list_item_friend_request,
            suggestedList,
            listener = object : FriendRequestCallback {
                override fun onAdd(friendsDataModel: FriendsDataModel, position: Int) {
                    suggestedFriendsVM.sendFriendRequest(friendsDataModel.email!!, position)
                }

                override fun onDelete(friendsDataModel: FriendsDataModel, position: Int) {
                    suggestedFriendsVM.deleteSuggestedFriend(friendsDataModel.id!!, position)
                }

            }
        )

        val adapter = ConcatAdapter(requestedAdapter, suggestedHeaderAdapter, suggestedAdapter)
        binding.rvSuggested.adapter = adapter
    }

    private fun observeSuggestedFriends() {
        suggestedFriendsVM.suggestedFriendsResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    suggestedList.clear()
                    suggestedList.addAll(response.data!!.data)
                    suggestedListTemp.clear()
                    suggestedListTemp.addAll(response.data.data)
                    suggestedAdapter.notifyDataSetChanged()
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

    private fun observeFriendRequestResponse() {
        suggestedFriendsVM.friendRequestResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    requestedList.clear()
                    requestedList.addAll(response.data!!.recieved)
                    requestedListTemp.clear()
                    requestedListTemp.addAll(response.data.recieved)
                    requestedAdapter.notifyDataSetChanged()
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

    private fun observeSendFriendRequestResponse() {
        suggestedFriendsVM.sendFriendRequestResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    hideProgress()
                    suggestedList.removeAt(response.extra as Int)
                    suggestedAdapter.notifyItemRemoved(response.extra as Int)
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

    private fun observeDeleteSuggestedFriendResponse() {
        suggestedFriendsVM.deleteSuggestedFriendResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    hideProgress()
                    suggestedList.removeAt(response.extra as Int)
                    suggestedAdapter.notifyItemRemoved(response.extra as Int)
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

    private fun observeDeleteFriendRequestResponse() {
        suggestedFriendsVM.deleteFriendRequestResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    hideProgress()
                    requestedList.removeAt(response.extra as Int)
                    requestedAdapter.notifyItemRemoved(response.extra as Int)
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

    private fun observeAcceptFriendRequestResponse() {
        suggestedFriendsVM.acceptFriendRequestResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    hideProgress()
                    requestedList.removeAt(response.extra as Int)
                    requestedAdapter.notifyItemRemoved(response.extra as Int)
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