package com.android.gowild.ui.support

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.android.gowild.data.model.support.SupportMessagesListResponse
import com.android.gowild.data.repo.Repository
import com.android.gowild.networking.NetworkResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class SupportDetailsVM @Inject constructor(private val repository: Repository) : ViewModel() {

    private val _supportChatResponse: MutableLiveData<NetworkResult<SupportMessagesListResponse>> = MutableLiveData()
    val supportChatResponse: LiveData<NetworkResult<SupportMessagesListResponse>> = _supportChatResponse

    fun getSupportChat(ticketID: String) = viewModelScope.launch {
        repository.getSupportChat(ticketID).collect { _supportChatResponse.value = it }
    }
}