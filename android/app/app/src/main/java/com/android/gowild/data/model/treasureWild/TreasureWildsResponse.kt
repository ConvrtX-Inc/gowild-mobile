package com.android.gowild.data.model.treasureWild

data class TreasureWildsResponse(
    val count: Int,
    val currentPage: Int,
    val `data`: List<TreasureWildsDataModel>,
    val prevPage: Any,
    val totalPage: Int
)