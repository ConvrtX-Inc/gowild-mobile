package com.android.gowild.data.model.register

import com.google.gson.annotations.SerializedName
import java.io.Serializable

data class VerifyOtpResponse(
    @SerializedName("access_token") var accessToken: String
) : Serializable