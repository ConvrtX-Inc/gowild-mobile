package com.android.gowild.ui.login

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.android.gowild.data.model.login.LoginRequest
import com.android.gowild.data.model.user.Token
import com.android.gowild.data.repo.Repository
import com.android.gowild.networking.BaseApiResponse
import com.android.gowild.networking.NetworkResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class LoginVM @Inject constructor(private val repository: Repository) : ViewModel() {

    private val _loginResponse: MutableLiveData<NetworkResult<Token>> = MutableLiveData()
    val loginResponse: LiveData<NetworkResult<Token>> = _loginResponse
    fun login(request: LoginRequest) = viewModelScope.launch {
        repository.login(request).collect { _loginResponse.value = it }
    }

}