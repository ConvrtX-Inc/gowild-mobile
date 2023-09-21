package com.android.gowild.data.model.settings

data class EditProfileRequestUpdateModel(
    val about_me: String? = null,
    val addressOne: String? = null,
    val addressTwo: String? = null,
    val birthDate: String? = null,
    val firstName: String? = null,
    val gender: String? = null,
    val lastName: String? = null,
    val phoneNo: String? = null,
    val username: String? = null
)