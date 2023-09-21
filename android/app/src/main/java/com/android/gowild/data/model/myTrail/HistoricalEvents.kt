package com.android.gowild.data.model.myTrail

import com.android.gowild.data.model.routes.LocationModel

data class HistoricalEvents(
    val id: String,
    val createdDate: String,
    val updatedDate: String,
    val historical_event: LocationModel,
    val title: String,
    val subtitle: String,
    val description: String,
    val image: String,
    val route_id: String,
    var isPopupShown : Boolean = false
)