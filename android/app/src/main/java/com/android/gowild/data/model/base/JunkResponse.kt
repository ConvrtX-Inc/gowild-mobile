package com.android.gowild.data.model.base

import com.google.gson.annotations.SerializedName

data class JunkResponse(
    @SerializedName("errors") val errors: ArrayList<Map<String, String>>?,
)