package com.android.gowild.ui.map.mytrail

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.android.gowild.data.model.friends.DeleteRequestResponseModel
import com.android.gowild.data.model.googleMapRoutesModel.GoogleRoutesResponseModel
import com.android.gowild.data.model.myTrail.AddRoutesRequestModel
import com.android.gowild.data.model.myTrail.UpdateRouteResponseModel
import com.android.gowild.data.model.routes.RouteDataModel
import com.android.gowild.data.repo.Repository
import com.android.gowild.networking.NetworkResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import okhttp3.MultipartBody
import javax.inject.Inject

@HiltViewModel
class AddRoutesVM @Inject constructor(private val repository: Repository) : ViewModel() {

    private val _googleRoutesResponse: MutableLiveData<NetworkResult<GoogleRoutesResponseModel>> = MutableLiveData()
    val googleRoutesResponse: LiveData<NetworkResult<GoogleRoutesResponseModel>> = _googleRoutesResponse
    fun getGoogleRoutes(origin: String, destination: String) = viewModelScope.launch {
        repository.getGoogleRoutes(origin, destination).collect { _googleRoutesResponse.value = it }
    }

    private val _createRoutesResponse: MutableLiveData<NetworkResult<UpdateRouteResponseModel>> = MutableLiveData()
    val createRoutesResponse: LiveData<NetworkResult<UpdateRouteResponseModel>> = _createRoutesResponse
    fun createRoutes(addRoutesRequestModel: AddRoutesRequestModel) = viewModelScope.launch {
        repository.createRoutes(addRoutesRequestModel).collect { _createRoutesResponse.value = it }
    }

    private val _updatedRoutesResponse: MutableLiveData<NetworkResult<UpdateRouteResponseModel>> = MutableLiveData()
    val updatedRoutesResponse: LiveData<NetworkResult<UpdateRouteResponseModel>> = _updatedRoutesResponse
    fun updateCreatedRoute(id: String, addRoutesRequestModel: AddRoutesRequestModel) = viewModelScope.launch {
        repository.updateCreatedRoute(id, addRoutesRequestModel).collect { _updatedRoutesResponse.value = it }
    }

    private val _deleteRouteResponse: MutableLiveData<NetworkResult<DeleteRequestResponseModel>> = MutableLiveData()
    val deleteRouteResponse: LiveData<NetworkResult<DeleteRequestResponseModel>> = _deleteRouteResponse
    fun deleteCreatedRoute(id: String) = viewModelScope.launch {
        repository.deleteCreatedRoute(id).collect { _deleteRouteResponse.value = it }
    }

    private val _updateRoutePictureResponse: MutableLiveData<NetworkResult<RouteDataModel>> = MutableLiveData()
    val updateRoutePictureResponse: LiveData<NetworkResult<RouteDataModel>> = _updateRoutePictureResponse
    fun updateRoutePicture(id: String, file: MultipartBody.Part) = viewModelScope.launch {
        repository.updateRoutePicture(id, file).collect { _updateRoutePictureResponse.value = it }
    }
}