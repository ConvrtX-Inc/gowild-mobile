package com.android.gowild.data.model.routes

data class ApprovedRoutesResponse(
    val count: Int,
    val currentPage: Int,
    val `data`: ArrayList<RouteDataModel>,
    val prevPage: Int,
    val totalPage: Int
)