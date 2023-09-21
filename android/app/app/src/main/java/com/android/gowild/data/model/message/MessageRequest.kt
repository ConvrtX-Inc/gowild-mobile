package com.android.gowild.data.model.message

data class MessageRequest(
    var user_id: String,
    var message: String,
    var token: String
)