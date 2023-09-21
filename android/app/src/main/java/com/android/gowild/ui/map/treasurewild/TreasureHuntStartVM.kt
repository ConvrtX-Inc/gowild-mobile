package com.android.gowild.ui.map.treasurewild

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.android.gowild.data.repo.Repository
import com.android.gowild.networking.NetworkResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import okhttp3.ResponseBody
import javax.inject.Inject

@HiltViewModel
class TreasureHuntStartVM @Inject constructor(private val repository: Repository) : ViewModel() {

    private val _verifyMobileOtpResponse: MutableLiveData<NetworkResult<ResponseBody>> = MutableLiveData()
    val verifyMobileOtpResponse: LiveData<NetworkResult<ResponseBody>> = _verifyMobileOtpResponse
    fun verifyMobileOtp(huntId: String, otp: String) = viewModelScope.launch {
        repository.verifyHuntStartOtp(huntId, otp).collect { _verifyMobileOtpResponse.value = it }
    }

    private val _resendTreasureHuntResponse: MutableLiveData<NetworkResult<ResponseBody>> = MutableLiveData()
    val resendTreasureHuntResponse: LiveData<NetworkResult<ResponseBody>> = _resendTreasureHuntResponse
    fun resendTreasureHuntOtp(huntId: String) = viewModelScope.launch {
        repository.resendTreasureHuntOtp(huntId).collect { _resendTreasureHuntResponse.value = it }
    }

}


