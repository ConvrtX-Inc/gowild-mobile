package com.android.gowild.ui.verifycode

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.android.gowild.data.model.register.VerifyOtpResponse
import com.android.gowild.data.repo.Repository
import com.android.gowild.networking.NetworkResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import okhttp3.ResponseBody
import javax.inject.Inject

// TODO: unused viewmodel, consider deleting
@HiltViewModel
class VerifyCodeVM @Inject constructor(private val repository: Repository) : ViewModel() {

    private val _resendOtpResponse: MutableLiveData<NetworkResult<ResponseBody>> = MutableLiveData()
    val resendOtpResponse: LiveData<NetworkResult<ResponseBody>> = _resendOtpResponse
    fun resendOtp(number: String) = viewModelScope.launch {
        repository.resendOtp(number).collect { _resendOtpResponse.value = it }
    }

    private val _verifyOtpResponse: MutableLiveData<NetworkResult<VerifyOtpResponse>> = MutableLiveData()
    val verifyOtpResponse: LiveData<NetworkResult<VerifyOtpResponse>> = _verifyOtpResponse
    fun verifyOtp(otp: String, number: String) = viewModelScope.launch {
        repository.verifyOtp(otp, number).collect { _verifyOtpResponse.value = it }
    }
}