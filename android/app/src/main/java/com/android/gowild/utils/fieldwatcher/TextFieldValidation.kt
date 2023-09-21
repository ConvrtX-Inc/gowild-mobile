package com.android.gowild.utils.fieldwatcher

import android.text.Editable
import android.text.TextWatcher
import android.widget.EditText
import com.android.gowild.R
import com.android.gowild.utils.constant.ValidationConst.validateEmail
import com.android.gowild.utils.constant.ValidationConst.validateFullName
import com.android.gowild.utils.constant.ValidationConst.validatePassword
import com.android.gowild.utils.constant.ValidationConst.validateAddress

class TextFieldValidation(var editText : EditText) : TextWatcher {

    override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {
    }

    override fun onTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {
        when (editText.id) {
            R.id.et_full_name -> {
                editText.context.resources.validateFullName(editText)
            }
            R.id.et_email -> {
                editText.context.resources.validateEmail(editText)
            }
            R.id.et_password -> {
                editText.context.resources.validatePassword(editText)
            }
            R.id.et_address_line_1 -> {
                editText.context.resources.validateAddress(editText)
            }
            R.id.et_address_line_2 -> {
                editText.context.resources.validateAddress(editText)
            }
        }
    }

    override fun afterTextChanged(p0: Editable?) {

    }

}