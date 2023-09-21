package com.android.gowild.data.model.friends

import java.io.Serializable

data class FriendsDataModel(
    val about_me: String? = null,
    val addressOne: String? = null,
    val addressTwo: String? = null,
    val backImage: String? = null,
    val birthDate: String? = null,
    val email: String? = null,
    val firstName: String? = null,
    val frontImage: String? = null,
    val gender: String? = null,
    val id: String? = null,
    val lastName: String? = null,
    val phoneNo: String? = null,
    val picture: String? = null,
    val role: String? = null,
    val status: String? = null
) : Serializable