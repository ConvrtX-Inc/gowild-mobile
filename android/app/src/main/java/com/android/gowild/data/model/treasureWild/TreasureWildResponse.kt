package com.android.gowild.data.model.treasureWild

import com.google.gson.annotations.SerializedName
import java.io.Serializable


data class TreasureWildResponse(
    @SerializedName("data") val data: ArrayList<TreasureWildListingData>,
    @SerializedName("count") val count: Int,
    @SerializedName("currentPage") val currentPage: Int,
    @SerializedName("prevPage") val prevPage: Int,
    @SerializedName("totalPage") val totalPage: Int,
) : Serializable {
    data class TreasureWildListingData(
        @SerializedName("id") val id: String,
        @SerializedName("createdDate") val createdDate: String,
        @SerializedName("updatedDate") val updatedDate: String,
        @SerializedName("title") val title: String,
        @SerializedName("description") val description: String,
        @SerializedName("location") val location: com.android.gowild.data.model.routes.LocationModel,
        @SerializedName("eventDate") val eventDate: String,
        @SerializedName("eventTime") val eventTime: String,
        @SerializedName("status") val status: String,
        @SerializedName("no_of_participants") val no_of_participants: String,
        @SerializedName("winnerId") val winnerId: String? = null,
        @SerializedName("picture") val picture: String?,
        @SerializedName("a_r") val a_r: String,
        @SerializedName("treasureHunts") val treasureHunts: ArrayList<TreasureWildHunts>,
        @SerializedName("sponsors") val treasureWildSponsors: ArrayList<TreasureWildSponsors>,
        @SerializedName("current_user_hunt") val current_user_hunt: TreasureWildCurrentUserHunt?,
    ) : Serializable {

        data class TreasureWildSponsors(
            @SerializedName("id") val id: String,
            @SerializedName("createdDate") val createdDate: String,
            @SerializedName("updatedDate") val updatedDate: String,
            @SerializedName("treasure_chest") val treasure_chest: String,
            @SerializedName("img_url") val img_url: String,
            @SerializedName("img") val img: String,
            @SerializedName("link") val link: String,
        ) : Serializable

        data class TreasureWildHunts(
            @SerializedName("id") val id: String,
            @SerializedName("createdDate") val createdDate: String,
            @SerializedName("updatedDate") val updatedDate: String,
            @SerializedName("user_id") val user_id: String,
            @SerializedName("treasure_chest_id") val treasure_chest_id: String,
            @SerializedName("status") val status: String,
            @SerializedName("winStatus") val winStatus: String,
            @SerializedName("push_sent_at") val push_sent_at: String,
            @SerializedName("email_sent_at") val email_sent_at: String,
            @SerializedName("sms_sent_at") val sms_sent_at: String,
            @SerializedName("user") val user: TreasureWildUser,
        ) : Serializable {
            data class TreasureWildUser(
                @SerializedName("id") val id: String,
                @SerializedName("createdDate") val createdDate: String,
                @SerializedName("updatedDate") val updatedDate: String,
                @SerializedName("firstName") val firstName: String,
                @SerializedName("lastName") val lastName: String,
                @SerializedName("birthDate") val birthDate: String,
                @SerializedName("gender") val gender: String,
                @SerializedName("username") val username: String,
                @SerializedName("email") val email: String,
                @SerializedName("phoneNo") val phoneNo: String,
                @SerializedName("addressOne") val addressOne: String,
                @SerializedName("addressTwo") val addressTwo: String,
                @SerializedName("about_me") val about_me: String,
                @SerializedName("picture") val picture: String,
                @SerializedName("frontImage") val frontImage: String,
                @SerializedName("backImage") val backImage: String,
                @SerializedName("phoneVerified") val phoneVerified: Boolean,
            ) : Serializable

        }

        data class TreasureWildCurrentUserHunt(
            @SerializedName("id") val id: String,
            @SerializedName("createdDate") val createdDate: String,
            @SerializedName("updatedDate") val updatedDate: String,
            @SerializedName("user_id") val user_id: String,
            @SerializedName("treasure_chest_id") val treasure_chest_id: String,
            @SerializedName("status") val status: String,
            @SerializedName("winStatus") val winStatus: String,
            @SerializedName("push_sent_at") val push_sent_at: String,
            @SerializedName("email_sent_at") val email_sent_at: String,
            @SerializedName("sms_sent_at") val sms_sent_at: String,
            @SerializedName("user") val user: TreasureWildUser,
        ) : Serializable {
            data class TreasureWildUser(
                @SerializedName("id") val id: String,
                @SerializedName("createdDate") val createdDate: String,
                @SerializedName("updatedDate") val updatedDate: String,
                @SerializedName("firstName") val firstName: String,
                @SerializedName("lastName") val lastName: String,
                @SerializedName("birthDate") val birthDate: String,
                @SerializedName("gender") val gender: String,
                @SerializedName("username") val username: String,
                @SerializedName("email") val email: String,
                @SerializedName("phoneNo") val phoneNo: String,
                @SerializedName("addressOne") val addressOne: String,
                @SerializedName("addressTwo") val addressTwo: String,
                @SerializedName("about_me") val about_me: String,
                @SerializedName("picture") val picture: String,
                @SerializedName("frontImage") val frontImage: String,
                @SerializedName("backImage") val backImage: String,
                @SerializedName("phoneVerified") val phoneVerified: Boolean,
            ) : Serializable
        }


    }
}
