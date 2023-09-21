package com.android.gowild.data.model.settings

import com.android.gowild.data.model.user.User

data class EditProfileResponseModel(
    val message: String,
    val user: User
)