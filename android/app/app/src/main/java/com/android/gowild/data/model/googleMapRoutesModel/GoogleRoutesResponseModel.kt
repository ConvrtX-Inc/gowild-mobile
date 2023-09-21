package com.android.gowild.data.model.googleMapRoutesModel

data class GoogleRoutesResponseModel(
    val geocoded_waypoints: ArrayList<GeocodedWaypointModel>,
    val routes: ArrayList<GoogleRouteModel>,
    val status: String
)