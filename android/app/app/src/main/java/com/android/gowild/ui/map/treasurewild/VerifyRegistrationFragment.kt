package com.android.gowild.ui.map.treasurewild

import android.content.Intent
import android.os.Bundle
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.fragment.app.viewModels
import androidx.viewbinding.ViewBinding
import com.android.gowild.databinding.FragmentVerifyRegistrationBinding
import com.android.gowild.networking.Errors
import com.android.gowild.networking.NetworkResult
import com.android.gowild.ui.base.BaseFragment
import com.android.gowild.ui.user.dialog.ErrorDialog
import com.android.gowild.utils.extension.hideKeyboard
import com.android.gowild.utils.extension.showBar
import `in`.aabhasjindal.otptextview.OTPListener

class VerifyRegistrationFragment : BaseFragment() {

    companion object {
        @JvmStatic
        fun newInstance(huntId: String = "", treasure: String = "") = VerifyRegistrationFragment().apply {
            arguments = Bundle().apply {
                putString("huntId", huntId)
                putString("treasure", treasure)
            }
        }
    }

    private lateinit var binding: FragmentVerifyRegistrationBinding
    private lateinit var huntId: String
    private val huntStartOtpVM by viewModels<TreasureHuntStartVM>()

    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentVerifyRegistrationBinding.inflate(layoutInflater)
        init()
        return binding
    }

    fun init() {
        getHuntIDFromArguments()
        setUpObservers()
        setCallbacks()
        setOTPView()
    }

    private fun setOTPView() {
        binding.otpView.requestFocus()
        binding.otpView.showSuccess()
    }

    private fun getHuntIDFromArguments() {
        arguments?.let {
            huntId = it.getString("huntId").toString()
        }
    }

    private fun setCallbacks() {
        binding.registerBtn.setOnClickListener {
            if (binding.otpView.otp?.length == 6) {
                huntStartOtpVM.verifyMobileOtp(huntId, binding.otpView.otp.toString())
            }
        }

        binding.tvSubtitle.setOnClickListener {
            huntStartOtpVM.resendTreasureHuntOtp(huntId)
        }

        binding.otpView.otpListener = (object : OTPListener {
            override fun onInteractionListener() {

            }

            override fun onOTPComplete(otp: String) {
                binding.otpView.showSuccess()
                mContext.hideKeyboard(binding.root)

            }
        })

        binding.backIv.setOnClickListener {
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }
    }

    private fun setUpObservers() {
        observeVerifyOTPResponse()
        observeTreasureHuntOTPResponse()
    }

    private fun observeVerifyOTPResponse() {
        huntStartOtpVM.verifyMobileOtpResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    hideProgress()
                    val treasure = requireArguments().getString("treasure")
//                    startActivity(Intent(requireActivity(), FindTreasureChestsActivity::class.java).putExtra("treasure", treasure))
                    startActivity(Intent(requireActivity(), FindTreasureChestsActivityNew::class.java).putExtra("treasure", treasure))
                    requireActivity().onBackPressedDispatcher.onBackPressed()
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

    private fun observeTreasureHuntOTPResponse() {
        huntStartOtpVM.resendTreasureHuntResponse.observe(viewLifecycleOwner) { response ->
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