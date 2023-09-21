package com.android.gowild.data.model.support

import com.android.gowild.data.model.user.User

// FIXME: Duplicate with SupportDataModel
data class SupportCreateNewTicketDataModel(
    val createdDate: String,
    val id: String,
    val message_id: String,
    val status: String,
    val subject: String,
    val updatedDate: String,
    val user: User,
    val user_id: String
)