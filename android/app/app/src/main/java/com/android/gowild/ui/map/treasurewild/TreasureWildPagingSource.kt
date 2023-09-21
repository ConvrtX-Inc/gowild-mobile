package com.android.gowild.ui.map.treasurewild

import android.util.Log
import androidx.paging.PagingSource
import androidx.paging.PagingState
import com.android.gowild.data.model.treasureWild.TreasureWildResponse
import com.android.gowild.data.repo.Repository
import retrofit2.HttpException

class TreasureWildPagingSourceUpcoming(
    private val repository: Repository
) : PagingSource<Int, TreasureWildResponse.TreasureWildListingData>() {


    override suspend fun load(params: LoadParams<Int>): LoadResult<Int, TreasureWildResponse.TreasureWildListingData> {

        return try {

            val currentPage = params.key ?: 1

            val response = repository.api.getTreasureWildListings(currentPage)

            val data = response.body()?.data
            Log.d("PaginationPage", currentPage.toString())
            Log.d("Pagination", data.toString())

            val responseData = mutableListOf<TreasureWildResponse.TreasureWildListingData>()
            data?.let { responseData.addAll(it) }

            LoadResult.Page(
                data = responseData,
                prevKey = if (currentPage == 1) null else -1,
                nextKey = if (responseData.isEmpty()) null else currentPage + 1
            )
        } catch (e: Exception) {
            LoadResult.Error(e)
        } catch (exception: HttpException) {
            LoadResult.Error(exception)
        }

    }


    override fun getRefreshKey(state: PagingState<Int, TreasureWildResponse.TreasureWildListingData>): Int? {
        return state.anchorPosition?.let { anchorPosition ->
            state.closestPageToPosition(anchorPosition)?.prevKey?.plus(1)
                ?: state.closestPageToPosition(anchorPosition)?.nextKey?.minus(1)
        }
    }


}


class TreasureWildPagingSourceOngoing(
    private val repository: Repository,
) : PagingSource<Int, TreasureWildResponse.TreasureWildListingData>() {


    override suspend fun load(params: LoadParams<Int>): LoadResult<Int, TreasureWildResponse.TreasureWildListingData> {

        return try {

            val currentPage = params.key ?: 1

            val response = repository.api.getTreasureWildListings(currentPage)

            val data = response.body()?.data
            Log.d("PaginationPage", currentPage.toString())
            Log.d("Pagination", data.toString())

            val responseData = mutableListOf<TreasureWildResponse.TreasureWildListingData>()
            data?.let { responseData.addAll(it) }

            LoadResult.Page(
                data = responseData,
                prevKey = if (currentPage == 1) null else -1,
                nextKey = if (responseData.isEmpty()) null else currentPage + 1
            )
        } catch (e: Exception) {
            LoadResult.Error(e)
        } catch (exception: HttpException) {
            LoadResult.Error(exception)
        }

    }


    override fun getRefreshKey(state: PagingState<Int, TreasureWildResponse.TreasureWildListingData>): Int? {
        return state.anchorPosition?.let { anchorPosition ->
            state.closestPageToPosition(anchorPosition)?.prevKey?.plus(1)
                ?: state.closestPageToPosition(anchorPosition)?.nextKey?.minus(1)
        }
    }


}