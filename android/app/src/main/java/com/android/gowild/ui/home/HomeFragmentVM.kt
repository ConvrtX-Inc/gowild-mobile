package com.android.gowild.ui.home

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.android.gowild.data.model.feeds.CreateFeedPostRequestModel
import com.android.gowild.data.model.feeds.CreateFeedPostResponseModel
import com.android.gowild.data.model.feeds.FeedsResponseModel
import com.android.gowild.data.model.feeds.LikeFeedRequest
import com.android.gowild.data.model.friends.DeleteSuggestedFriendModel
import com.android.gowild.data.model.friends.FriendsListModel
import com.android.gowild.data.model.friends.MyFriendsResponse
import com.android.gowild.data.model.friends.SendRequestResponseModel
import com.android.gowild.data.model.homeModels.MessagesInboxResponseModel
import com.android.gowild.data.model.myTrail.UnSaveRouteRequestModel
import com.android.gowild.data.model.myTrail.UnSaveRouteResponseModel
import com.android.gowild.data.model.routes.ApprovedRoutesResponse
import com.android.gowild.data.model.treasureWild.TreasureWildResponse
import com.android.gowild.data.repo.Repository
import com.android.gowild.networking.Errors
import com.android.gowild.networking.NetworkResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.async
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.launch
import okhttp3.MultipartBody
import timber.log.Timber
import javax.inject.Inject

@HiltViewModel
class HomeFragmentVM @Inject constructor(private val repository: Repository) : ViewModel() {

    private val _feedsAndFriendsChainedResponse = MutableLiveData<Pair<NetworkResult<FeedsResponseModel>, NetworkResult<FriendsListModel>>>()
    val feedsAndFriendsChainedResponse: LiveData<Pair<NetworkResult<FeedsResponseModel>, NetworkResult<FriendsListModel>>> get() = _feedsAndFriendsChainedResponse

    fun getFeedsAndFriendsChainedResponse() = viewModelScope.launch {
        Timber.tag("CHAINED").wtf("start")
        try {
            val feedsResponse = async { repository.getFeeds() }
            val friendsResponse = async { repository.getSuggestedFriends() }

            val feeds = feedsResponse.await()
            val friends = friendsResponse.await()

            feeds.combine(friends) { fed, frd ->
                Pair(fed, frd)
            }.collect {
                _feedsAndFriendsChainedResponse.value = it
            }

        } catch (e: Exception) {
            Timber.tag("CHAINED").wtf("exception")
            _feedsAndFriendsChainedResponse.postValue(
                Pair(
                    NetworkResult.Error("Exception", Errors.Error(e)),
                    NetworkResult.Error("Exception", Errors.Error(e))
                )
            )
        }
    }

    private val _feedsResponse: MutableLiveData<NetworkResult<FeedsResponseModel>> = MutableLiveData()
    val feedsResponse: LiveData<NetworkResult<FeedsResponseModel>> = _feedsResponse
    fun getFeeds() = viewModelScope.launch {
        repository.getFeeds().collect { _feedsResponse.value = it }
    }

    private val _createFeedsResponse: MutableLiveData<NetworkResult<CreateFeedPostResponseModel>> = MutableLiveData()
    val createFeedsResponse: LiveData<NetworkResult<CreateFeedPostResponseModel>> = _createFeedsResponse

    fun createFeed(createFeedPostRequestModel: CreateFeedPostRequestModel) = viewModelScope.launch {
        repository.createFeed(createFeedPostRequestModel).collect { _createFeedsResponse.value = it }
    }

    private val _updateFeedImageResponse: MutableLiveData<NetworkResult<CreateFeedPostResponseModel>> = MutableLiveData()
    val updateFeedImageResponse: LiveData<NetworkResult<CreateFeedPostResponseModel>> = _updateFeedImageResponse
    fun updateFeedImage(id: String, file: MultipartBody.Part) = viewModelScope.launch {
        repository.updateFeedImage(id, file).collect { _updateFeedImageResponse.value = it }
    }

    private val _updateFeedAttachmentResponse: MutableLiveData<NetworkResult<CreateFeedPostResponseModel>> = MutableLiveData()
    val updateFeedAttachmentResponse: LiveData<NetworkResult<CreateFeedPostResponseModel>> = _updateFeedAttachmentResponse
    fun updateFeedAttachment(id: String, file: MultipartBody.Part) = viewModelScope.launch {
        repository.updateFeedAttachment(id, file).collect { _updateFeedAttachmentResponse.value = it }
    }

    private val _likeFeedResponse: MutableLiveData<NetworkResult<CreateFeedPostResponseModel>> = MutableLiveData()
    val likeFeedResponse: LiveData<NetworkResult<CreateFeedPostResponseModel>> = _likeFeedResponse
    fun likeFeed(likeFeedRequest: LikeFeedRequest, position: Int) = viewModelScope.launch {
        repository.likeFeed(likeFeedRequest).collect {
            it.extra = position
            _likeFeedResponse.value = it
        }
    }

    private val _viewFeedResponse: MutableLiveData<NetworkResult<CreateFeedPostResponseModel>> = MutableLiveData()
    val viewFeedResponse: LiveData<NetworkResult<CreateFeedPostResponseModel>> = _viewFeedResponse
    fun viewFeed(postID: String, position: Int) = viewModelScope.launch {
        repository.viewFeed(postID).collect {
            it.extra = position
            _viewFeedResponse.value = it
        }
    }

    private val _suggestedFriendsResponse: MutableLiveData<NetworkResult<FriendsListModel>> = MutableLiveData()
    val suggestedFriendsResponse: LiveData<NetworkResult<FriendsListModel>> = _suggestedFriendsResponse
    fun getSuggestedFriends() = viewModelScope.launch {
        repository.getSuggestedFriends().collect { _suggestedFriendsResponse.value = it }
    }

    private val _messageInboxResponse: MutableLiveData<NetworkResult<MessagesInboxResponseModel>> = MutableLiveData()
    val messageInboxResponse: LiveData<NetworkResult<MessagesInboxResponseModel>> = _messageInboxResponse
    fun getMessagesInbox() = viewModelScope.launch {
        repository.getMessagesInbox().collect { _messageInboxResponse.value = it }
    }

    private val _myFriendsResponse: MutableLiveData<NetworkResult<MyFriendsResponse>> = MutableLiveData()
    val myFriendsResponse: LiveData<NetworkResult<MyFriendsResponse>> = _myFriendsResponse
    fun getFriends() = viewModelScope.launch {
        repository.getFriends().collect { _myFriendsResponse.value = it }
    }

    private val _sendFriendRequestResponse: MutableLiveData<NetworkResult<SendRequestResponseModel>> = MutableLiveData()
    val sendFriendRequestResponse: LiveData<NetworkResult<SendRequestResponseModel>> = _sendFriendRequestResponse
    fun sendFriendRequest(email: String) = viewModelScope.launch {
        repository.sendFriendRequest(email).collect { _sendFriendRequestResponse.value = it }
    }

    private val _deleteSuggestedFriendResponse: MutableLiveData<NetworkResult<DeleteSuggestedFriendModel>> = MutableLiveData()
    val deleteSuggestedFriendResponse: LiveData<NetworkResult<DeleteSuggestedFriendModel>> = _deleteSuggestedFriendResponse
    fun deleteSuggestedFriend(userId: String) = viewModelScope.launch {
        repository.deleteSuggestedFriend(userId).collect { _deleteSuggestedFriendResponse.value = it }
    }

    private val _treasureWildListingResponse: MutableLiveData<NetworkResult<TreasureWildResponse>> = MutableLiveData()
    val treasureWildListingResponse: LiveData<NetworkResult<TreasureWildResponse>> = _treasureWildListingResponse
    fun getTreasureWildListing(page: Int) = viewModelScope.launch {
        repository.getTreasureWildListings(page).collect { _treasureWildListingResponse.value = it }
    }

    private val _approvedRoutesResponse: MutableLiveData<NetworkResult<ApprovedRoutesResponse>> = MutableLiveData()
    val approvedRoutesResponse: LiveData<NetworkResult<ApprovedRoutesResponse>> = _approvedRoutesResponse
    fun getApprovedRoutes(lat: Double, long: Double, page: Int) = viewModelScope.launch {
        repository.getApprovedRoutes(lat, long, page).collect { _approvedRoutesResponse.value = it }
    }

    private val _saveUnSaveRouteResponse: MutableLiveData<NetworkResult<UnSaveRouteResponseModel>> = MutableLiveData()
    val saveUnSaveRouteResponse: LiveData<NetworkResult<UnSaveRouteResponseModel>> = _saveUnSaveRouteResponse
    fun saveUnSaveRoute(unSaveRouteRequestModel: UnSaveRouteRequestModel, position: Int) = viewModelScope.launch {
        repository.unSaveRoutes(unSaveRouteRequestModel).collect {
            it.extra = position
            _saveUnSaveRouteResponse.value = it
        }
    }

}