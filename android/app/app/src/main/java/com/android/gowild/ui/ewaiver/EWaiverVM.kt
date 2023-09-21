package com.android.gowild.ui.ewaiver

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.android.gowild.data.model.ewaiver.EWaiverResponse
import com.android.gowild.data.repo.Repository
import com.android.gowild.networking.NetworkResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class EWaiverVM @Inject constructor(private val repository: Repository) : ViewModel() {

    private val _eWaiverResponse: MutableLiveData<NetworkResult<EWaiverResponse>> = MutableLiveData()
    val eWaiverResponse: LiveData<NetworkResult<EWaiverResponse>> = _eWaiverResponse
    fun getEWaiver(type: String) = viewModelScope.launch {
        repository.getEWaiver(type).collect { _eWaiverResponse.value = it }
    }
}