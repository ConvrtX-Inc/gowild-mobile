package com.android.gowild.data.model.homeModels

data class MessagesInboxDataModel(
    val first_name: String,
    val last_name: String,
    val picture: String? = null,
    val room_id: String,
    val user_id: String
)