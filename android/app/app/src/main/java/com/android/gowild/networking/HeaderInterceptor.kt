package com.android.gowild.networking

import com.android.gowild.utils.local.UserPrefs
import okhttp3.Interceptor
import okhttp3.Response

class HeaderInterceptor(private val userPrefs: UserPrefs) : Interceptor {

    companion object {
        private const val ACCEPT = "Accept"
        private const val KEY = "KEY"
        private const val APP_KEY = "YW1Gb1lXNTZZV2xpTG1GemJHRnRMbTFsYUdGeVFHZHRZV2xzTG1OdmJUcHdhWE5wWm1scg=="
        private const val AUTHORIZATION = "Authorization"
        private const val LANGUAGE = "X-localization"
    }

    override fun intercept(chain: Interceptor.Chain): Response {
        val original = chain.request()
        val request = original.newBuilder().apply {
            header(ACCEPT, "application/json")
            header(KEY, APP_KEY)
            userPrefs.getUser()?.accessToken?.let {
                header(AUTHORIZATION, "Bearer $it")
            }
            method(original.method, original.body)
        }.build()
        return chain.proceed(request)
    }
}