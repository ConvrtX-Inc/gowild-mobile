package com.android.gowild.data.model.googleMapRoutesModel

data class GeocodedWaypointModel(
    val geocoder_status: String,
    val place_id: String,
    val types: List<String>
)