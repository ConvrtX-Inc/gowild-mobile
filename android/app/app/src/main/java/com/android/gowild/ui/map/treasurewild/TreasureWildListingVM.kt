package com.android.gowild.ui.map.treasurewild

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import androidx.paging.Pager
import androidx.paging.PagingConfig
import androidx.paging.PagingData
import androidx.paging.cachedIn
import com.android.gowild.data.model.treasureWild.TreasureWildResponse
import com.android.gowild.data.repo.Repository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.Flow
import javax.inject.Inject

@HiltViewModel
class TreasureWildListingVM @Inject constructor(
    private val repository: Repository
) : ViewModel() {

    val treasureWildListUpcoming : Flow<PagingData<TreasureWildResponse.TreasureWildListingData>> = Pager(PagingConfig(1)) {
        TreasureWildPagingSourceUpcoming(repository)
    }.flow



    val treasureWildListOngoing = Pager(PagingConfig(1)) {
        TreasureWildPagingSourceOngoing(repository)
    }.flow

}