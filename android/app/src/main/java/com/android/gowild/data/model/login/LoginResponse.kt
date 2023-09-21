package com.android.gowild.data.model.login

import com.android.gowild.data.model.user.Token
import com.google.gson.annotations.SerializedName
import java.io.Serializable

data class LoginResponse(
    @SerializedName("email") val email: String,
    @SerializedName("password") val password: String,
) : Serializable


data class FacebookLoginResponse(
    @SerializedName("token")
    var token: Token
) : Serializable


data class GoogleLoginResponse(
    @SerializedName("token")
    var token: Token
) : Serializable