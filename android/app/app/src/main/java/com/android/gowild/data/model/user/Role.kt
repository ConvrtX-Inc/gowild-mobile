package com.android.gowild.data.model.user

import com.google.gson.annotations.SerializedName


data class Role(
    @SerializedName("id") val id: String = "",
    @SerializedName("createdDate") val createdDate: String = "",
    @SerializedName("updatedDate") val updatedDate: String = "",
    @SerializedName("name") val name: String = ""
)