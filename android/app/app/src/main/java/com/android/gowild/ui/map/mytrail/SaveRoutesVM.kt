package com.android.gowild.ui.map.mytrail

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.android.gowild.data.model.friends.DeleteRequestResponseModel
import com.android.gowild.data.model.myTrail.CreatedRoutesResponseModel
import com.android.gowild.data.model.myTrail.SaveRoutesResponseModel
import com.android.gowild.data.model.myTrail.UnSaveRouteRequestModel
import com.android.gowild.data.model.myTrail.UnSaveRouteResponseModel
import com.android.gowild.data.repo.Repository
import com.android.gowild.networking.NetworkResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class SaveRoutesVM @Inject constructor(private val repository: Repository) : ViewModel() {

    private val _getSaveRoutesResponse: MutableLiveData<NetworkResult<SaveRoutesResponseModel>> = MutableLiveData()
    val getSaveRoutesResponse: LiveData<NetworkResult<SaveRoutesResponseModel>> = _getSaveRoutesResponse
    fun getSaveRoutes() = viewModelScope.launch {
        repository.getSaveRoutes().collect { _getSaveRoutesResponse.value = it }
    }

    private val _getCreatedRoutesResponse: MutableLiveData<NetworkResult<CreatedRoutesResponseModel>> = MutableLiveData()
    val getCreatedRoutesResponse: LiveData<NetworkResult<CreatedRoutesResponseModel>> = _getCreatedRoutesResponse
    fun getCreatedRoutes() = viewModelScope.launch {
        repository.getCreatedRoutes().collect { _getCreatedRoutesResponse.value = it }
    }

    private val _getDeleteRouteResponse: MutableLiveData<NetworkResult<DeleteRequestResponseModel>> = MutableLiveData()
    val getDeleteRouteResponse: LiveData<NetworkResult<DeleteRequestResponseModel>> = _getDeleteRouteResponse
    fun deleteCreatedRoute(id: String) = viewModelScope.launch {
        repository.deleteCreatedRoute(id).collect { _getDeleteRouteResponse.value = it }
    }

    private val _getUnSaveRouteResponse: MutableLiveData<NetworkResult<UnSaveRouteResponseModel>> = MutableLiveData()
    val getUnSaveRouteResponse: LiveData<NetworkResult<UnSaveRouteResponseModel>> = _getUnSaveRouteResponse
    fun unSaveRoutes(unSaveRouteRequestModel: UnSaveRouteRequestModel) = viewModelScope.launch {
        repository.unSaveRoutes(unSaveRouteRequestModel).collect { _getUnSaveRouteResponse.value = it }
    }
}