package com.android.gowild.data.model.ewaiver

import com.google.gson.annotations.SerializedName
import java.io.Serializable


data class EWaiverResponse (
    @SerializedName("data") val data:EWaiverData
)

data class EWaiverData(
    @SerializedName("id") val id: String,
    @SerializedName("createdDate") val createdDate: String,
    @SerializedName("updatedDate") val updatedDate: String,
    @SerializedName("type") val type: String,
    @SerializedName("description") val description: String,
    @SerializedName("last_updated_user") val last_updated_user: String,
) : Serializable