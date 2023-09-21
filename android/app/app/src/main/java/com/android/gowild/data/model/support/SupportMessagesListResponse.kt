package com.android.gowild.data.model.support

data class SupportMessagesListResponse(
    val count: Int,
    val currentPage: Int,
    val `data`: ArrayList<SupportMessagesDataModel>,
    val message: String,
    val prevPage: Any,
    val totalPage: Int
)