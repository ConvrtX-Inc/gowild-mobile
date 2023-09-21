package com.android.gowild.ui.notification

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.android.gowild.data.model.notification.UserNotificationResponseModel
import com.android.gowild.data.repo.Repository
import com.android.gowild.networking.NetworkResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class NotificationVM @Inject constructor(private val repository: Repository) : ViewModel() {

    private val _notificationsResponse: MutableLiveData<NetworkResult<UserNotificationResponseModel>> = MutableLiveData()
    val notificationsResponse: LiveData<NetworkResult<UserNotificationResponseModel>> = _notificationsResponse
    fun getUserNotification(user_id: String) = viewModelScope.launch {
        repository.getUserNotification(user_id).collect { _notificationsResponse.value = it }
    }
}