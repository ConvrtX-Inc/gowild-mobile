package com.android.gowild.data.model.myTrail

import com.android.gowild.data.model.routes.RouteDataModel

data class CreatedRoutesResponseModel(
    val `data`: ArrayList<RouteDataModel>,
    val message: String
)