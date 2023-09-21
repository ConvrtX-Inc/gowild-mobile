package com.android.gowild.data.model.login

import com.google.gson.annotations.SerializedName
import java.io.Serializable

data class LoginRequest(
    @SerializedName("email") val email: String,
    @SerializedName("password") val password: String,
    @SerializedName("fcm_token") val fcm_token: String,
    @SerializedName("device_type") val device_type: String = "android"
) : Serializable

data class GoogleLoginRequest(
    @SerializedName("id_token") val idToken: String,
    @SerializedName("fcm_token") val fcm_token: String,
    @SerializedName("device_type") val device_type: String = "android"
) : Serializable

data class FacebookLoginRequest(
    @SerializedName("access_token") val accessToken: String,
    @SerializedName("fcm_token") val fcm_token: String,
    @SerializedName("device_type") val device_type: String = "android"
) : Serializable

