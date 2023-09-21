package com.android.gowild.ui.home

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.android.gowild.data.model.friends.MyFriendsResponse
import com.android.gowild.data.model.homeModels.MessagesInboxResponseModel
import com.android.gowild.data.repo.Repository
import com.android.gowild.networking.NetworkResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class FriendsListVM @Inject constructor(private val repository: Repository) : ViewModel() {

    private val _myFriendsResponse: MutableLiveData<NetworkResult<MyFriendsResponse>> = MutableLiveData()
    val myFriendsResponse: LiveData<NetworkResult<MyFriendsResponse>> = _myFriendsResponse
    fun getFriends() = viewModelScope.launch {
        repository.getFriends().collect { _myFriendsResponse.value = it }
    }
}