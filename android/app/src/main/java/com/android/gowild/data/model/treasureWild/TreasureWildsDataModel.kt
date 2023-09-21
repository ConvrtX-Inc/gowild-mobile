package com.android.gowild.data.model.treasureWild

import com.android.gowild.data.model.routes.LocationModel

data class TreasureWildsDataModel(
    val a_r: String,
    val createdDate: String,
    val current_user_hunt: Any,
    val description: String,
    val eventDate: String,
    val eventTime: String,
    val id: String,
    val location: LocationModel,
    val no_of_participants: Int,
    val picture: String,
    val sponsors: List<Any>,
    val status: String,
    val title: String,
    val treasureHunts: List<Any>,
    val updatedDate: String,
    val winnerId: String
)