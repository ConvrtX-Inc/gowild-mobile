package com.android.gowild.data.model.googleMapRoutesModel

import com.android.gowild.data.model.routes.LocationModel

data class GoogleRouteModel(
    val bounds: LocationModel,
    val copyrights: String,
    val legs: List<LegModel>,
    val overview_polyline: PolylineModel,
    val summary: String,
    val warnings: List<Any>,
    val waypoint_order: List<Any>
)