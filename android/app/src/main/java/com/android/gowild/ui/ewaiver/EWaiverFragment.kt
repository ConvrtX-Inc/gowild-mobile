package com.android.gowild.ui.ewaiver

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.viewModels
import androidx.viewbinding.ViewBinding
import com.android.gowild.data.model.login.LoginRequest
import com.android.gowild.data.model.user.Token
import com.android.gowild.databinding.FragmentEWaiverBinding
import com.android.gowild.networking.Errors
import com.android.gowild.networking.NetworkResult
import com.android.gowild.ui.base.BaseFragment
import com.android.gowild.ui.login.AuthVM
import com.android.gowild.ui.login.LoginVM
import com.android.gowild.ui.main.MainActivity
import com.android.gowild.ui.map.MapActivity
import com.android.gowild.ui.map.treasurewild.RegisterTreasureHuntFragment
import com.android.gowild.ui.user.dialog.ErrorDialog
import com.android.gowild.utils.constant.NameConst
import com.android.gowild.utils.constant.fcmToken
import com.android.gowild.utils.extension.showBar
import com.android.gowild.utils.extension.toast
import timber.log.Timber


class EWaiverFragment : BaseFragment() {

    companion object {

        @JvmStatic
        fun newInstance(
            type: String,
            huntId: String = "",
            huntPic: String = "",
            huntName: String = "",
            email: String,
            password: String,
            isRegister: Boolean = false
        ) =
            EWaiverFragment().apply {
                arguments = Bundle().apply {
                    putString("huntId", huntId)
                    putString("huntPic", huntPic)
                    putString("huntName", huntName)
                    putString("email", email)
                    putString("password", password)
                    putString("type", type)
                    putBoolean("isRegister", isRegister)
                }
            }
    }

    lateinit var binding: FragmentEWaiverBinding

    private val eWaiverVM by viewModels<EWaiverVM>()
    private val loginViewModel by viewModels<LoginVM>()
    private val authViewModel by viewModels<AuthVM>()

    private lateinit var type: String
    private lateinit var huntId: String
    private lateinit var huntPic: String
    private lateinit var huntName: String
    private lateinit var email: String
    private lateinit var password: String
    var isRegister: Boolean = false

    private lateinit var token: Token

    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentEWaiverBinding.inflate(layoutInflater)
        init()
        return binding
    }

    private fun init() {
        setDataFromArgument()
        setUpObserver()
        listeners()
    }

    private fun setDataFromArgument() {
        arguments?.let {
            type = it.getString("type").toString()
            huntId = it.getString("huntId").toString()
            huntPic = it.getString("huntPic").toString()
            huntName = it.getString("huntName").toString()
            email = it.getString("email").toString()
            password = it.getString("password").toString()
            isRegister = it.getBoolean("isRegister")
        }
        setEWaiverType()
    }

    private fun setEWaiverType() {
        when (type) {
            NameConst.E_WAIVER -> {
                binding.titleTv.text = "E-WAIVER"
                eWaiverVM.getEWaiver(NameConst.E_WAIVER)
            }
            NameConst.TERMS_CONDITIONS -> {
                binding.titleTv.text = "TERMS & CONDITIONS"
                eWaiverVM.getEWaiver(NameConst.TERMS_CONDITIONS)
                binding.checkBox.visibility = View.GONE
                binding.iAgreeBtn.visibility = View.GONE
            }
            NameConst.PRIVACY_POLICY -> {
                binding.titleTv.text = "PRIVACY POLICY"
                eWaiverVM.getEWaiver(NameConst.TERMS_CONDITIONS)
                binding.checkBox.visibility = View.GONE
                binding.iAgreeBtn.visibility = View.GONE
            }
            NameConst.HUNT_E_WAIVER -> {
                binding.titleTv.text = "E-WAIVER"
                eWaiverVM.getEWaiver(NameConst.HUNT_E_WAIVER)
                binding.checkBox.visibility = View.VISIBLE
                binding.iAgreeBtn.visibility = View.VISIBLE
            }
        }
    }

    private fun listeners() {
        binding.iAgreeBtn.setOnClickListener {
            if (binding.checkBox.isChecked) {
                if (type == NameConst.E_WAIVER) {
                    val loginRequest = LoginRequest(
                        email, password, fcmToken
                    )
                    loginViewModel.login(loginRequest)
                } else if (type == NameConst.HUNT_E_WAIVER) {
                    activity?.let { it1 ->
                        MapActivity.replaceFragment(it1, RegisterTreasureHuntFragment.newInstance(huntId, huntPic, huntName))
                    }
                }
            } else {
                toast("Please agree to terms to continue")
            }
        }

        binding.checkBox.setOnCheckedChangeListener { buttonView, isChecked ->
            Timber.tag("EWAIVER").wtf("check?$isChecked")
        }

        binding.backIv.setOnClickListener {
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }
    }

    private fun setUpObserver() {
        observeEWaiverResponse()
        observeAuthResponse()
        observeLoginResponse()
    }

    private fun observeEWaiverResponse() {
        eWaiverVM.eWaiverResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    binding.tv1.text = response.data?.data?.description
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

    private fun observeAuthResponse() {
        authViewModel.authResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    hideProgress()
                    response.data!!.accessToken = token.accessToken
                    response.data.refreshToken = token.refreshToken
                    userPrefs.saveUser(response.data)
                    MainActivity.start(requireActivity())
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

    private fun observeLoginResponse() {
        loginViewModel.loginResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    setToken(Token(response.data!!.accessToken, response.data.refreshToken))
                    authViewModel.auth("Bearer " + response.data.accessToken)
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

    private fun setToken(token: Token) {
        this.token = token
    }
}