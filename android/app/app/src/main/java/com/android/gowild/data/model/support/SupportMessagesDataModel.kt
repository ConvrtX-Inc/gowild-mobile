package com.android.gowild.data.model.support

import com.android.gowild.data.model.user.User

data class SupportMessagesDataModel(
    val id: String? = null,
    val ticket_id: String? = null,
    val user_id: String? = null,
    val message: String? = null,
    val userSeen: Boolean? = null,
    val adminSeen: Boolean = false,
    val role: String? = null,
    val user: User? = null,
    val attachment: ArrayList<String>? = null,
    val createdDate: String? = null,
    val updatedDate: String? = null,
)