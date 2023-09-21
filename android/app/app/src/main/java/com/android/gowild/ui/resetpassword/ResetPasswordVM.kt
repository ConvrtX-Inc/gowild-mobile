package com.android.gowild.ui.resetpassword

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.android.gowild.data.model.base.JunkResponse
import com.android.gowild.data.repo.Repository
import com.android.gowild.networking.NetworkResult
import com.android.gowild.networking.NetworkState
import com.android.gowild.networking.Resource
import com.android.gowild.utils.extension.getJunkResponse
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import okhttp3.ResponseBody
import javax.inject.Inject

@HiltViewModel
class ResetPasswordVM @Inject constructor(private val repository: Repository) : ViewModel() {


    private val _forgotPasswordResponse: MutableLiveData<NetworkResult<ResponseBody>> = MutableLiveData()
    val forgotPasswordResponse: LiveData<NetworkResult<ResponseBody>> = _forgotPasswordResponse
    fun forgotPassword(email: String, number: String) = viewModelScope.launch {
        repository.forgotPassword(email, number).collect { _forgotPasswordResponse.value = it }
    }

    private val _resetPasswordResponse: MutableLiveData<NetworkResult<ResponseBody>> = MutableLiveData()
    val resetPasswordResponse: LiveData<NetworkResult<ResponseBody>> = _resetPasswordResponse
    fun resetPassword(password: String, otp: String, email: String, phone: String) = viewModelScope.launch {
        repository.resetPassword(password, otp, email, phone).collect { _resetPasswordResponse.value = it }
    }

}