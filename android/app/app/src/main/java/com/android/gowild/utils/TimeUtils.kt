package com.android.gowild.utils

import android.text.format.DateUtils
import java.text.ParseException
import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Date
import java.util.Locale
import java.util.TimeZone

const val TIME_FORMAT_NOTIFICATION = "MMM d"
const val TIME_FORMAT_SUPPORT = "MMMM d, yyyy '|' h:mma"
const val TIME_FORMAT_TIME_STAMP = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
const val TIME_FORMAT_TIME = "HH:mm:ss"

//const val TIME_ZONE = "UTC"
const val TIME_ZONE_UTC = "UTC"

fun String.getRelativeTimeString(
    inputFormat: String = TIME_FORMAT_TIME_STAMP,
): String {
    val dateFormat = SimpleDateFormat(inputFormat, Locale.getDefault())
    dateFormat.timeZone = TimeZone.getTimeZone(TIME_ZONE_UTC)
    return try {
        val date = dateFormat.parse(this)!!
        DateUtils.getRelativeTimeSpanString(
            date.time,
            System.currentTimeMillis(),
            DateUtils.SECOND_IN_MILLIS
        ).toString()
    } catch (e: ParseException) {
        e.printStackTrace()
        this
    }
}

fun String?.changeDateFormat(inputFormat: String, outputFormat: String): String {
    if (this == null || this == "")
        return ""
    return try {
        val inputSDF = SimpleDateFormat(inputFormat, Locale.getDefault())
        val outputSDF = SimpleDateFormat(outputFormat, Locale.getDefault())
        inputSDF.timeZone = TimeZone.getTimeZone(TIME_ZONE_UTC)
        outputSDF.timeZone = TimeZone.getDefault()
        outputSDF.format(inputSDF.parse(this)!!)
    } catch (e: ParseException) {
        this
    }
}

fun Long.toTime(outputFormat: String = TIME_FORMAT_TIME_STAMP): String {
    val calendar: Calendar = Calendar.getInstance()
    calendar.timeInMillis = this
    val dateFormat = SimpleDateFormat(outputFormat, Locale.getDefault())
    dateFormat.timeZone = TimeZone.getTimeZone(TIME_ZONE_UTC)
    return dateFormat.format(calendar.time)
}

fun String.toDate(timeFormat: String = TIME_FORMAT_TIME_STAMP): Date {
    val formatter = SimpleDateFormat(timeFormat, Locale.ENGLISH)
    return Date(formatter.parse(this)!!.time)
}

fun String.toCalendar(timeFormat: String = TIME_FORMAT_TIME_STAMP): Calendar {
    val calendar = Calendar.getInstance()
    calendar.time = this.toDate(timeFormat)
    return calendar
}