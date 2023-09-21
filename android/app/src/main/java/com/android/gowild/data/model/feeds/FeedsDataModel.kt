package com.android.gowild.data.model.feeds

import com.android.gowild.data.model.user.User

data class FeedsDataModel(
    val attachment: ArrayList<Attachment>?,
    var comments: Int? = 0,
    val createdDate: String,
    val description: String?,
    val id: String,
    val is_published: Boolean,
    var likes: Int? = 0,
    val likes_images: ArrayList<String>?,
    val picture: String?,
    val share: Int? = 0,
    val title: String,
    val updatedDate: String,
    var user: User?,
    val user_id: String,
    var views: Int? = 0
)