package com.android.gowild.ui.map.treasurewild

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.android.gowild.data.repo.Repository
import com.android.gowild.networking.NetworkResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import okhttp3.ResponseBody
import javax.inject.Inject


@HiltViewModel
class FindTreasureChestsVM @Inject constructor(private val repository: Repository) : ViewModel() {

    private val _createTreasureWildWinnerResponse: MutableLiveData<NetworkResult<ResponseBody>> = MutableLiveData()
    val createTreasureWildWinnerResponse: LiveData<NetworkResult<ResponseBody>> = _createTreasureWildWinnerResponse
    fun createTreasureWildWinner(chestID: String) = viewModelScope.launch {
        repository.createTreasureWildWinner(chestID).collect { _createTreasureWildWinnerResponse.value = it }
    }
}

