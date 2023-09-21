package com.android.gowild.ui.map.runwild

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.android.gowild.data.model.myTrail.UnSaveRouteRequestModel
import com.android.gowild.data.model.myTrail.UnSaveRouteResponseModel
import com.android.gowild.data.model.routes.ApprovedRoutesResponse
import com.android.gowild.data.repo.Repository
import com.android.gowild.networking.NetworkResult
import com.android.gowild.utils.SingleLiveEvent
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class RunWildVM @Inject constructor(private val repository: Repository) : ViewModel() {

    private val _approvedRoutesResponse: SingleLiveEvent<NetworkResult<ApprovedRoutesResponse>> = SingleLiveEvent()
    val approvedRoutesResponse: SingleLiveEvent<NetworkResult<ApprovedRoutesResponse>> = _approvedRoutesResponse
    fun getApprovedRoutes(lat: Double, long: Double, page: Int) = viewModelScope.launch {
        repository.getApprovedRoutes(lat, long, page).collect { _approvedRoutesResponse.value = it }
    }

    private val _saveUnSaveRouteResponse: SingleLiveEvent<NetworkResult<UnSaveRouteResponseModel>> = SingleLiveEvent()
    val saveUnSaveRouteResponse: SingleLiveEvent<NetworkResult<UnSaveRouteResponseModel>> = _saveUnSaveRouteResponse
    fun saveUnSaveRoute(unSaveRouteRequestModel: UnSaveRouteRequestModel, position: Int) = viewModelScope.launch {
        repository.unSaveRoutes(unSaveRouteRequestModel).collect {
            it.extra = position
            _saveUnSaveRouteResponse.value = it
        }
    }
}