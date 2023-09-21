package com.android.gowild.networking

import com.android.gowild.data.model.base.JunkResponse
import okhttp3.Headers

sealed class NetworkResult<T>(
    val data: T? = null,
    val message: String? = null,
    val e: Exception? = null,
    val error: Errors? = null,
    val errorCode: Int? = null,
    val headers: Headers? = null,
    val junkError: JunkResponse? = null,
    var extra : Any? = null
) {
    class Success<T>(data: T, headers: Headers? = null) : NetworkResult<T>(data, headers = headers)
    class Failure<T>(message: String? = null, junkError: JunkResponse? = null, errorCode: Int? = 0) :
        NetworkResult<T>(message = message, junkError = junkError, errorCode = errorCode)

    class Loading<T> : NetworkResult<T>()
    class Error<T>(message: String?, errors: Errors) : NetworkResult<T>(message = message, error = errors)
}

sealed class Errors(val e: Exception) {
    class NetworkError(e: Exception) : Errors(e)
    class ServerError(e: Exception) : Errors(e)
    class TimeOutError(e: Exception) : Errors(e)
    class Error(e: Exception) : Errors(e)
}