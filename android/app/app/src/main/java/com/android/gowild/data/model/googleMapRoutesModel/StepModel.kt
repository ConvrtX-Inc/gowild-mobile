package com.android.gowild.data.model.googleMapRoutesModel

import com.android.gowild.data.model.routes.LocationModel

data class StepModel(
    val distance: ValueModel,
    val duration: ValueModel,
    val end_location: LocationModel,
    val html_instructions: String,
    val maneuver: String,
    val polyline: PolylineModel,
    val start_location: LocationModel,
    val travel_mode: String
)