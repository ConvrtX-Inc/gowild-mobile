package com.android.gowild.dialogs

import android.content.DialogInterface
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.DialogFragment
import com.android.gowild.BuildConfig
import com.android.gowild.R
import com.android.gowild.data.model.myTrail.HistoricalEvents
import com.android.gowild.databinding.DialogHistoricalPointBinding
import com.android.gowild.utils.extension.inVisible
import com.android.gowild.utils.extension.loadImage
import com.android.gowild.utils.extension.visible

class HistoricalEventDialog(var historicalEvent: HistoricalEvents, var onDismiss: () -> Unit) : DialogFragment() {

    lateinit var binding: DialogHistoricalPointBinding

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View {
        super.onCreateView(inflater, container, savedInstanceState)
        binding = DialogHistoricalPointBinding.inflate(layoutInflater, container, false)
        init()
        return binding.root
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setStyle(STYLE_NO_TITLE, R.style.DialogStyle)
    }

    fun init() {
        setData()
        setCallbacks()
    }

    private fun setData() {
        with(binding) {
            tvTitle.text = historicalEvent.title
            tvDescription.text = historicalEvent.description
            ivImage.loadImage(BuildConfig.BASE_URL + historicalEvent.image)
        }
    }

    fun setCallbacks() {
        with(binding) {
            ivClose.setOnClickListener {
                ivClose.inVisible()
//                cvImage.inVisible()
                ivImage.inVisible()
                tvTitle.inVisible()
                btnGotIt.visible()
                tvDescription.visible()
                tvLabelDidYouKnow.visible()
            }
            btnGotIt.setOnClickListener {
                dismiss()
            }
        }
    }

    override fun onDismiss(dialog: DialogInterface) {
        super.onDismiss(dialog)
        onDismiss.invoke()
    }

    override fun onCancel(dialog: DialogInterface) {
        super.onCancel(dialog)
        onDismiss.invoke()
    }
}