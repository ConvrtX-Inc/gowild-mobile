package com.android.gowild.data.model.settings

data class UserLeaderBoardResponse(
    val count: Int,
    val currentPage: Int,
    val `data`: List<Data>,
    val prevPage: Any,
    val totalPage: Int
)