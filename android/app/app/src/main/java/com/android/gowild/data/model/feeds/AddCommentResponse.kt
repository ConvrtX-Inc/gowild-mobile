package com.android.gowild.data.model.feeds

data class AddCommentResponse(
    val createdDate: String,
    val id: String,
    val message: String,
    val postfeed_id: String,
    val updatedDate: String,
    val user_id: String
)