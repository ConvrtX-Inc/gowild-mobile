package com.android.gowild.ui.login

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.android.gowild.data.model.user.User
import com.android.gowild.data.repo.Repository
import com.android.gowild.networking.NetworkResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import javax.inject.Inject


@HiltViewModel
class AuthVM @Inject constructor(private val repository: Repository) : ViewModel() {

    private val _authResponse: MutableLiveData<NetworkResult<User>> = MutableLiveData()
    val authResponse: LiveData<NetworkResult<User>> = _authResponse
    fun auth(accessToken: String) = viewModelScope.launch {
        repository.auth(accessToken).collect { _authResponse.value = it }
    }

}