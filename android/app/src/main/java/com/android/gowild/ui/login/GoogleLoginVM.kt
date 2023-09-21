package com.android.gowild.ui.login

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.android.gowild.data.model.login.GoogleLoginRequest
import com.android.gowild.data.model.login.GoogleLoginResponse
import com.android.gowild.data.repo.Repository
import com.android.gowild.networking.NetworkResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import javax.inject.Inject


@HiltViewModel
class GoogleLoginVM @Inject constructor(private val repository: Repository) : ViewModel() {

    private val _googleLoginResponse: MutableLiveData<NetworkResult<GoogleLoginResponse>> = MutableLiveData()
    val googleLoginResponse: LiveData<NetworkResult<GoogleLoginResponse>> = _googleLoginResponse
    fun googleLogin(googleLoginRequest: GoogleLoginRequest) = viewModelScope.launch {
        repository.googleLogin(googleLoginRequest).collect { _googleLoginResponse.value = it }
    }
}