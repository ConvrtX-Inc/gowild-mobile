package com.android.gowild.utils.extension

import com.android.gowild.data.model.base.JunkResponse
import okhttp3.ResponseBody
import org.json.JSONObject


fun String.getJunkResponse(): JunkResponse? {
    val errorBody: JSONObject = JSONObject(this)
    val errors: ArrayList<Map<String, String>> = ArrayList()
    try {
        if (errorBody.has("errors") && errorBody.getJSONArray("errors").length() > 0) {
            val errorsJson = errorBody.getJSONArray("errors")
            for (i in 0 until errorsJson.length()) {
                val errorObject: JSONObject = errorsJson.get(i) as JSONObject
                errorObject.keys().forEach { key ->
                    errors.add(mapOf(Pair(key.toString(), errorObject.getString(key.toString()).toString())))
                }
            }
            return JunkResponse(errors)
        }
        if (errors.isEmpty())
            return null
    } catch (e: Exception) {
        e.printStackTrace()
        return null
    }
    return null
}

fun ResponseBody.getJunkResponse(): JunkResponse? {
    val errorBody: JSONObject = JSONObject()
    val junkResponse: JunkResponse? = null
    return try {
        if (errorBody.has("errors")) {
            val jsonArray = errorBody.getJSONArray("errors")
            jsonArray.length()
        }

        null
    } catch (e: Exception) {
        e.printStackTrace()
        null
    }
}