package com.android.gowild.ui.home

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.android.gowild.data.model.feeds.CreateFeedPostResponseModel
import com.android.gowild.data.model.feeds.FeedDetailsResponse
import com.android.gowild.data.model.feeds.LikeFeedRequest
import com.android.gowild.data.repo.Repository
import com.android.gowild.networking.NetworkResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class FeedDetailsVM @Inject constructor(private val repository: Repository) : ViewModel() {

    private val _feedDetailsResponse: MutableLiveData<NetworkResult<FeedDetailsResponse>> = MutableLiveData()
    val feedDetailsResponse: LiveData<NetworkResult<FeedDetailsResponse>> = _feedDetailsResponse

    fun getFeedDetails(postID : String) = viewModelScope.launch {
        repository.getFeedDetails(postID).collect { _feedDetailsResponse.value = it }
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
}