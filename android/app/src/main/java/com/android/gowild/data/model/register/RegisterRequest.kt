package com.android.gowild.data.model.register

import com.google.gson.annotations.SerializedName
import java.io.Serializable

data class RegisterRequest(
    @SerializedName("email") var email: String? = null,
    @SerializedName("password") var password: String? = null,
    @SerializedName("firstName") var firstName: String? = null,
    @SerializedName("lastName") var lastName: String? = null,
    @SerializedName("gender") var gender: String? = null,
    @SerializedName("userAddress") var userAddress: List<String>? = null,
    @SerializedName("phoneNo") var phoneNo: String? = null,
    @SerializedName("fcm_token") val fcm_token: String,
    @SerializedName("device_type") val device_type: String = "android"
) : Serializable