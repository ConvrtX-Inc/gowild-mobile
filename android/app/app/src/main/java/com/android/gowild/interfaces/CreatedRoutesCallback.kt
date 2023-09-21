package com.android.gowild.interfaces

import com.android.gowild.data.model.routes.RouteDataModel

interface CreatedRoutesCallback {
    fun onEdit(route: RouteDataModel, position: Int)
    fun onDelete(route: RouteDataModel, position: Int)
    fun openDetailsFragment(route_id: String)

    fun onShareRoute(route_id: String)

    fun onTryRoute(route: RouteDataModel,position: Int)
}