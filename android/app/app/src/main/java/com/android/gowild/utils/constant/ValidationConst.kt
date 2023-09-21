package com.android.gowild.utils.constant

import android.app.Activity
import android.content.res.Resources
import android.util.Patterns
import android.widget.EditText
import androidx.fragment.app.Fragment
import com.android.gowild.R
import java.util.regex.Pattern

object ValidationConst {

    private fun isValidPattern(input: String?, CHECK_PATTERN: String?): Boolean {
        val pattern = Pattern.compile(CHECK_PATTERN)
        val matcher = pattern.matcher(input)
        return matcher.matches()
    }

    fun Fragment.validateFullName(editText: EditText): Boolean {
        return resources.validateFullName(editText)
    }

    fun Activity.validateFullName(editText: EditText): Boolean {
        return resources.validateFullName(editText)
    }

    fun Resources.validateFullName(editText: EditText): Boolean {
        if (editText.text.toString().isEmpty()) {
            editText.error = getString(R.string.required_field)
            editText.requestFocus()
            return false
        } else if (editText.text.toString().length < 3) {
            editText.error = getString(R.string.please_enter_full_name)
            editText.requestFocus()
            return false
        } else if (editText.text.toString().length > 30) {
            editText.error = getString(R.string.entered_name_is_too_long)
            editText.requestFocus()
            return false
        } else if (!editText.text.toString().matches("^[^\\s][ A-Za-z]*\$".toRegex())) {
            editText.error = "Name can only contain alphabets"
            editText.requestFocus()
            return false
        } else {
            editText.error = null
        }
        return true
    }

    fun Resources.validateEmail(editText: EditText): Boolean {
        if (editText.text.toString().isEmpty()) {
            editText.error = getString(R.string.required_field)
            editText.requestFocus()
            return false
        } else if (!Patterns.EMAIL_ADDRESS.matcher(editText.text.toString()).matches()) {
            editText.error = getString(R.string.email_is_not_valid)
            editText.requestFocus()
            return false
        } else {
            editText.error = null
        }
        return true
    }

    fun Fragment.validateEmail(editText: EditText): Boolean {
        return resources.validateEmail(editText)
    }

    fun Activity.validateEmail(editText: EditText): Boolean {
        return resources.validateEmail(editText)
    }

    fun Resources.validateAddress(editText: EditText): Boolean {
        if (editText.text.toString().isEmpty()) {
            editText.error = getString(R.string.required_field)
            editText.requestFocus()
            return false
        } else {
            editText.error = null
        }
        return true
    }

    fun Fragment.validateAddress(editText: EditText): Boolean {
        return resources.validateAddress(editText)
    }

    fun Activity.validateAddress(editText: EditText): Boolean {
        return resources.validateAddress(editText)
    }

    fun Resources.validatePassword(editText: EditText): Boolean {
        if (editText.text.toString().isEmpty()) {
            editText.error = getString(R.string.required_field)
            editText.requestFocus()
            return false
        } else if (editText.text.toString().length < 6) {
            editText.error = getString(R.string.password_must_more_then_6)
            editText.requestFocus()
            return false
        } else {
            editText.error = null
        }
        return true
    }

    fun Fragment.validatePassword(editText: EditText): Boolean {
        return resources.validatePassword(editText)
    }

    fun Activity.validatePassword(editText: EditText): Boolean {
        return resources.validatePassword(editText)
    }

    fun Resources.validateBothPassword(password: EditText, confirmPassword: EditText): Boolean {
        if (password.text.toString().isEmpty()) {
            password.error = getString(R.string.required_field)
            password.requestFocus()
            return false
        } else if (password.text.toString().length < 6) {
            password.error = getString(R.string.password_must_more_then_6)
            password.requestFocus()
            return false
        } else if (confirmPassword.text.toString() != password.text.toString()) {
            confirmPassword.error = getString(R.string.password_does_not_match)
            confirmPassword.requestFocus()
            return false
        } else {
            password.error = null
            confirmPassword.error = null
        }
        return true
    }

    fun Fragment.validateBothPassword(password: EditText, confirmPassword: EditText): Boolean {
        return resources.validateBothPassword(password, confirmPassword)
    }

    fun Activity.validateBothPassword(password: EditText, confirmPassword: EditText): Boolean {
        return resources.validateBothPassword(password, confirmPassword)
    }
}