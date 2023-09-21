package com.android.gowild.ui.register

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.android.gowild.data.model.register.VerifyMobileOtpRequest
import com.android.gowild.data.repo.Repository
import com.android.gowild.networking.NetworkResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import okhttp3.ResponseBody
import javax.inject.Inject


@HiltViewModel
class VerifyMobileOtpVM @Inject constructor(private val repository: Repository) : ViewModel() {

    private val _verifyMobileOtpResponse: MutableLiveData<NetworkResult<ResponseBody>> = MutableLiveData()
    val verifyMobileOtpResponse: LiveData<NetworkResult<ResponseBody>> = _verifyMobileOtpResponse
    fun verifyMobileOtp(verifyMobileOtpRequest: VerifyMobileOtpRequest) = viewModelScope.launch {
        repository.verifyMobileOtp(verifyMobileOtpRequest).collect { _verifyMobileOtpResponse.value = it }
    }
}