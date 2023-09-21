package com.android.gowild.data.model.register

import com.google.gson.annotations.SerializedName
import java.io.Serializable

data class VerifyMobileSendRequest(
    @SerializedName("phone_number") var phone_number: String? = null,
) : Serializable
