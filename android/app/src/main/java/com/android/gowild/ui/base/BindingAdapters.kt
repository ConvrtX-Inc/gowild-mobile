package com.android.gowild.ui.base

import android.graphics.Bitmap
import android.net.Uri
import android.util.Log
import android.widget.ImageView
import android.widget.TextView
import androidx.annotation.DrawableRes
import androidx.cardview.widget.CardView
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.databinding.BindingAdapter
import androidx.recyclerview.widget.RecyclerView
import com.android.gowild.BuildConfig
import com.android.gowild.R
import com.android.gowild.data.model.myTrail.SaveRoutesLeaderboardModel
import com.android.gowild.data.model.user.User
import com.android.gowild.utils.extension.*
import com.google.android.gms.maps.model.LatLng
import com.google.android.material.card.MaterialCardView
import com.google.gson.Gson
import com.google.maps.android.PolyUtil
import com.mapbox.maps.extension.style.expressions.dsl.generated.image
import de.hdodenhof.circleimageview.CircleImageView
import timber.log.Timber
import java.math.RoundingMode

@BindingAdapter("image_url", "placeholder", requireAll = false)
fun loadURL(imageView: ImageView, imageURL: String?, @DrawableRes placeHolder: Int = R.drawable.user_placeholder) {
    Timber.tag("GLIDE_IMAGE_URL").wtf("$imageURL")
    imageView.loadImage(imageURL, placeHolder)
}

@BindingAdapter("image_user")
fun loadUserImage(imageView: ImageView, user: User?) {
    if (user != null) {
        imageView.loadUserImage(user)
    }
}

@BindingAdapter("image_user")
fun loadUserImage(imageView: CircleImageView, user: User?) {
    if (user != null) {
        imageView.loadUserImage(user)
    }
}

@BindingAdapter("text_user_name")
fun setUserName(textView: TextView, userString : String?) {
    if (userString != null) {
        val user = Gson().fromJson(userString,User::class.java)
        textView.text = "${user.firstName} ${user.lastName}"
    }
}

@BindingAdapter("image_user_string")
fun loadUserImage(imageView: CircleImageView, userString : String?) {
    if (userString != null) {
        imageView.loadUserImage(Gson().fromJson(userString,User::class.java))
    }
}



@BindingAdapter("bitmap")
fun loadBitmap(imageView: ImageView, bitmap: Bitmap?) {
    if (bitmap != null) imageView.loadImage(bitmap)
}

@BindingAdapter("uri")
fun loadURI(imageView: ImageView, uri: Uri?) {
    if (uri != null) imageView.loadImage(uri)
}

@BindingAdapter("round_value")
fun roundValue(textView: TextView, value: Double?) {
    if (value != null) {
        val roundedValue = value.toBigDecimal().setScale(2, RoundingMode.UP).toDouble()
        textView.text = "$roundedValue Miles"
    }
}

@BindingAdapter("layout", "data", "options", requireAll = false)
fun setAdapter(recyclerView: RecyclerView, layout: Int, data: ArrayList<SaveRoutesLeaderboardModel>?, options: String?) {
    if (data != null && data.isNotEmpty()) {
        recyclerView.visible()
        recyclerView.setRecyclerViewAdapter(layout, data, options, null)
    } else {
        recyclerView.gone()
        recyclerView.adapter = null
    }
}

@BindingAdapter("set_map_image")
fun setMapImage(imageView: ImageView, route_path: String?) {
    if (route_path != null) {
        try {
            val polylineArrayList: ArrayList<LatLng> = ArrayList()
            polylineArrayList.addAll(PolyUtil.decode(route_path))
            if (polylineArrayList.isNotEmpty()) {
                imageView.loadImage(getGoogleMapStaticURL(route_path))
            } else {
                imageView.setImageDrawable(imageView.context.getAsDrawable(R.drawable.map))
            }
        } catch (e: Exception) {
            imageView.setImageDrawable(imageView.context.getAsDrawable(R.drawable.map))
            Log.wtf("INVALID_ROUTE", "Route cannot be created invalid string")
        }
    }
}

@BindingAdapter("leaderboard_user_id", "saved_user_id")
fun setBackground(layout: ConstraintLayout, leaderboard_user_id: String?, saved_user_id: String?) {
    if (leaderboard_user_id != null && saved_user_id != null) {
        if (leaderboard_user_id.equals(saved_user_id)) {
            layout.setBackgroundResource(R.drawable.post_btn_bg)
            layout.setPadding(5, 5, 5, 5)
        } else layout.setPadding(5, 0, 5, 0)
    }
}

@BindingAdapter("adjustLayout")
fun adjustLayout(cardView: CardView, leaderboard: ArrayList<SaveRoutesLeaderboardModel>?) {
    if (leaderboard != null && leaderboard.size > 0) {
        cardView.layoutParams.width = 50.dp
    } else {
        cardView.layoutParams.width = 100.dp
    }
}

@BindingAdapter("set_badge")
fun setBadge(textView: TextView, rank: Int?) {
    if (rank != null) {
        when (rank) {
            1 -> {
                textView.setBackgroundResource(R.drawable.ic_badge_one)
            }
            2 -> {
                textView.setBackgroundResource(R.drawable.ic_badge_two)
            }
            3 -> {
                textView.setBackgroundResource(R.drawable.ic_badge_three)
            }
            else -> {
                textView.text = rank.toString()
                textView.setBackgroundResource(R.drawable.ic_badge_next)
            }
        }
    }
}

@BindingAdapter("support_attachment_cv")
fun setSupportAttachmentCardView(cardView: MaterialCardView, attachment: ArrayList<String>?) {
    if (attachment != null && attachment.isNotEmpty()) {
        cardView.visible()
    } else {
        cardView.gone()
    }
}

@BindingAdapter("support_attachment_iv")
fun setSupportAttachmentImageView(imageView: ImageView, attachment: ArrayList<String>?) {
    if (attachment != null && attachment.isNotEmpty()) {
        imageView.visible()
        if (attachment[0].contains("pdf")) {
            imageView.loadImage(R.drawable.pdf)
        } else {
            imageView.loadImage(BuildConfig.BASE_URL + attachment[0], R.drawable.image_placeholder)
        }
    } else {
        imageView.gone()
    }
}