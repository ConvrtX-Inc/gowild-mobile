package com.android.gowild.ui.user.dialog

import android.content.Context
import android.os.Bundle
import com.android.gowild.databinding.DialogErrorBinding
import com.android.gowild.ui.base.BaseDialog

class ErrorDialog(
    internal val context: Context,
    private val errors: List<String>
) : BaseDialog(context) {

    private val binding = DialogErrorBinding.inflate(layoutInflater)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(binding.root)
        setCancelable(false)

        binding.tvError.text = errors[0]
        binding.btnOkay.setOnClickListener { dismiss() }
    }

}

class ErrorMessage(
    internal val context: Context,
    private val error: String
) : BaseDialog(context) {

    private val binding = DialogErrorBinding.inflate(layoutInflater)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(binding.root)
        setCancelable(false)

        binding.tvError.text = error
        binding.btnOkay.setOnClickListener { dismiss() }
    }

}