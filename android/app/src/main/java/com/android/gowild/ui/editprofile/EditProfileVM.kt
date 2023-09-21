package com.android.gowild.ui.editprofile

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.android.gowild.data.model.settings.EditProfileRequestUpdateModel
import com.android.gowild.data.model.settings.EditProfileResponseModel
import com.android.gowild.data.repo.Repository
import com.android.gowild.networking.NetworkResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import okhttp3.MultipartBody
import javax.inject.Inject

@HiltViewModel
class EditProfileVM @Inject constructor(private val repository: Repository) : ViewModel() {

    private val _updateUserProfileResponse: MutableLiveData<NetworkResult<EditProfileResponseModel>> = MutableLiveData()
    val updateUserProfileResponse: LiveData<NetworkResult<EditProfileResponseModel>> = _updateUserProfileResponse
    fun updateUserProfile(request: EditProfileRequestUpdateModel) = viewModelScope.launch {
        repository.updateUserProfile(request).collect { _updateUserProfileResponse.value = it }
    }

    private val _updateUserImageResponse: MutableLiveData<NetworkResult<EditProfileResponseModel>> = MutableLiveData()
    val updateUserImageResponse: LiveData<NetworkResult<EditProfileResponseModel>> = _updateUserImageResponse
    fun updateUserImage(image: MultipartBody.Part) = viewModelScope.launch {
        repository.updateUserImage(image).collect { _updateUserImageResponse.value = it }
    }
}