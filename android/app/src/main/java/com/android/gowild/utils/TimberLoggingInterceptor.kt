package com.android.gowild.utils

import okhttp3.Interceptor
import okhttp3.Request
import okhttp3.Response
import okhttp3.ResponseBody
import okhttp3.ResponseBody.Companion.toResponseBody
import okhttp3.logging.HttpLoggingInterceptor
import okio.Buffer
import timber.log.Timber
import timber.log.Timber.Forest.i
import java.io.IOException

class TimberLoggingInterceptor : Interceptor, HttpLoggingInterceptor.Logger {
    @Throws(IOException::class)
    override fun intercept(chain: Interceptor.Chain): Response {
        val request: Request = chain.request()
        val t1 = System.nanoTime()
        i("Sending request %s on %s%n%s", request.url, chain.connection(), request.headers)
        Timber.v("REQUEST BODY BEGIN\n%s\nREQUEST BODY END", bodyToString(request))
        val response: Response = chain.proceed(request)
        val responseBody: ResponseBody = response.body!!
        val responseBodyString: String = response.body!!.string()
        val newResponse: Response = response.newBuilder()
            .body(responseBodyString.toByteArray().toResponseBody(responseBody.contentType()))
            .build()
        val t2 = System.nanoTime()
        i(
            "Received response for %s in %.1fms%n%s",
            response.request.url,
            (t2 - t1) / 1e6,
            response.headers
        )
        Timber.v("RESPONSE BODY BEGIN:\n%s\nRESPONSE BODY END", responseBodyString)
        return newResponse
    }

    companion object {
        private fun bodyToString(request: Request): String {
            return try {
                val copy: Request = request.newBuilder().build()
                val buffer = Buffer()
                copy.body!!.writeTo(buffer)
                buffer.readUtf8()
            } catch (e: IOException) {
                "did not work"
            }
        }
    }

    override fun log(message: String) {
    }
}
