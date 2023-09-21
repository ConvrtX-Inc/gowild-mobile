package com.android.gowild.ui.map.runwild

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.android.gowild.data.model.myTrail.RouteDetailsResponseModel
import com.android.gowild.data.model.settings.MyAchievementsResponseModel
import com.android.gowild.data.repo.Repository
import com.android.gowild.networking.NetworkResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class RouteDetailsVM @Inject constructor(private val repository: Repository) : ViewModel() {

    private val _routeDetailResponse: MutableLiveData<NetworkResult<RouteDetailsResponseModel>> = MutableLiveData()
    val routeDetailsResponse: LiveData<NetworkResult<RouteDetailsResponseModel>> = _routeDetailResponse
    fun getRouteDetail(id: String) = viewModelScope.launch {
        repository.getRouteDetail(id).collect { _routeDetailResponse.value = it }
    }

    private val _userLeaderboardResponse: MutableLiveData<NetworkResult<MyAchievementsResponseModel>> = MutableLiveData()
    val userLeaderboardResponse: LiveData<NetworkResult<MyAchievementsResponseModel>> = _userLeaderboardResponse
    fun getAchievementsLeaderboard() = viewModelScope.launch {
        repository.getAchievementsLeaderboard().collect { _userLeaderboardResponse.value = it }
    }

    private val _routeLeaderboardResponse: MutableLiveData<NetworkResult<MyAchievementsResponseModel>> = MutableLiveData()
    val routeLeaderboardResponse: LiveData<NetworkResult<MyAchievementsResponseModel>> = _routeLeaderboardResponse
    fun getRouteLeaderBoard(routeID: String) = viewModelScope.launch {
        repository.getRouteLeaderBoard(routeID).collect { _routeLeaderboardResponse.value = it }
    }
}