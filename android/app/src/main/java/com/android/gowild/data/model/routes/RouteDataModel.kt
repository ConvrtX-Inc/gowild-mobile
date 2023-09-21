package com.android.gowild.data.model.routes

import com.android.gowild.data.model.myTrail.HistoricalEvents
import com.android.gowild.data.model.myTrail.SaveRoutesLeaderboardModel

data class RouteDataModel(
    val createdDate: String,
    var crr_user_leaderboard: SaveRoutesLeaderboardModel? = null,
    val description: String,
    val distance_meters: Int,
    val distance_miles: Double,
    val end: LocationModel,
    val estimate_time: String,
    val id: String,
    var leaderboard: ArrayList<SaveRoutesLeaderboardModel>? = null,
    val picture: String? = null,
    val role: String,
    val route_path: String? = null,
    val polyline: String? = null,
    val start: LocationModel,
    val status: String,
    val title: String,
    val updatedDate: String,
    val user_id: String,
    var saved: Boolean = false,
    var isSelected: Boolean = false,
    val historicalEvents: ArrayList<HistoricalEvents>? = ArrayList(),
    val startLocation: String,
    val endLocation: String,
)