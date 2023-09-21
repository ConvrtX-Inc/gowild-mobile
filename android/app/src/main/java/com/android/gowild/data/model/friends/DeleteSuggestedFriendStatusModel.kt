package com.android.gowild.data.model.friends

data class DeleteSuggestedFriendStatusModel(
    val createdDate: String,
    val id: String,
    val isActive: Boolean,
    val statusName: String,
    val updatedDate: String
)