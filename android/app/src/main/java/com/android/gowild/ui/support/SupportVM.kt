package com.android.gowild.ui.support

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.android.gowild.data.model.support.SupportCreateNewTicketRequestModel
import com.android.gowild.data.model.support.SupportCreateNewTicketResponseModel
import com.android.gowild.data.model.support.SupportResponseModel
import com.android.gowild.data.model.support.SupportUploadImagesResponseModel
import com.android.gowild.data.repo.Repository
import com.android.gowild.networking.NetworkResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import okhttp3.MultipartBody
import okhttp3.RequestBody
import javax.inject.Inject

@HiltViewModel
class SupportVM @Inject constructor(private val repository: Repository) : ViewModel() {

    private val _supportTicketResponse: MutableLiveData<NetworkResult<SupportResponseModel>> = MutableLiveData()
    val supportTicketResponse: LiveData<NetworkResult<SupportResponseModel>> = _supportTicketResponse
    fun getSupportTickets(user_id: String) = viewModelScope.launch {
        repository.getSupportTickets(user_id).collect { _supportTicketResponse.value = it }
    }

    private val _supportCreateNewTicketResponse: MutableLiveData<NetworkResult<SupportCreateNewTicketResponseModel>> = MutableLiveData()
    val supportCreateNewTicketResponse: LiveData<NetworkResult<SupportCreateNewTicketResponseModel>> = _supportCreateNewTicketResponse
    fun createNewTicket(request: SupportCreateNewTicketRequestModel) = viewModelScope.launch {
        repository.createNewTicket(request).collect { _supportCreateNewTicketResponse.value = it }
    }

    private val _supportUpdateTicketImageResponse: MutableLiveData<NetworkResult<SupportUploadImagesResponseModel>> = MutableLiveData()
    val supportUpdateTicketImageResponse: LiveData<NetworkResult<SupportUploadImagesResponseModel>> = _supportUpdateTicketImageResponse
    fun updateTicketImages(id: String, message_id: RequestBody, images: ArrayList<MultipartBody.Part>) = viewModelScope.launch {
        repository.updateTicketImages(id, message_id, images).collect { _supportUpdateTicketImageResponse.value = it }
    }
}