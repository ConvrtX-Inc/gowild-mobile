package com.android.gowild.ui.home

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.android.gowild.data.model.friendRequestReceived.FriendRequestReceivedModel
import com.android.gowild.data.model.friends.*
import com.android.gowild.data.repo.Repository
import com.android.gowild.networking.NetworkResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class SuggestedFriendsVM @Inject constructor(private val repository: Repository) : ViewModel() {

    private val _suggestedFriendsResponse: MutableLiveData<NetworkResult<FriendsListModel>> = MutableLiveData()
    val suggestedFriendsResponse: LiveData<NetworkResult<FriendsListModel>> = _suggestedFriendsResponse
    fun getSuggestedFriends() = viewModelScope.launch {
        repository.getSuggestedFriends().collect { _suggestedFriendsResponse.value = it }
    }

    private val _friendRequestResponse: MutableLiveData<NetworkResult<FriendRequestReceivedModel>> = MutableLiveData()
    val friendRequestResponse: LiveData<NetworkResult<FriendRequestReceivedModel>> = _friendRequestResponse
    fun getFriendRequests() = viewModelScope.launch {
        repository.getFriendRequests().collect { _friendRequestResponse.value = it }
    }

    private val _sendFriendRequestResponse: MutableLiveData<NetworkResult<SendRequestResponseModel>> = MutableLiveData()
    val sendFriendRequestResponse: LiveData<NetworkResult<SendRequestResponseModel>> = _sendFriendRequestResponse
    fun sendFriendRequest(email: String, position: Int) = viewModelScope.launch {
        repository.sendFriendRequest(email).collect {
            it.extra = position
            _sendFriendRequestResponse.value = it
        }
    }

    private val _deleteSuggestedFriendResponse: MutableLiveData<NetworkResult<DeleteSuggestedFriendModel>> = MutableLiveData()
    val deleteSuggestedFriendResponse: LiveData<NetworkResult<DeleteSuggestedFriendModel>> = _deleteSuggestedFriendResponse
    fun deleteSuggestedFriend(userId: String, position: Int) = viewModelScope.launch {
        repository.deleteSuggestedFriend(userId).collect {
            it.extra = position
            _deleteSuggestedFriendResponse.value = it
        }
    }

    private val _deleteFriendRequestResponse: MutableLiveData<NetworkResult<DeleteRequestResponseModel>> = MutableLiveData()
    val deleteFriendRequestResponse: LiveData<NetworkResult<DeleteRequestResponseModel>> = _deleteFriendRequestResponse
    fun deleteFriendRequest(userId: String, position: Int) = viewModelScope.launch {
        repository.deleteFriendRequest(userId).collect {
            it.extra = position
            _deleteFriendRequestResponse.value = it
        }
    }

    private val _acceptFriendRequestResponse: MutableLiveData<NetworkResult<AcceptRequestResponseModel>> = MutableLiveData()
    val acceptFriendRequestResponse: LiveData<NetworkResult<AcceptRequestResponseModel>> = _acceptFriendRequestResponse
    fun acceptFriendRequest(userId: String, position: Int) = viewModelScope.launch {
        repository.acceptFriendRequest(userId).collect {
            it.extra = position
            _acceptFriendRequestResponse.value = it
        }
    }

}