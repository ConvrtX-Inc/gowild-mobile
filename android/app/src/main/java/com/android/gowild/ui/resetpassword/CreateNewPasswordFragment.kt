package com.android.gowild.ui.resetpassword

import android.app.Activity
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.viewModels
import androidx.viewbinding.ViewBinding
import com.android.gowild.R
import com.android.gowild.databinding.FragmentCreateNewPasswordBinding
import com.android.gowild.networking.Errors
import com.android.gowild.networking.NetworkResult
import com.android.gowild.ui.base.BaseFragment
import com.android.gowild.ui.login.LoginActivity
import com.android.gowild.ui.user.dialog.ErrorDialog
import com.android.gowild.utils.constant.NameConst
import com.android.gowild.utils.constant.ValidationConst.validateBothPassword
import com.android.gowild.utils.extension.showBar
import com.android.gowild.utils.fieldwatcher.TextFieldValidation


class CreateNewPasswordFragment : BaseFragment() {


    companion object {
        @JvmStatic
        fun newInstance(email: String, number: String, otp: String) =
            CreateNewPasswordFragment().apply {
                arguments = Bundle().apply {
                    putString(NameConst.NUMBER, number)
                    putString(NameConst.EMAIL, email)
                    putString(NameConst.OTP, otp)
                }
            }
    }

    private lateinit var binding: FragmentCreateNewPasswordBinding
    private val viewModel by viewModels<ResetPasswordVM>()
    private lateinit var number: String
    private lateinit var email: String
    private lateinit var otp: String

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        arguments?.let {
            number = it.getString(NameConst.NUMBER).toString()
            email = it.getString(NameConst.EMAIL).toString()
            otp = it.getString(NameConst.OTP).toString()
        }
    }

    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentCreateNewPasswordBinding.inflate(layoutInflater)
        return binding
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        listeners()
        setUpObservers()
    }

    private fun listeners() {

        binding.etPassword.addTextChangedListener(TextFieldValidation(binding.etPassword))

        binding.confirmPasswordEt.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {
            }

            override fun onTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {

            }

            override fun afterTextChanged(p0: Editable?) {
                if (p0 != null) {
                    if (p0.toString().isEmpty()) {
                        binding.confirmPasswordEt.error =
                            getString(R.string.required_field)
                        binding.confirmPasswordEt.requestFocus()
                    } else if (p0.toString() != binding.etPassword.text.toString()) {
                        binding.confirmPasswordEt.error =
                            getString(R.string.password_not_matched)
                        binding.confirmPasswordEt.requestFocus()
                    } else {
                        binding.confirmPasswordEt.error = null
                    }
                }
            }

        })


        binding.backIv.setOnClickListener {
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }

        binding.resetBtn.setOnClickListener {
            if (isValidate()) {
                viewModel.resetPassword(
                    binding.etPassword.text.toString(),
                    otp,
                    email,
                    number
                )
            }
        }
    }

    private fun isValidate(): Boolean {
        return (validateBothPassword(
            binding.etPassword, binding.confirmPasswordEt
        ))
    }

    private fun setUpObservers() {
        viewModel.resetPasswordResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    hideProgress()
                    LoginActivity.start(mContext as Activity)
                }
                is NetworkResult.Failure -> {
                    hideProgress()
                    response.junkError?.let { junkErrors ->
                        ErrorDialog(mContext, junkErrors.errors!![0].map { it.value }).show()
                    } ?: kotlin.run {
                        binding.root.showBar(response.message ?: "Failure")
                    }
                }
                is NetworkResult.Loading -> {
                    showProgress()
                }
                is NetworkResult.Error -> {
                    when (response.error) {
                        is Errors.Error -> {
                            hideProgress()
                            binding.root.showBar("Please try again later")
                        }
                        is Errors.NetworkError -> {
                            hideProgress()
                            binding.root.showBar("Internet connection unavailable")
                        }
                        is Errors.ServerError -> {
                            hideProgress()
                            binding.root.showBar("Server error")
                        }
                        is Errors.TimeOutError -> {
                            hideProgress()
                            binding.root.showBar("Network time out")
                        }
                        null -> {
                            hideProgress()
                            binding.root.showBar("Please try again later")
                        }
                    }
                }
            }
        }
    }

}