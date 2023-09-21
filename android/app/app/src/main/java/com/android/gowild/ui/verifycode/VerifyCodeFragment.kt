package com.android.gowild.ui.verifycode

import android.annotation.SuppressLint
import android.os.Bundle
import android.telephony.PhoneNumberUtils
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.viewModels
import androidx.viewbinding.ViewBinding
import com.android.gowild.R
import com.android.gowild.data.model.register.VerifyMobileOtpRequest
import com.android.gowild.data.model.register.VerifyMobileSendRequest
import com.android.gowild.databinding.FragmentVerifyCodeBinding
import com.android.gowild.networking.Errors
import com.android.gowild.networking.NetworkResult
import com.android.gowild.ui.base.BaseFragment
import com.android.gowild.ui.ewaiver.EWaiverFragment
import com.android.gowild.ui.navhost.NavHostActivity
import com.android.gowild.ui.register.VerifyMobileOtpVM
import com.android.gowild.ui.register.VerifyMobileSendVM
import com.android.gowild.ui.resetpassword.CreateNewPasswordFragment
import com.android.gowild.ui.resetpassword.VerifyResetCodeVM
import com.android.gowild.ui.user.dialog.ErrorDialog
import com.android.gowild.utils.constant.NameConst
import com.android.gowild.utils.extension.hideKeyboard
import com.android.gowild.utils.extension.showBar
import `in`.aabhasjindal.otptextview.OTPListener

class VerifyCodeFragment : BaseFragment() {

    companion object {
        @JvmStatic
        fun newInstance(number: String, email: String, password: String, isRegister: Boolean) =
            VerifyCodeFragment().apply {
                arguments = Bundle().apply {
                    putString(NameConst.NUMBER, number)
                    putString(NameConst.EMAIL, email)
                    putString("password", password)
                    putBoolean(NameConst.IS_REGISTER, isRegister)
                }
            }
    }

    private lateinit var binding: FragmentVerifyCodeBinding
    private val verifyResetCodeVM by viewModels<VerifyResetCodeVM>()
    private val verifyMobileSendViewModel by viewModels<VerifyMobileSendVM>()
    private val verifyMobileOtpViewModel by viewModels<VerifyMobileOtpVM>()
    private lateinit var number: String
    private lateinit var email: String
    private lateinit var password: String
    private var isRegister: Boolean = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        arguments?.let {
            number = it.getString(NameConst.NUMBER).toString()
            email = it.getString(NameConst.EMAIL).toString()
            password = it.getString("password").toString()
            isRegister = it.getBoolean(NameConst.IS_REGISTER)
        }
    }

    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentVerifyCodeBinding.inflate(layoutInflater)
        return binding
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setUpViews()
        listeners()
        setUpObservers()
        otpBoxArrangment()

    }

    private fun otpBoxArrangment() {
        binding.otpView.requestFocus()
        binding.otpView.showSuccess()

        binding.otpView.otpListener = (object : OTPListener {
            override fun onInteractionListener() {

            }

            override fun onOTPComplete(otp: String) {

                if (isRegister) {
                    binding.otpView.showSuccess()
                    mContext.hideKeyboard(binding.root)
                } else {
                    binding.otpView.showSuccess()
                    mContext.hideKeyboard(binding.root)
                }

            }
        })
    }

    @SuppressLint("SetTextI18n")
    private fun setUpViews() {
        binding.titleTv.text = if (isRegister) getString(R.string.verify_phone)
        else getString(R.string.verify_code)

        var formatted = PhoneNumberUtils.formatNumber(number, "US")
        binding.sloganNo.text = "${binding.sloganNo.text} \n $formatted"

        if (isRegister) {
            val verifyMobileSendRequest = VerifyMobileSendRequest(
                phone_number = number
            )
            verifyMobileSendViewModel.verifyMobileSend(verifyMobileSendRequest)
        }

    }

    private fun listeners() {

//        binding.otpView.otpListener = getOtpListener()
        binding.verifyAccountBtn.setOnClickListener {

            if (isRegister) {
                activity?.let { it1 ->
                    if (binding.otpView.otp?.length == 4) {
                        mContext.hideKeyboard(binding.root)
                        val verifyMobileOtpRequest = VerifyMobileOtpRequest(
                            email, number, binding.otpView.otp.toString()
                        )
                        verifyMobileOtpViewModel.verifyMobileOtp(verifyMobileOtpRequest)
                    } else binding.otpView.showError()
                }
            } else {
                activity?.let { it1 ->
                    if (binding.otpView.otp?.length == 4) {
                        binding.otpView.showSuccess()
                        mContext.hideKeyboard(binding.root)

                        verifyResetCodeVM.verifyResetCode(binding.otpView.otp.toString(), email)
                    } else binding.otpView.showError()
                }
            }
        }

        binding.backIv.setOnClickListener {
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }

        binding.resendOtpTv.setOnClickListener {
            // TODO: new implementation
        }
    }

    private fun setUpObservers() {
        observeVerifyMobileSendResponse()
        observeVerifyMobileOTPResponse()
        observeResetVerifyCodeResponse()
    }

    private fun observeResetVerifyCodeResponse() {
        verifyResetCodeVM.verifyResetCodeResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    hideProgress()
                    activity?.let { it1 ->
                        NavHostActivity.replaceFragment(
                            it1,
                            CreateNewPasswordFragment.newInstance(email, number, binding.otpView.otp.toString())
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

    private fun observeVerifyMobileOTPResponse() {
        verifyMobileOtpViewModel.verifyMobileOtpResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    hideProgress()
                    if (isRegister) {
                        activity?.let { it1 ->
                            NavHostActivity.replaceFragment(
                                it1,
                                EWaiverFragment.newInstance(NameConst.E_WAIVER, email = email, password = password, isRegister = true)
                            )
                        }
                    }
                }
                is NetworkResult.Failure -> {
                    hideProgress()
                    response.junkError?.let { junkErrors ->
                        if (junkErrors.errors!![0].containsKey("otp") && junkErrors.errors[0]["otp"] == "notFound")
                            binding.root.showBar("Invalid OTP")
                        else
                            ErrorDialog(mContext, junkErrors.errors[0].map { it.value }).show()
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

    private fun observeVerifyMobileSendResponse() {
        verifyMobileSendViewModel.verifyMobileSendResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    hideProgress()
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