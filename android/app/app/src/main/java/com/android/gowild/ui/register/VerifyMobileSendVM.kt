package com.android.gowild.ui.register

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.android.gowild.data.model.register.RegisterRequest
import com.android.gowild.networking.NetworkState
import com.android.gowild.networking.Resource
import com.android.gowild.data.model.register.VerifyMobileSendRequest
import com.android.gowild.data.model.user.User
import com.android.gowild.data.repo.Repository
import com.android.gowild.networking.NetworkResult
import com.android.gowild.utils.extension.getJunkResponse
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import okhttp3.ResponseBody
import javax.inject.Inject

@HiltViewModel
class VerifyMobileSendVM @Inject constructor(private val repository: Repository) : ViewModel() {

    private val _verifyMobileSendResponse: MutableLiveData<NetworkResult<ResponseBody>> = MutableLiveData()
    val verifyMobileSendResponse: LiveData<NetworkResult<ResponseBody>> = _verifyMobileSendResponse
    fun verifyMobileSend(verifyMobileSendRequest: VerifyMobileSendRequest) = viewModelScope.launch {
        repository.verifyMobileSend(verifyMobileSendRequest).collect { _verifyMobileSendResponse.value = it }
    }

}