package com.android.gowild.data.model.homeModels

import com.android.gowild.data.model.routes.RouteDataModel
import com.android.gowild.utils.constant.MAP_TYPE

data class HomeMapModel(
    var apiCurrentPage: Int = 1,
    var apiTotalCount: Int = 0,
    var apiTotalPages: Int = 0,
    var routesIndex: Int = -1,
    var selectedItemIndex: Int = 0,
    var lat: Double = 0.0,
    var lng: Double = 0.0,
    var routes: ArrayList<RouteDataModel> = ArrayList(),
    var zoom: Float = 14f,
    var mapType: String = MAP_TYPE
)