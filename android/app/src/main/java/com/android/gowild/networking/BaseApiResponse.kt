package com.android.gowild.networking

import com.android.gowild.utils.NoConnectivityException
import com.android.gowild.utils.extension.getJunkResponse
import com.google.gson.Gson
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.flowOn
import okhttp3.Headers
import retrofit2.Response
import timber.log.Timber
import java.io.InterruptedIOException
import java.net.SocketTimeoutException
import java.net.UnknownHostException

abstract class BaseApiResponse {

    suspend fun <T> safeApiCall(apiCall: suspend () -> Response<T>): NetworkResult<T> {
        try {
            Timber.tag("BaseApiResponse").wtf("${apiCall.javaClass} ApiCall")
            val response = apiCall()
            if (response.isSuccessful) {
                val body = response.body()
                val headers: Headers = response.headers()
                body?.let {
                    Timber.tag("BaseApiResponse").wtf("---------------------------------------------------")
                    Timber.tag("BaseApiResponse").wtf("${apiCall.javaClass} Success : ${response.message()}")
                    Timber.tag("BaseApiResponse").wtf(Gson().newBuilder().setPrettyPrinting().create().toJson(response.body()))
                    Timber.tag("BaseApiResponse").wtf("---------------------------------------------------")
                    return NetworkResult.Success(body, headers = headers)
                }
            }
            if (response.errorBody() != null) {
                val errorBody = response.errorBody()!!.string()
                val errors = errorBody.getJunkResponse()
                Timber.tag("BaseApiResponse").wtf("${apiCall.javaClass} Failure : $errorBody")
                if (errors != null)
                    return NetworkResult.Failure(message = "Failure ${response.message()}", junkError = errors, errorCode = response.raw().code)

            }
            return NetworkResult.Failure(message = "${response.code()} ${response.message()}", errorCode = response.code())
        } catch (e: Exception) {
            Timber.tag("BaseApiResponse").wtf("${apiCall.javaClass} ${e.javaClass} ${e.message}")
            return when (e.javaClass) {
                UnknownHostException().javaClass, java.net.SocketException().javaClass, NoConnectivityException().javaClass -> {
                    NetworkResult.Error(e.message, Errors.NetworkError(e))
                }

                java.net.ConnectException().javaClass, java.io.IOException().javaClass -> {
                    NetworkResult.Error(e.message, Errors.ServerError(e))
                }

                InterruptedIOException().javaClass, SocketTimeoutException().javaClass -> {
                    NetworkResult.Error(e.message, Errors.TimeOutError(e))
                }

                else -> {
                    NetworkResult.Error(e.message, Errors.Error(e))
                }
            }
        }
    }

    // using flows to remove repository class
    suspend fun <T> safeApiCallWithFlows(apiCall: suspend () -> Response<T>): Flow<NetworkResult<T>> {
        return flow<NetworkResult<T>> {
            try {
                emit(NetworkResult.Loading())
                Timber.tag("BaseApiResponse").wtf("${apiCall.javaClass} ApiCall")
                val response = apiCall()
                if (response.isSuccessful) {
                    val body = response.body()
                    val headers: Headers = response.headers()
                    body?.let {
                        Timber.tag("BaseApiResponse").wtf("${apiCall.javaClass} Success : ${response.message()}")
                        emit(NetworkResult.Success(body, headers = headers))
                    }
                }
                if (response.errorBody() != null) {
                    val errorBody = response.errorBody()!!.string()
                    val errors = errorBody.getJunkResponse()
                    Timber.tag("BaseApiResponse").wtf("${apiCall.javaClass} Failure : $errorBody")
                    if (errors != null)
                        emit(NetworkResult.Failure(message = "Failure ${response.message()}", junkError = errors, errorCode = response.raw().code))

                }
                emit(NetworkResult.Failure(message = "${response.code()} ${response.message()}", errorCode = response.code()))
            } catch (e: Exception) {
                Timber.tag("BaseApiResponse").wtf("${apiCall.javaClass} ${e.javaClass} ${e.message}")
                emit(
                    when (e.javaClass) {
                        UnknownHostException().javaClass, java.net.SocketException().javaClass, NoConnectivityException().javaClass -> {
                            NetworkResult.Error(e.message, Errors.NetworkError(e))
                        }

                        java.net.ConnectException().javaClass, java.io.IOException().javaClass -> {
                            NetworkResult.Error(e.message, Errors.ServerError(e))
                        }

                        InterruptedIOException().javaClass, SocketTimeoutException().javaClass -> {
                            NetworkResult.Error(e.message, Errors.TimeOutError(e))
                        }

                        else -> {
                            NetworkResult.Error(e.message, Errors.Error(e))
                        }
                    }
                )
            }
        }.flowOn(Dispatchers.IO)
    }
}