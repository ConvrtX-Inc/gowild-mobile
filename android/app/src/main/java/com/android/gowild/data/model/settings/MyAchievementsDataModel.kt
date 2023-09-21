package com.android.gowild.data.model.settings

import com.android.gowild.data.model.routes.RouteDataModel
import com.android.gowild.data.model.user.User

data class MyAchievementsDataModel(
    val completionTime: String,
    val createdDate: String,
    val endDate: String,
    val id: String,
    val rank: Int,
    val user : User?,
    val route: RouteDataModel,
    val route_id: String,
    val startDate: String,
    val updatedDate: String,
    val user_id: String
)