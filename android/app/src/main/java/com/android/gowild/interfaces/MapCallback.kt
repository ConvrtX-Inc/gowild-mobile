package com.android.gowild.interfaces

import com.google.android.gms.maps.GoogleMap

interface MapCallback {
    fun onMapReady(googleMap: GoogleMap)
}