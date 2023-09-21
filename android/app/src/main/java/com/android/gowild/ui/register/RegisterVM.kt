package com.android.gowild.ui.register

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.android.gowild.data.model.register.RegisterRequest
import com.android.gowild.data.model.user.User
import com.android.gowild.data.repo.Repository
import com.android.gowild.networking.NetworkResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class RegisterVM @Inject constructor(private val repository: Repository) : ViewModel() {

    private val _registerResponse: MutableLiveData<NetworkResult<User>> = MutableLiveData()
    val registerResponse: LiveData<NetworkResult<User>> = _registerResponse
    fun register(request: RegisterRequest) = viewModelScope.launch {
        repository.register(request).collect { _registerResponse.value = it }
    }
}