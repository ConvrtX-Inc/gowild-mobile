package com.android.gowild.utils

import android.annotation.SuppressLint
import android.content.ContentUris
import android.content.ContentValues
import android.content.Context
import android.database.Cursor
import android.net.Uri
import android.os.Build
import android.os.Environment
import android.provider.DocumentsContract
import android.provider.MediaStore
import androidx.loader.content.CursorLoader
import com.yalantis.ucrop.util.FileUtils.getDataColumn
import com.yalantis.ucrop.util.FileUtils.isDownloadsDocument
import com.yalantis.ucrop.util.FileUtils.isExternalStorageDocument
import com.yalantis.ucrop.util.FileUtils.isGooglePhotosUri
import com.yalantis.ucrop.util.FileUtils.isMediaDocument
import java.io.File


@SuppressLint("Range")
fun getUriFromPath(context: Context, file: File): Uri? {
    val filePath: String = file.absolutePath
    val cursor: Cursor? = context.contentResolver.query(
        MediaStore.Images.Media.EXTERNAL_CONTENT_URI, arrayOf(MediaStore.Images.Media._ID),
        MediaStore.Images.Media.DATA + "=? ", arrayOf(filePath), null
    )
    return if (cursor != null && cursor.moveToFirst()) {
        val id: Int = cursor.getInt(cursor.getColumnIndex(MediaStore.MediaColumns._ID))
        cursor.close()
        Uri.withAppendedPath(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, "" + id)
    } else {
        if (file.exists()) {
            val values = ContentValues()
            values.put(MediaStore.Images.Media.DATA, filePath)
            context.contentResolver.insert(
                MediaStore.Images.Media.EXTERNAL_CONTENT_URI, values
            )
        } else {
            null
        }
    }
}

/**
 * Get Path from URI
 *
 * @param context context
 * @param uri     uri
 * @return String
 */
fun getPathFromUri(context: Context, uri: Uri): String? {
    val isKitKat = Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT

    // DocumentProvider
    if (isKitKat && DocumentsContract.isDocumentUri(context, uri)) {
        // ExternalStorageProvider
        if (isExternalStorageDocument(uri)) {
            val docId = DocumentsContract.getDocumentId(uri)
            val split = docId.split(":".toRegex()).dropLastWhile { it.isEmpty() }.toTypedArray()
            val type = split[0]
            if ("primary".equals(type, ignoreCase = true)) {
                return Environment.getExternalStorageDirectory().toString() + "/" + split[1]
            }

            // TODO handle non-primary volumes
        } else if (isDownloadsDocument(uri)) {
            val id = DocumentsContract.getDocumentId(uri)
            val contentUri: Uri = ContentUris.withAppendedId(
                Uri.parse("content://downloads/public_downloads"), java.lang.Long.valueOf(id)
            )
            return getDataColumn(context, contentUri, null, null)
        } else if (isMediaDocument(uri)) {
            val docId = DocumentsContract.getDocumentId(uri)
            val split = docId.split(":".toRegex()).dropLastWhile { it.isEmpty() }.toTypedArray()
            val type = split[0]
            var contentUri: Uri? = null
            if ("image" == type) {
                contentUri = MediaStore.Images.Media.EXTERNAL_CONTENT_URI
            } else if ("video" == type) {
                contentUri = MediaStore.Video.Media.EXTERNAL_CONTENT_URI
            } else if ("audio" == type) {
                contentUri = MediaStore.Audio.Media.EXTERNAL_CONTENT_URI
            }
            val selection = "_id=?"
            val selectionArgs = arrayOf(
                split[1]
            )
            return getDataColumn(context, contentUri, selection, selectionArgs)
        }
    } else if ("content".equals(uri.scheme, ignoreCase = true)) {

        // Return the remote address
        return if (isGooglePhotosUri(uri)) uri.lastPathSegment else getDataColumn(context, uri, null, null)
    } else if ("file".equals(uri.scheme, ignoreCase = true)) {
        return uri.path
    }
    return null
}

private fun getDataColumn(
    context: Context, uri: Uri?, selection: String?,
    selectionArgs: Array<String>?
): String? {
    if (uri == null)
        return null
    val column = "_data"
    val projection = arrayOf(
        column
    )
    context.contentResolver.query(
        uri, projection, selection, selectionArgs,
        null
    ).use { cursor ->
        if (cursor != null && cursor.moveToFirst()) {
            val index: Int = cursor.getColumnIndexOrThrow(column)
            return cursor.getString(index)
        }
    }
    return null
}


/**
 * @param uri The Uri to check.
 * @return Whether the Uri authority is ExternalStorageProvider.
 */
private fun isExternalStorageDocument(uri: Uri): Boolean {
    return "com.android.externalstorage.documents" == uri.authority
}

/**
 * @param uri The Uri to check.
 * @return Whether the Uri authority is DownloadsProvider.
 */
private fun isDownloadsDocument(uri: Uri): Boolean {
    return "com.android.providers.downloads.documents" == uri.authority
}

/**
 * @param uri The Uri to check.
 * @return Whether the Uri authority is MediaProvider.
 */
private fun isMediaDocument(uri: Uri): Boolean {
    return "com.android.providers.media.documents" == uri.authority
}

/**
 * @param uri The Uri to check.
 * @return Whether the Uri authority is Google Photos.
 */
private fun isGooglePhotosUri(uri: Uri): Boolean {
    return "com.google.android.apps.photos.content" == uri.authority
}

fun getFileName(url: String): String? {
    return url.substring(url.lastIndexOf('/') + 1)
}


fun getRealPath(context: Context, fileUri: Uri): String? {
    // SDK < API11
    val realPath: String = if (Build.VERSION.SDK_INT < 11) {
        getRealPathFromURI_BelowAPI11(context, fileUri)
    } else if (Build.VERSION.SDK_INT < 19) {
        getRealPathFromURI_API11to18(context, fileUri)
    } else {
        getRealPathFromURI_API19(context, fileUri)
    }
    return realPath
}


@SuppressLint("NewApi")
fun getRealPathFromURI_API11to18(context: Context?, contentUri: Uri?): String {
    val proj = arrayOf(MediaStore.Images.Media.DATA)
    var result = ""
    val cursorLoader = CursorLoader(context!!, contentUri!!, proj, null, null, null)
    val cursor: Cursor? = cursorLoader.loadInBackground()
    if (cursor != null) {
        val column_index = cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA)
        cursor.moveToFirst()
        result = cursor.getString(column_index)
        cursor.close()
    }
    return result
}

fun getRealPathFromURI_BelowAPI11(context: Context, contentUri: Uri?): String {
    val proj = arrayOf(MediaStore.Images.Media.DATA)
    val cursor = context.contentResolver.query(contentUri!!, proj, null, null, null)
    var column_index = 0
    var result: String = ""
    if (cursor != null) {
        column_index = cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA)
        cursor.moveToFirst()
        result = cursor.getString(column_index)
        cursor.close()
        return result
    }
    return result
}

/**
 * Get a file path from a Uri. This will get the the path for Storage Access
 * Framework Documents, as well as the _data field for the MediaStore and
 * other file-based ContentProviders.
 *
 * @param context The context.
 * @param uri     The Uri to query.
 * @author paulburke
 */
@SuppressLint("NewApi")
fun getRealPathFromURI_API19(context: Context?, uri: Uri): String {
    val isKitKat = Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT

    // DocumentProvider
    if (isKitKat && DocumentsContract.isDocumentUri(context, uri)) {
        // ExternalStorageProvider
        if (isExternalStorageDocument(uri)) {
            val docId = DocumentsContract.getDocumentId(uri)
            val split = docId.split(":".toRegex()).dropLastWhile { it.isEmpty() }.toTypedArray()
            val type = split[0]
            if ("primary".equals(type, ignoreCase = true)) {
                return Environment.getExternalStorageDirectory().toString() + "/" + split[1]
            }

            // TODO handle non-primary volumes
        } else if (isDownloadsDocument(uri)) {
            val id = DocumentsContract.getDocumentId(uri)
            val contentUri = ContentUris.withAppendedId(
                Uri.parse("content://downloads/public_downloads"), java.lang.Long.valueOf(id)
            )
            return getDataColumn(context, contentUri, null, null)
        } else if (isMediaDocument(uri)) {
            val docId = DocumentsContract.getDocumentId(uri)
            val split = docId.split(":".toRegex()).dropLastWhile { it.isEmpty() }.toTypedArray()
            val type = split[0]
            var contentUri: Uri? = null
            if ("image" == type) {
                contentUri = MediaStore.Images.Media.EXTERNAL_CONTENT_URI
            } else if ("video" == type) {
                contentUri = MediaStore.Video.Media.EXTERNAL_CONTENT_URI
            } else if ("audio" == type) {
                contentUri = MediaStore.Audio.Media.EXTERNAL_CONTENT_URI
            }
            val selection = "_id=?"
            val selectionArgs = arrayOf(
                split[1]
            )
            return getDataColumn(context, contentUri, selection, selectionArgs)
        }
    } else if ("content".equals(uri.scheme, ignoreCase = true)) {

        // Return the remote address
        return if (isGooglePhotosUri(uri)) uri.lastPathSegment!! else getDataColumn(context, uri, null, null)
    } else if ("file".equals(uri.scheme, ignoreCase = true)) {
        return uri.path!!
    }
    return ""
}
