package com.android.gowild.interfaces

import com.android.gowild.data.model.routes.RouteDataModel

interface RoutesCallback {
    fun onRouteSelected(data : RouteDataModel, position: Int)

    fun onTryRoute(routeDataModel: RouteDataModel, position: Int)

    fun onRouteDetail(routeDataModel: RouteDataModel)

    fun onSaveUnSaveRoute(routeDataModel: RouteDataModel, position: Int)
}