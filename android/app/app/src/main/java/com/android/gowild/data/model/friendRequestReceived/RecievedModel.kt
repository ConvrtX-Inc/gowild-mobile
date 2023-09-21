package com.android.gowild.data.model.friendRequestReceived

import java.io.Serializable

// TODO: duplicated model, possibly same as FriendsDataModel
data class RecievedModel(
    val about_me: Any? = null,
    val addressOne: String? = null,
    val addressTwo: String? = null,
    val backImage: Any? = null,
    val birthDate: Any? = null,
    val connection: ConnectionModel,
    val createdDate: String? = null,
    val email: String? = null,
    val firstName: String? = null,
    val frontImage: Any? = null,
    val gender: String? = null,
    val id: String? = null,
    val lastName: String? = null,
    val phoneNo: String? = null,
    val phoneVerified: Boolean? = null,
    val picture: Any? = null,
    val role: RoleModel,
    val status: StatusModel,
    val updatedDate: String? = null
) : Serializable