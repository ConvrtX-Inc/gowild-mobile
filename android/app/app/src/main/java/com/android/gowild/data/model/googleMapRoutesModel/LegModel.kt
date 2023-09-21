package com.android.gowild.data.model.googleMapRoutesModel

import com.android.gowild.data.model.routes.LocationModel

data class LegModel(
    val distance: ValueModel,
    val duration: ValueModel,
    val end_address: String,
    val end_location: LocationModel,
    val start_address: String,
    val start_location: LocationModel,
    val steps: List<StepModel>,
    val traffic_speed_entry: List<Any>,
    val via_waypoint: List<Any>
)