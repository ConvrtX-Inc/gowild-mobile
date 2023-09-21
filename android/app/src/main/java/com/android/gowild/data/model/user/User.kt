package com.android.gowild.data.model.user

import com.google.gson.annotations.SerializedName
import java.io.Serializable

data class User(
    @SerializedName("firstName") val firstName: String? = "",
    @SerializedName("lastName") val lastName: String? = "",
    @SerializedName("gender") val gender: String? = "",
    @SerializedName("username") val username: String? = "",
    @SerializedName("email") val email: String? = "",
    @SerializedName("phoneNo") val phoneNo: String? = "",
    @SerializedName("addressOne") val addressOne: String? = "",
    @SerializedName("addressTwo") val addressTwo: String? = "",
    @SerializedName("about_me") val about_me: String? = "",
    @SerializedName("picture") val picture: String? = "",
    @SerializedName("frontImage") val frontImage: String? = "",
    @SerializedName("backImage") val backImage: String? = "",
    @SerializedName("phoneVerified") val phoneVerified: Boolean? = false,
    @SerializedName("selfie_verified") var selfie_verified: Boolean? = false,
    @SerializedName("status") val status: Status? = Status(),
    @SerializedName("role") val role: Role? = Role(),
    @SerializedName("birthDate") val birthDate: String? = "",
    @SerializedName("id") val id: String? = "",
    @SerializedName("createdDate") val createdDate: String? = "",
    @SerializedName("updatedDate") val updatedDate: String? = "",
    @SerializedName("accessToken") var accessToken: String? = null,
    @SerializedName("refreshToken") var refreshToken: String? = null,
    @SerializedName("errors") val errors: List<Map<String, String>>?,
    @SerializedName("base_url") val base_url: String? = "",
) : Serializable