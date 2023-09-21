package com.android.gowild.utils.extension

import android.view.View
import com.google.android.material.snackbar.Snackbar

fun View.show() {
    visibility = View.VISIBLE
}

fun View.hide() {
    visibility = View.GONE
}

fun View.showBar(msg: String) {
    Snackbar.make(this, msg, Snackbar.LENGTH_SHORT).show()
}

fun View.clickAble() {
    isClickable = true
    isEnabled = true
}

fun View.notClickAble() {
    isClickable = false
    isEnabled = false
}