package com.android.gowild.ui.home

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.android.gowild.data.model.feeds.AddCommentRequest
import com.android.gowild.data.model.feeds.AddCommentResponse
import com.android.gowild.data.model.feeds.CommentsResponse
import com.android.gowild.data.repo.Repository
import com.android.gowild.networking.NetworkResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class CommentsVM @Inject constructor(private val repository: Repository) : ViewModel() {

    private val _commentsResponse: MutableLiveData<NetworkResult<CommentsResponse>> = MutableLiveData()
    val commentsResponse: LiveData<NetworkResult<CommentsResponse>> = _commentsResponse
    fun getFeedComments(postID: String) = viewModelScope.launch {
        repository.getFeedComments(postID).collect { _commentsResponse.value = it }
    }

    private val _addCommentResponse: MutableLiveData<NetworkResult<AddCommentResponse>> = MutableLiveData()
    val addCommentResponse: LiveData<NetworkResult<AddCommentResponse>> = _addCommentResponse
    fun addComment(addCommentRequest: AddCommentRequest) = viewModelScope.launch {
        repository.addComment(addCommentRequest).collect { _addCommentResponse.value = it }
    }
}