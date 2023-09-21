package com.android.gowild.ui.user

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.android.gowild.data.model.user.SelfieVerificationResponse
import com.android.gowild.data.repo.Repository
import com.android.gowild.networking.NetworkResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import okhttp3.MultipartBody
import javax.inject.Inject

@HiltViewModel
class SelfieVerificationVM @Inject constructor(private val repository: Repository) : ViewModel() {

    private val _userImageVerificationResponse: MutableLiveData<NetworkResult<SelfieVerificationResponse>> = MutableLiveData()
    val userImageVerificationResponse: LiveData<NetworkResult<SelfieVerificationResponse>> = _userImageVerificationResponse
    fun userImageVerification(image1: MultipartBody.Part, image2: MultipartBody.Part) = viewModelScope.launch {
        repository.userImageVerification(image1, image2).collect { _userImageVerificationResponse.value = it }
    }
}


