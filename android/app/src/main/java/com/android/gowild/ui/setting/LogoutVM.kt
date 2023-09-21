package com.android.gowild.ui.setting

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.android.gowild.data.model.login.LoginRequest
import com.android.gowild.data.model.user.Token
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
class LogoutVM @Inject constructor(private val repository: Repository) : ViewModel() {

    private val _logoutResponse: MutableLiveData<NetworkResult<ResponseBody>> = MutableLiveData()
    val logoutResponse: LiveData<NetworkResult<ResponseBody>> = _logoutResponse
    fun logout(accessToken: String) = viewModelScope.launch {
        repository.logout(accessToken).collect { _logoutResponse.value = it }
    }
}