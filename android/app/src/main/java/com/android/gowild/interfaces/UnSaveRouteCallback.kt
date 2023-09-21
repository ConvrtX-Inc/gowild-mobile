package com.android.gowild.interfaces

import com.android.gowild.data.model.routes.RouteDataModel

interface UnSaveRouteCallback {

    fun onUnSaveRoute(route_id: String, position: Int)
    fun openDetailsFragment(route_id: String)

    fun onTryRoute(route: RouteDataModel, position: Int)
}