package com.android.gowild.data.model.user

import com.google.gson.annotations.SerializedName

data class Status(
    @SerializedName("id") val id: String = "",
    @SerializedName("createdDate") val createdDate: String = "",
    @SerializedName("updatedDate") val updatedDate: String = "",
    @SerializedName("statusName") val statusName: String = "",
    @SerializedName("isActive") val isActive: Boolean = false
)