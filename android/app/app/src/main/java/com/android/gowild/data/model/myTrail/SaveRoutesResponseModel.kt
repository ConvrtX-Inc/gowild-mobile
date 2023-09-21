package com.android.gowild.data.model.myTrail

data class SaveRoutesResponseModel(
    val count: Int,
    val currentPage: Int,
    val data: ArrayList<SaveRoutesDataModel>,
    val message: String,
    val prevPage: Any,
    val totalPage: Int
)