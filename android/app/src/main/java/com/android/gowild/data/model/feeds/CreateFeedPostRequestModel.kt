package com.android.gowild.data.model.feeds

data class CreateFeedPostRequestModel(
    val description : String,
    val title : String = "",
    val is_published : Boolean = true
)