package com.android.gowild.ui.map.treasurewild

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.android.gowild.data.model.settings.EditProfileRequestUpdateModel
import com.android.gowild.data.model.settings.EditProfileResponseModel
import com.android.gowild.data.model.treasureWild.RegisterTreasureWildResponse
import com.android.gowild.data.repo.Repository
import com.android.gowild.networking.NetworkResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import okhttp3.MultipartBody
import javax.inject.Inject

@HiltViewModel
class RegisterHuntVM @Inject constructor(private val repository: Repository) : ViewModel() {

    private val _updateUserProfileResponse: MutableLiveData<NetworkResult<EditProfileResponseModel>> = MutableLiveData()
    val updateUserProfileResponse: LiveData<NetworkResult<EditProfileResponseModel>> = _updateUserProfileResponse
    fun updateUserProfile(request: EditProfileRequestUpdateModel) = viewModelScope.launch {
        repository.updateUserProfile(request).collect { _updateUserProfileResponse.value = it }
    }

    private val _updateUserImageFrontResponse: MutableLiveData<NetworkResult<EditProfileResponseModel>> = MutableLiveData()
    val updateUserImageFrontResponse: LiveData<NetworkResult<EditProfileResponseModel>> = _updateUserImageFrontResponse
    fun updateUserImageFront(image: MultipartBody.Part) = viewModelScope.launch {
        repository.updateUserImage(image).collect { _updateUserImageFrontResponse.value = it }
    }

    private val _updateUserImageBackResponse: MutableLiveData<NetworkResult<EditProfileResponseModel>> = MutableLiveData()
    val updateUserImageBackResponse: LiveData<NetworkResult<EditProfileResponseModel>> = _updateUserImageBackResponse
    fun updateUserImageBack(image: MultipartBody.Part) = viewModelScope.launch {
        repository.updateUserImage(image).collect { _updateUserImageBackResponse.value = it }
    }

    private val _registerHuntResponse: MutableLiveData<NetworkResult<RegisterTreasureWildResponse>> = MutableLiveData()
    val registerHuntResponse: LiveData<NetworkResult<RegisterTreasureWildResponse>> = _registerHuntResponse
    fun registerTreasureHunt(treasureHuntId: String) = viewModelScope.launch {
        repository.registerTreasureHunt(treasureHuntId).collect { _registerHuntResponse.value = it }
    }

}