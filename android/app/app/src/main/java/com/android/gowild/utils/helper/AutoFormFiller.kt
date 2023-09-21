package com.android.gowild.utils.helper

import androidx.viewbinding.ViewBinding
import com.android.gowild.databinding.ActivityLoginBinding
import com.android.gowild.databinding.FragmentRegisterBinding
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class AutoFormFiller @Inject constructor() {

    fun fill(binding: ViewBinding) {
        when (binding) {
            is ActivityLoginBinding -> fillLoginForm(binding)
            is FragmentRegisterBinding -> fillRegisterForm(binding)
        }
    }

    private fun fillLoginForm(binding: ActivityLoginBinding) {
        binding.etEmail.setText("mb@softwarealliance.dk")
        binding.etPassword.setText("hello123")
    }

    private fun fillRegisterForm(binding: FragmentRegisterBinding) {
        binding.etFullName.setText("Muhammad Bilal")
        binding.etEmail.setText("mb@softwarealliance.dk")
        binding.etPassword.setText("hello123")
        binding.etPhoneNumber.setText("3056206548")
        binding.etAddressLine1.setText("Joher Town")
        binding.etAddressLine2.setText("Lahore")
    }

}