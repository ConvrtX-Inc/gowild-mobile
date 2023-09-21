package com.android.gowild.data.model.myTrail

import com.android.gowild.data.model.routes.RouteDataModel
import com.google.gson.annotations.SerializedName

data class UpdateRouteResponseModel(
    val message: String,
    @SerializedName(value = "route", alternate = ["data"])
    val route: RouteDataModel
)