package com.android.gowild.data.model.friends

import com.google.gson.annotations.SerializedName
import java.io.Serializable

data class MyFriendsUserModel(
    val about_me: String? = null,
    val addressOne: String? = null,
    val addressTwo: String? = null,
    val backImage: String? = null,
    val birthDate: String? = null,
    val email: String? = null,
    @SerializedName(value = "firstName", alternate = ["first_name"])
    val firstName: String? = null,
    val frontImage: String? = null,
    val gender: String? = null,
    val id: String? = null,
    @SerializedName(value = "lastName", alternate = ["last_name"])
    val lastName: String? = null,
    val phoneNo: String? = null,
    val picture: String? = null,
    val username: String? = null,
    val role: DeleteSuggestedFriendRoleModel? = null,
    val status: DeleteSuggestedFriendStatusModel? = null,
) : Serializable