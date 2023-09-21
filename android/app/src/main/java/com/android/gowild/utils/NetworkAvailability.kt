package com.android.gowild.utils

import android.content.Context
import android.net.ConnectivityManager
import androidx.core.content.ContextCompat

class CheckNetworkAvailability(var context: Context)
{
    val isNetworkAvailable: Boolean
        get() {
            val connectivityManager =
                ContextCompat.getSystemService(context , ConnectivityManager::class.java)
            val activeNetworkInfo = connectivityManager?.activeNetworkInfo
            return activeNetworkInfo != null && activeNetworkInfo.isConnected
        }

}