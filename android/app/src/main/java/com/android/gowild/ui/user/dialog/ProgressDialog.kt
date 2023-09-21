package com.android.gowild.ui.user.dialog

import android.content.Context
import android.graphics.Color
import android.graphics.drawable.ColorDrawable
import android.os.Bundle
import com.android.gowild.R
import com.android.gowild.databinding.DialogProgressBinding
import com.android.gowild.ui.base.BaseDialog

class ProgressDialog(internal val context: Context) : BaseDialog(context) {
    override fun onCreate(savedInstanceState: Bundle?) {
        this.setContentView(R.layout.dialog_progress)
        this.window!!.setBackgroundDrawable(ColorDrawable(Color.TRANSPARENT))
        this.setCancelable(true)
        this.setCanceledOnTouchOutside(false)
    }
}