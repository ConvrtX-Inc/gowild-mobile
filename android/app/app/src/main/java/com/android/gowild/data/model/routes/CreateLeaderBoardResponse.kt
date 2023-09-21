package com.android.gowild.data.model.routes

import com.android.gowild.data.model.settings.MyAchievementsDataModel

data class CreateLeaderBoardResponse(
    val `data`: MyAchievementsDataModel,
    val message: String
)