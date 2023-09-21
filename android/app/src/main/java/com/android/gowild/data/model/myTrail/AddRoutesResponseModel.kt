package com.android.gowild.data.model.myTrail

import android.location.Location

data class AddRoutesResponseModel(
    val createdDate: String,
    val description: String,
    val distance_meters: Int,
    val distance_miles: Double,
    val end: Location,
    val estimate_time: String,
    val id: String,
    val picture: String,
    val role: String,
    val route_path: String,
    val start: Location,
    val status: String,
    val title: String,
    val updatedDate: String,
    val user_id: String,
    val startLocation: String,
    val endLocation: String
)