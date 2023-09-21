package com.android.gowild.ui.messages

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.android.gowild.data.model.message.MessageApiResponse
import com.android.gowild.data.repo.Repository
import com.android.gowild.networking.NetworkResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class MessagesListVM @Inject constructor(private val repository: Repository) : ViewModel() {

    private val _messageResponse: MutableLiveData<NetworkResult<MessageApiResponse>> = MutableLiveData()
    val messageResponse: LiveData<NetworkResult<MessageApiResponse>> = _messageResponse
    fun getMessages(id: String) = viewModelScope.launch {
        repository.getFriendsMessages(id).collect { _messageResponse.value = it }
    }
}