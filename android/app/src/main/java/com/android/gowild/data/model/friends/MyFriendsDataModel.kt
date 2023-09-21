package com.android.gowild.data.model.friends

import java.io.Serializable

data class MyFriendsDataModel(
    val createdDate: String,
    val created_date: String,
    val deleted_date: String,
    val from_user_id: String,
    val id: String,
    val is_accepted: Boolean,
    val parent_id: String,
    val to_user_id: String,
    val updatedDate: String,
    val from_user: MyFriendsUserModel,
    val to_user: MyFriendsUserModel,
) : Serializable