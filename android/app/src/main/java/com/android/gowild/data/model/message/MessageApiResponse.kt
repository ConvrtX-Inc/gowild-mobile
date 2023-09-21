package com.android.gowild.data.model.message

import com.google.gson.annotations.SerializedName

data class MessageApiResponse(
    @SerializedName("data") val data: ArrayList<MessageDetail>,
    @SerializedName("count") val count: Int,
    @SerializedName("currentPage") val currentPage: Int,
    @SerializedName("prevPage") val prevPage: Int?,
    @SerializedName("totalPage") val totalPage: Int,
) : java.io.Serializable {

    data class MessageDetail(
        @SerializedName("id") val id: String,
        @SerializedName("createdDate") val createdDate: String,
        @SerializedName("updatedDate") val updatedDate: String,
        @SerializedName("room_id") val room_id: String,
        @SerializedName("user_id") val user_id: String,
        @SerializedName("message") val message: String,
        @SerializedName("attachment") val attachment: String?,
    ) : java.io.Serializable
}
