package com.android.gowild.data.model.homeModels

import android.net.Uri
import androidx.documentfile.provider.DocumentFile
import com.android.gowild.data.model.user.User

data class HomeFeedCreatePostModel(
    var user: User? = null,
    var selectedImageUri: Uri? = null,
    var selectedAttachmentUri: DocumentFile? = null
)