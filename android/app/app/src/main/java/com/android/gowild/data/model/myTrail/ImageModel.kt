package com.android.gowild.data.model.myTrail

data class ImageModel(
    val createdDate: String,
    val fileName: String,
    val id: String,
    val metaData: MetaDataModel,
    val mimetype: String,
    val path: String,
    val size: Int,
    val updatedDate: String
)