package com.android.gowild.ui.messages

import android.util.Log
import androidx.paging.PagingSource
import androidx.paging.PagingState
import com.android.gowild.data.model.message.MessageApiResponse
import com.android.gowild.data.model.treasureWild.TreasureWildResponse
import com.android.gowild.data.repo.Repository
import retrofit2.HttpException


class MessageResponsePagingSource(
    private val repository: Repository, private val id:String
) : PagingSource<Int, MessageApiResponse.MessageDetail>() {


    override suspend fun load(params: LoadParams<Int>): LoadResult<Int, MessageApiResponse.MessageDetail> {

        return try {

            val currentPage = params.key ?: 1

            val response = repository.api.getFriendMessages(id,currentPage)

            val data = response.body()?.data
            Log.d("PaginationPage", currentPage.toString())
            Log.d("Pagination", data.toString())

            val responseData = mutableListOf<MessageApiResponse.MessageDetail>()
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


    override fun getRefreshKey(state: PagingState<Int, MessageApiResponse.MessageDetail>): Int? {
        return state.anchorPosition?.let { anchorPosition ->
            state.closestPageToPosition(anchorPosition)?.prevKey?.plus(1)
                ?: state.closestPageToPosition(anchorPosition)?.nextKey?.minus(1)
        }
    }


}
