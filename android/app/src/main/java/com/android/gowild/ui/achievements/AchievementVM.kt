package com.android.gowild.ui.achievements

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.android.gowild.data.model.settings.MyAchievementsResponseModel
import com.android.gowild.data.repo.Repository
import com.android.gowild.networking.NetworkResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class AchievementVM @Inject constructor(private val repository: Repository) : ViewModel() {

    private val _getAchievementsLeaderboardResponse: MutableLiveData<NetworkResult<MyAchievementsResponseModel>> = MutableLiveData()
    val getAchievementsLeaderboardResponse: LiveData<NetworkResult<MyAchievementsResponseModel>> = _getAchievementsLeaderboardResponse
    fun getAchievementsLeaderboard() = viewModelScope.launch {
        repository.getAchievementsLeaderboard().collect { _getAchievementsLeaderboardResponse.value = it }
    }
}