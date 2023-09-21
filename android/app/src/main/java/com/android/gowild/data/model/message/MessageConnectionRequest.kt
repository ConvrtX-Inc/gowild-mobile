package com.android.gowild.data.model.message

data class MessageConnectionRequest(
    var sender_id: String,
    var receiver_id: String,
    var token: String
)