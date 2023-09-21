package com.android.gowild.data.model.register

import com.google.gson.annotations.SerializedName

data class VerifyMobileOtpRequest (
    @SerializedName("email") var email: String? = null,
    @SerializedName("phoneNo") var phoneNo: String? = null,
    @SerializedName("otp") var otp: String? = null,
) : java.io.Serializable