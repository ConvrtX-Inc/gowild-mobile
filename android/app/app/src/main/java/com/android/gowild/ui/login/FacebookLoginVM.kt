package com.android.gowild.ui.login

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.android.gowild.data.model.login.FacebookLoginRequest
import com.android.gowild.data.model.login.FacebookLoginResponse
import com.android.gowild.data.repo.Repository
import com.android.gowild.networking.NetworkResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class FacebookLoginVM @Inject constructor(private val repository: Repository) : ViewModel() {

    private val _facebookLoginResponse: MutableLiveData<NetworkResult<FacebookLoginResponse>> = MutableLiveData()
    val facebookLoginResponse: LiveData<NetworkResult<FacebookLoginResponse>> = _facebookLoginResponse
    fun facebookLogin(facebookLoginRequest: FacebookLoginRequest) = viewModelScope.launch {
        repository.facebookLogin(facebookLoginRequest).collect { _facebookLoginResponse.value = it }
    }

}