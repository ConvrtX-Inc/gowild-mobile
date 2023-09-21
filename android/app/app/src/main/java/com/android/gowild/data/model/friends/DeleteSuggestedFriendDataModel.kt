package com.android.gowild.data.model.friends

// TODO: duplicated model, possibly same as FriendsDataMode
data class DeleteSuggestedFriendDataModel(
    val about_me: String,
    val addressOne: String,
    val addressTwo: String,
    val backImage: String,
    val birthDate: String,
    val createdDate: String,
    val email: String,
    val firstName: String,
    val frontImage: String,
    val gender: String,
    val id: String,
    val lastName: String,
    val phoneNo: String,
    val phoneVerified: Boolean,
    val picture: String,
    val role: DeleteSuggestedFriendRoleModel,
    val status: DeleteSuggestedFriendStatusModel,
    val updatedDate: String
)