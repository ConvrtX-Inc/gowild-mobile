package com.android.gowild.data.model.support

import com.android.gowild.data.model.user.User

data class SupportDataModel(
    val createdDate: String,
    val id: String,
    val status: String,
    val subject: String,
    val updatedDate: String,
    val user: User,
    val user_id: String
)