package com.android.gowild.data.model.myTrail

import com.android.gowild.data.model.routes.LocationModel

data class AddRoutesRequestModel(
    val description: String,
    val distance_meters: Int,
    val distance_miles: Double,
    val end: LocationModel,
    val estimate_time: String,
    val route_path: String?,
    val start: LocationModel,
    val title: String,
    val startLocation: String,
    val endLocation: String
)