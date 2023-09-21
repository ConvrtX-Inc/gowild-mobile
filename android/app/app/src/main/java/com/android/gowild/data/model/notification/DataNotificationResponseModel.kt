package com.android.gowild.data.model.notification

data class DataNotificationResponseModel(
    val createdDate: String,
    val id: String,
    val is_seen: Boolean,
    val notification_msg: String,
    val role: String,
    val type: String,
    val updatedDate: String,
    val user_id: String,
    val title: String,
    val msg_code: String,
)