package com.android.gowild.ui.map

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.android.gowild.data.model.googleMapRoutesModel.GoogleRoutesResponseModel
import com.android.gowild.data.model.routes.CreateLeaderBoardResponse
import com.android.gowild.data.model.routes.CreateLeaderboardRequest
import com.android.gowild.data.repo.Repository
import com.android.gowild.networking.NetworkResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class TryRouteVM @Inject constructor(private val repository: Repository) : ViewModel() {

    private val _createLeaderBoardResponse: MutableLiveData<NetworkResult<CreateLeaderBoardResponse>> = MutableLiveData()
    val createLeaderBoardResponse: LiveData<NetworkResult<CreateLeaderBoardResponse>> = _createLeaderBoardResponse
    fun createLeaderboard(createLeaderboardRequest: CreateLeaderboardRequest) = viewModelScope.launch {
        repository.createLeaderboard(createLeaderboardRequest).collect { _createLeaderBoardResponse.value = it }
    }

    private val _googleRoutesResponse: MutableLiveData<NetworkResult<GoogleRoutesResponseModel>> = MutableLiveData()
    val googleRoutesResponse: LiveData<NetworkResult<GoogleRoutesResponseModel>> = _googleRoutesResponse
    fun getGoogleRoutes(origin: String, destination: String) = viewModelScope.launch {
        repository.getGoogleRoutes(origin, destination).collect { _googleRoutesResponse.value = it }
    }
}