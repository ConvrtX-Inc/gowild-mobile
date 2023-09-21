package com.android.gowild.data.model.user

import com.google.gson.annotations.SerializedName
import java.io.Serializable

data class Token(
    @SerializedName("accessToken")
    var accessToken: String = "",
    @SerializedName("refreshToken")
    var refreshToken: String = ""
)