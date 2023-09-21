package com.android.gowild.data.model.feeds

import com.android.gowild.data.model.user.User

data class CommentsModel(
    val createdDate: String,
    val id: String,
    val message: String,
    val postfeed_id: String,
    val updatedDate: String,
    val user_id: User
)