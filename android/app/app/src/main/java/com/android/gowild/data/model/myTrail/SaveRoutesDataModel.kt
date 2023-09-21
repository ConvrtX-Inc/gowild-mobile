package com.android.gowild.data.model.myTrail

import com.android.gowild.data.model.routes.RouteDataModel

data class SaveRoutesDataModel(
    val createdDate: String,
    val id: String,
    val leaderboard: ArrayList<SaveRoutesLeaderboardModel>? = null,
    val route: RouteDataModel,
    val route_id: String,
    val updatedDate: String,
    val user_id: String,
    var saved: Boolean = false
)