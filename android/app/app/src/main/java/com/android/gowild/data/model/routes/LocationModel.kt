package com.android.gowild.data.model.routes

import com.google.gson.annotations.SerializedName

data class LocationModel(
    @SerializedName(value = "latitude", alternate = ["lat"])
    val latitude: Double,
    @SerializedName(value = "longitude", alternate = ["lng"])
    val longitude: Double
)