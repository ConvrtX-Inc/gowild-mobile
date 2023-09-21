package com.android.gowild.ui.resetpassword

import android.graphics.PorterDuff
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.viewModels
import androidx.viewbinding.ViewBinding
import com.android.gowild.R
import com.android.gowild.databinding.FragmentResetPasswordBinding
import com.android.gowild.networking.Errors

import com.android.gowild.networking.Status

import com.android.gowild.networking.NetworkResult

import com.android.gowild.ui.base.BaseFragment
import com.android.gowild.ui.navhost.NavHostActivity
import com.android.gowild.ui.user.dialog.ErrorDialog
import com.android.gowild.ui.verifycode.VerifyCodeFragment
import com.android.gowild.utils.constant.ValidationConst.validateEmail
import com.android.gowild.utils.extension.showBar
import com.android.gowild.utils.fieldwatcher.TextFieldValidation


class ResetPasswordFragment : BaseFragment() {

    companion object {
        @JvmStatic
        fun newInstance() = ResetPasswordFragment()
    }

    lateinit var binding: FragmentResetPasswordBinding
    private val viewModel by viewModels<ResetPasswordVM>()

    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentResetPasswordBinding.inflate(layoutInflater)
        return binding
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setUpViews()
        listeners()
        setUpObservers()
    }

    private fun setUpViews() {
        binding.ccp.registerCarrierNumberEditText(binding.etPhoneNumber)
    }

    private fun listeners() {

        binding.etEmail.addTextChangedListener(TextFieldValidation(binding.etEmail))

        // FIXME: replace deprecated codes
        binding.ccp.setPhoneNumberValidityChangeListener {
            if (it) {
                binding.etPhoneNumber.setTextColor(resources.getColor(R.color.white))
                binding.etPhoneNumber.background.setColorFilter(
                    resources.getColor(R.color.success_color),
                    PorterDuff.Mode.SRC_ATOP
                )
            } else {
                binding.etPhoneNumber.setTextColor(resources.getColor(R.color.error_color))
                binding.etPhoneNumber.background.setColorFilter(
                    resources.getColor(R.color.error_color),
                    PorterDuff.Mode.SRC_ATOP
                )
            }
        }

        binding.backIv.setOnClickListener {
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }

        binding.verifyAccountBtn.setOnClickListener {
            if (isValidate()) {
                viewModel.forgotPassword(
                    binding.etEmail.text.toString(),
                    binding.ccp.fullNumberWithPlus
                )
            } else {
                if (!binding.ccp.isValidFullNumber) {
                    binding.etPhoneNumber.setError("Wrong phone number")
                }
            }
        }
    }

    private fun isValidate(): Boolean {
        return (validateEmail(binding.etEmail) && binding.ccp.isValidFullNumber)
    }

    private fun setUpObservers() {
        observeForgetPasswordResponse()
    }

    private fun observeForgetPasswordResponse() {
        viewModel.forgotPasswordResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    hideProgress()
                    activity?.let { it1 ->
                        NavHostActivity.replaceFragment(
                            it1, VerifyCodeFragment.newInstance(
                                binding.ccp.fullNumberWithPlus, binding.etEmail.text.toString(), "", false
                            )
                        )
                    }
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
                    when(response.error){
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