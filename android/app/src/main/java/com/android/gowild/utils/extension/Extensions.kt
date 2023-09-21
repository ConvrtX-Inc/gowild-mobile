package com.android.gowild.utils.extension

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.content.Intent
import android.content.res.Resources
import android.graphics.Bitmap
import android.graphics.Color
import android.graphics.drawable.Drawable
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.net.Uri
import android.os.Build
import android.provider.Settings
import android.text.TextUtils
import android.util.Patterns
import android.view.View
import android.view.inputmethod.InputMethodManager
import android.widget.EditText
import android.widget.ImageView
import android.widget.Toast
import androidx.annotation.*
import androidx.appcompat.app.AlertDialog
import androidx.core.content.ContextCompat
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.RecyclerView
import androidx.viewpager2.widget.ViewPager2
import com.android.gowild.BuildConfig
import com.android.gowild.R
import com.android.gowild.data.model.friends.MyFriendsUserModel
import com.android.gowild.data.model.user.User
import com.android.gowild.ui.base.BindingRecyclerAdapter
import com.bumptech.glide.Glide
import com.bumptech.glide.request.Request
import com.bumptech.glide.request.target.SizeReadyCallback
import com.bumptech.glide.request.target.Target
import com.bumptech.glide.request.transition.Transition
import com.bumptech.glide.signature.ObjectKey
import timber.log.Timber
import java.math.BigDecimal
import java.math.RoundingMode
import java.util.*

@ColorInt
@SuppressLint("Recycle")
fun Context.themeColor(@AttrRes themeAttrId: Int): Int =
    obtainStyledAttributes(intArrayOf(themeAttrId)).use {
        it.getColor(0, Color.MAGENTA)
    }

@ColorInt
fun Activity.themeColor(@AttrRes themeAttrId: Int): Int = applicationContext.themeColor(themeAttrId)

fun String.isValidEmail(): Boolean {
    return !TextUtils.isEmpty(this) && Patterns.EMAIL_ADDRESS.matcher(this).matches()
}

fun Fragment.toast(message: String, length: Int = Toast.LENGTH_LONG) {
    requireContext().toast(message, length)
}

fun Activity.toast(message: String, length: Int = Toast.LENGTH_LONG) {
    applicationContext.toast(message, length)
}

fun Context.toast(message: String, length: Int = Toast.LENGTH_LONG) {
    Toast.makeText(applicationContext, message, length).show()
}

fun <T, L> RecyclerView.setRecyclerViewAdapter(
    @LayoutRes layout: Int,
    data: ArrayList<T>,
    options: String? = null,
    listener: L? = null,
): BindingRecyclerAdapter<T, L> {
    val adapter = BindingRecyclerAdapter(
        layout, data, options, listener
    )
    this.adapter = adapter
    return adapter
}

fun <T, L> ViewPager2.setRecyclerViewAdapter(
    @LayoutRes layout: Int,
    data: ArrayList<T>,
    options: String? = null,
    listener: L? = null,
) {
    this.adapter = BindingRecyclerAdapter(
        layout, data, options, listener
    )
}

fun Activity.getAsColor(@ColorRes color: Int): Int {
    return ContextCompat.getColor(applicationContext, color)
}

fun Fragment.getAsColor(@ColorRes color: Int): Int {
    return requireActivity().getAsColor(color)
}

fun Context.getAsColor(@ColorRes color: Int): Int {
    return ContextCompat.getColor(this, color)
}

fun Activity.getAsDrawable(@DrawableRes drawable: Int): Drawable? {
    return ContextCompat.getDrawable(applicationContext, drawable)
}

fun Fragment.getAsDrawable(@DrawableRes drawable: Int): Drawable? {
    return requireActivity().getAsDrawable(drawable)
}

fun Context.getAsDrawable(@DrawableRes drawable: Int): Drawable? {
    return ContextCompat.getDrawable(this, drawable)
}

val Int.dp: Int
    get() = (this * Resources.getSystem().displayMetrics.density).toInt()

fun View.visible() {
    this.visibility = View.VISIBLE
}

fun View.inVisible() {
    this.visibility = View.INVISIBLE
}

fun View.gone() {
    this.visibility = View.GONE
}

fun Activity.shareText(title: String = "Share Via", desc: String = "Check out this post on Go-Wild") {
    val intent = Intent(Intent.ACTION_SEND)
    intent.putExtra(
        Intent.EXTRA_TEXT,
        desc
    )
    intent.type = "text/plain"
    startActivity(Intent.createChooser(intent, title))
}

fun Fragment.shareText(title: String = "Share Via", desc: String = "Check out this post on Go-Wild") {
    requireActivity().shareText(title, desc)
}

fun RecyclerView.isRVEmpty(): Boolean {
    if (this.adapter == null)
        return true
    if (this.adapter!!.itemCount == 0)
        return true
    return false
}

fun Activity.navigateToGoogleMap(lat: Double, lng: Double, title: String = "Mosque") {
    if (lat == 0.0 || lng == 0.0) {
        toast("Invalid location")
        return
    }
    val gmmIntentUri = Uri.parse("geo:$lat,$lng?q=$lat,$lng($title)")
    val mapIntent = Intent(Intent.ACTION_VIEW, gmmIntentUri)
    mapIntent.setPackage("com.google.android.apps.maps")
    if (mapIntent.resolveActivity(packageManager) != null) {
        startActivity(mapIntent)
    } else {
        toast("An error occurred when opening Google Maps ")
    }
}

fun Fragment.navigateToGoogleMap(lat: Double, lng: Double, title: String = "Mosque") {
    requireActivity().navigateToGoogleMap(lat, lng, title)
}

fun Double.round(zeroes: Int = 1): String =
    if (BigDecimal(this).setScale(zeroes, RoundingMode.FLOOR).toString().split(".")[1] == "0") {
        BigDecimal(this).setScale(zeroes, RoundingMode.FLOOR).toString().split(".")[0]
    } else {
        BigDecimal(this).setScale(zeroes, RoundingMode.FLOOR).toString()
    }

fun String.titleCaseFirstCharIfItIsLowercase() = replaceFirstChar {
    if (it.isLowerCase()) it.titlecase(Locale.getDefault()) else it.toString()
}

fun String.titleCase() = lowercase().titleCaseFirstCharIfItIsLowercase()

fun Activity.goToSettings() {
    val myAppSettings =
        Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS, Uri.parse("package:$packageName"))
    myAppSettings.addCategory(Intent.CATEGORY_DEFAULT)
    myAppSettings.flags = Intent.FLAG_ACTIVITY_NEW_TASK
    startActivityForResult(myAppSettings, 101)
}

fun Fragment.goToSettings() {
    val myAppSettings = Intent(
        Settings.ACTION_APPLICATION_DETAILS_SETTINGS,
        Uri.parse("package:${activity!!.packageName}")
    )
    myAppSettings.addCategory(Intent.CATEGORY_DEFAULT)
    myAppSettings.flags = Intent.FLAG_ACTIVITY_NEW_TASK
    (requireActivity() as Activity).startActivityForResult(myAppSettings, 101)
}

fun Activity.showSettingsDialog() {
    val builder = AlertDialog.Builder(this)
    builder.setTitle("Permission Alert")
    builder.setMessage("Please allow permissions to use this feature")
    builder.setPositiveButton(android.R.string.ok) { dialog, which ->
        goToSettings()
    }
    builder.setNegativeButton(android.R.string.cancel) { dialog, which ->
        Toast.makeText(
            applicationContext,
            android.R.string.cancel, Toast.LENGTH_SHORT
        ).show()
    }
    builder.show()
}

fun Fragment.showSettingsDialog() {
    val builder = AlertDialog.Builder(context!!)
    builder.setTitle("Permission Alert")
    builder.setMessage("Please allow permissions to use this feature")
    builder.setPositiveButton(android.R.string.ok) { dialog, which ->
        goToSettings()
    }
    builder.setNegativeButton(android.R.string.cancel) { dialog, which ->
        Toast.makeText(
            context,
            android.R.string.cancel, Toast.LENGTH_SHORT
        ).show()
    }
    builder.show()
}

fun ImageView.loadImage(url: String?, @DrawableRes placeHolder: Int = R.drawable.user_placeholder) {
    Glide
        .with(this.context)
        .load(url)
        .placeholder(placeHolder)
        .error(placeHolder)
        .into(this)
}

fun ImageView.loadSmallImage(url: String?, @DrawableRes placeHolder: Int = R.drawable.user_placeholder) {
    Glide
        .with(this.context)
        .load(url)
        .placeholder(placeHolder)
        .override(100,100)
        .error(placeHolder)
        .into(this)
}

fun ImageView.loadUserImage(user: User) {
    Glide
        .with(this.context)
        .load(BuildConfig.BASE_URL + user.picture)
        .placeholder(R.drawable.user_placeholder)
        .error(R.drawable.user_placeholder)
        .signature(ObjectKey(user.updatedDate!!))
        .into(this)
}

fun String.isInt(): Boolean = try {
    Integer.parseInt(this)
    true
} catch (e: Exception) {
    false
}

fun ImageView.loadImage(@DrawableRes resourceID: Int) {
    Glide.with(this.context).load(resourceID).into(this)
}

fun ImageView.loadImage(bitmap: Bitmap) {
    Glide.with(this.context).load(bitmap).into(this)
}

fun ImageView.loadImage(uri: Uri?) {
    Glide.with(this.context).load(uri).into(this)
}

fun String.isNumber(): Boolean {
    return if (this.isEmpty()) false else this.all { Character.isDigit(it) }
}

fun Fragment.showKeyboard(edittext: EditText) {
    val imm = requireContext().getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
    imm.showSoftInput(edittext, InputMethodManager.SHOW_FORCED)
}

fun Fragment.hideKeyboard() {
    val imm = requireContext().getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
    imm.hideSoftInputFromWindow(requireActivity().window!!.decorView.windowToken, 0)
}

fun Context?.isNetworkAvailable(): Boolean {
    if (this == null) return false
    val connectivityManager =
        this.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
        val capabilities =
            connectivityManager.getNetworkCapabilities(connectivityManager.activeNetwork)
        if (capabilities != null) {
            when {
                capabilities.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) -> {
                    return true
                }
                capabilities.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) -> {
                    return true
                }
                capabilities.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET) -> {
                    return true
                }
            }
        }
    } else {
        val activeNetworkInfo = connectivityManager.activeNetworkInfo
        if (activeNetworkInfo != null && activeNetworkInfo.isConnected) {
            return true
        }
    }
    return false
}

fun isOnline(context: Context): Boolean {
    val connectivityManager =
        context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
    val netInfo = connectivityManager.activeNetworkInfo
    return netInfo != null && netInfo.isConnected
}

fun getGoogleMapStaticURL(path: String, size: String = "600x400", apiKey: String = BuildConfig.GOOGLE_MAP_API_KEY): String {
    val url = "https://maps.googleapis.com/maps/api/staticmap?size=${size}&path=color:0xFF7851%7Cenc:${path}&key=$apiKey"
    Timber.tag("GOOGLE_IMAGE").wtf(url)
    return url
}