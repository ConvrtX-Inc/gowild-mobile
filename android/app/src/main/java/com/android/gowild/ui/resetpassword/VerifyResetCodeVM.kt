package com.android.gowild.ui.resetpassword

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.android.gowild.data.model.register.VerifyMobileOtpRequest
import com.android.gowild.networking.NetworkState
import com.android.gowild.networking.Resource
import com.android.gowild.data.repo.Repository
import com.android.gowild.networking.NetworkResult
import com.android.gowild.utils.extension.getJunkResponse
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import okhttp3.ResponseBody
import javax.inject.Inject

@HiltViewModel
class VerifyResetCodeVM @Inject constructor(private val repository: Repository) : ViewModel() {

    private val _verifyResetCodeResponse: MutableLiveData<NetworkResult<ResponseBody>> = MutableLiveData()
    val verifyResetCodeResponse: LiveData<NetworkResult<ResponseBody>> = _verifyResetCodeResponse
    fun verifyResetCode(otp: String, number: String) = viewModelScope.launch {
        repository.resetVerifyOtp(otp, number).collect { _verifyResetCodeResponse.value = it }
    }
}