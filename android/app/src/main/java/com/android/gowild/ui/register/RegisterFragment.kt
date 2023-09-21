package com.android.gowild.ui.register

import android.content.Intent
import android.graphics.PorterDuff
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.viewModels
import androidx.viewbinding.ViewBinding
import com.android.gowild.R
import com.android.gowild.data.model.login.FacebookLoginRequest
import com.android.gowild.data.model.login.GoogleLoginRequest
import com.android.gowild.data.model.register.RegisterRequest
import com.android.gowild.data.model.user.Token
import com.android.gowild.databinding.FragmentRegisterBinding
import com.android.gowild.networking.Errors
import com.android.gowild.networking.NetworkResult
import com.android.gowild.ui.base.BaseFragment
import com.android.gowild.ui.ewaiver.EWaiverFragment
import com.android.gowild.ui.login.AuthVM
import com.android.gowild.ui.login.FacebookLoginVM
import com.android.gowild.ui.login.GoogleLoginVM
import com.android.gowild.ui.main.MainActivity
import com.android.gowild.ui.navhost.NavHostActivity
import com.android.gowild.ui.user.dialog.ErrorDialog
import com.android.gowild.ui.user.dialog.ErrorMessage
import com.android.gowild.ui.verifycode.VerifyCodeFragment
import com.android.gowild.utils.constant.NameConst
import com.android.gowild.utils.constant.ValidationConst.validateAddress
import com.android.gowild.utils.constant.ValidationConst.validateEmail
import com.android.gowild.utils.constant.ValidationConst.validateFullName
import com.android.gowild.utils.constant.ValidationConst.validatePassword
import com.android.gowild.utils.constant.fcmToken
import com.android.gowild.utils.extension.showBar
import com.android.gowild.utils.extension.toast
import com.android.gowild.utils.fieldwatcher.TextFieldValidation
import com.android.gowild.utils.helper.AutoFormFiller
import com.facebook.CallbackManager
import com.facebook.FacebookCallback
import com.facebook.FacebookException
import com.facebook.login.LoginResult
import com.google.android.gms.auth.api.signin.GoogleSignIn
import com.google.android.gms.auth.api.signin.GoogleSignInAccount
import com.google.android.gms.auth.api.signin.GoogleSignInClient
import com.google.android.gms.auth.api.signin.GoogleSignInOptions
import com.google.android.gms.common.api.ApiException
import com.google.android.gms.common.api.CommonStatusCodes
import com.google.android.gms.tasks.OnCompleteListener
import com.google.android.gms.tasks.Task
import com.google.firebase.messaging.FirebaseMessaging
import dagger.hilt.android.AndroidEntryPoint
import timber.log.Timber
import java.util.*
import javax.inject.Inject


@AndroidEntryPoint
class RegisterFragment : BaseFragment() {

    companion object {
        @JvmStatic
        fun newInstance() = RegisterFragment()
        private const val RC_SIGN_IN = 1
        private const val EMAIL = "email"
    }

    private var isValidNumber: Boolean = false

    @Inject
    lateinit var formFiller: AutoFormFiller

    private lateinit var binding: FragmentRegisterBinding
    private val registerViewModel by viewModels<RegisterVM>()
    private val authViewModel by viewModels<AuthVM>()
    private val facebookLoginViewModel by viewModels<FacebookLoginVM>()
    private val googleLoginViewModel by viewModels<GoogleLoginVM>()
    private lateinit var callbackManager: CallbackManager
    private var googleSignInClient: GoogleSignInClient? = null
    private lateinit var token: Token


    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentRegisterBinding.inflate(layoutInflater)
        getFcmToken()
        return binding
    }

    private fun getFcmToken() {
        FirebaseMessaging.getInstance().token.addOnCompleteListener(OnCompleteListener { task ->
            if (!task.isSuccessful) {
                Timber.tag("FCM_TOKEN").wtf("Fetching FCM registration token failed ${task.exception}")
                return@OnCompleteListener
            }
            fcmToken = task.result
            Timber.tag("FCM_TOKEN").wtf("Fetching FCM registration token successful ${task.result}")
        })
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        binding.ccp.registerCarrierNumberEditText(binding.etPhoneNumber)

        callbackManager = CallbackManager.Factory.create()
        setUpObservers()
        listeners()

        val googleSignInOptions = GoogleSignInOptions.Builder(GoogleSignInOptions.DEFAULT_SIGN_IN)
//            .requestIdToken(getString(R.string.client_id))
            .requestIdToken("321129921779-bit1jtnm7aap0l7krnhcpul96gmefndb.apps.googleusercontent.com")
            .requestEmail()
            .build()
        googleSignInClient = GoogleSignIn.getClient(requireActivity(), googleSignInOptions)

//        if (BuildConfig.DEBUG) formFiller.fill(binding)
    }

    private fun listeners() {

        binding.etFullName.addTextChangedListener(TextFieldValidation(binding.etFullName))
        binding.etEmail.addTextChangedListener(TextFieldValidation(binding.etEmail))
        binding.etPassword.addTextChangedListener(TextFieldValidation(binding.etPassword))
        binding.etAddressLine1.addTextChangedListener(TextFieldValidation(binding.etAddressLine1))
        binding.etAddressLine2.addTextChangedListener(TextFieldValidation(binding.etAddressLine2))

//        binding.ccp.setPhoneNumberValidityChangeListener {
//            if (it) {
//                binding.etPhoneNumber.background.setColorFilter(
//                    resources.getColor(R.color.success_color),
//                    PorterDuff.Mode.SRC_ATOP
//                )
//            } else {
//                binding.etPhoneNumber.background.setColorFilter(
//                    resources.getColor(R.color.error_color),
//                    PorterDuff.Mode.SRC_ATOP
//                )
//            }
//        }

        binding.ccp.setPhoneNumberValidityChangeListener {
            isValidNumber = it
            if (it) {
                // FIXME: Deprecated code, replace asap
                binding.etPhoneNumber.setTextColor(resources.getColor(R.color.white))
                binding.etPhoneNumber.background.setColorFilter(
                    resources.getColor(R.color.success_color),
                    PorterDuff.Mode.SRC_ATOP
                )
            } else {
                // FIXME: Deprecated code, replace asap
                binding.etPhoneNumber.setTextColor(resources.getColor(R.color.error_color))
                binding.etPhoneNumber.background.setColorFilter(
                    resources.getColor(R.color.error_color),
                    PorterDuff.Mode.SRC_ATOP
                )
            }
        }


        binding.registerBtn.setOnClickListener {
            if (isValidate()) {
                var firstName: String? = null
                var lastName: String? = null
                binding.etFullName.text?.let {
                    val tempArray = it.split(" ")
                    firstName = tempArray.firstOrNull().toString()
                    lastName = tempArray.takeLast(tempArray.size - 1).joinToString(separator = " ")
                }
                val request = RegisterRequest(
                    binding.etEmail.text.toString(),
                    binding.etPassword.text.toString(),
                    firstName,
                    lastName,
                    "male",
                    listOf(
                        binding.etAddressLine1.text.toString(),
                        binding.etAddressLine2.text.toString()
                    ),
                    binding.ccp.fullNumberWithPlus,
                    fcmToken
                )
                registerViewModel.register(request)
            }
        }

        binding.backIv.setOnClickListener {
            // TODO: Replace deprecated code
            activity?.onBackPressed()
        }

        binding.loginTv.setOnClickListener {
            // TODO: Replace deprecated code
            activity?.onBackPressed()
        }


        binding.loginButtonHidden.setReadPermissions(Arrays.asList(EMAIL))
        binding.loginButtonHidden.registerCallback(callbackManager, object :
            FacebookCallback<LoginResult> {
            override fun onCancel() {
                Log.d("Cancel", "cancel")
            }

            override fun onError(error: FacebookException) {
                Log.d("Error", error.message.toString())
            }

            override fun onSuccess(result: LoginResult) {
                val facebookLoginRequest = FacebookLoginRequest(
                    result.accessToken.token,
                    fcmToken
                )
                facebookLoginViewModel.facebookLogin(facebookLoginRequest)
            }
        })
        binding.loginWithFacebookBtn.setOnClickListener {
            binding.loginButtonHidden.performClick()
        }

        binding.loginWithGoogleBtn.setOnClickListener {
            val intent = googleSignInClient!!.signInIntent
            startActivityForResult(intent, RC_SIGN_IN)
        }


        binding.termsConditionsTv.setOnClickListener {
            setAllErrorFalse()
            activity?.let { it1 ->
                NavHostActivity.replaceFragment(
                    it1,
                    EWaiverFragment.newInstance(NameConst.TERMS_CONDITIONS, email = "", password = "")
                )
            }
        }

        binding.privacyPolicyTv.setOnClickListener {
            setAllErrorFalse()
            activity?.let { it1 ->
                NavHostActivity.replaceFragment(
                    it1,
                    EWaiverFragment.newInstance(NameConst.PRIVACY_POLICY, email = "", password = "")
                )
            }
        }

    }


    /**
     * A function for Validation Setup.
     */
    private fun isValidate(): Boolean {
        if (!isValidNumber) {
            toast("Invalid mobile number")
            return false
        }
        return (validateFullName(binding.etFullName) && validateEmail(binding.etEmail) &&
                validatePassword(binding.etPassword) && binding.ccp.isValidFullNumber &&
                validateAddress(binding.etAddressLine1) && validateAddress(binding.etAddressLine2))
    }

    private fun setUpObservers() {
        observeRegisterResponse()
        observeAuthResponse()
        observeFacebookLoginResponse()
        observeGoogleLoginResponse()
    }

    private fun observeRegisterResponse() {
        registerViewModel.registerResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    hideProgress()
                    activity?.let { activity ->
                        NavHostActivity.replaceFragment(
                            activity, VerifyCodeFragment.newInstance(
                                binding.ccp.fullNumberWithPlus, binding.etEmail.text.toString(), binding.etPassword.text.toString(), true
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

    private fun observeGoogleLoginResponse() {
        googleLoginViewModel.googleLoginResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    setToken(response.data!!.token)
                    authViewModel.auth("Bearer " + response.data.token.accessToken)
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

    private fun observeFacebookLoginResponse() {
        facebookLoginViewModel.facebookLoginResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    setToken(response.data!!.token)
                    authViewModel.auth("Bearer " + response.data.token.accessToken)
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

    // TODO: Replace deprecated code
    @Deprecated("Deprecated in Java")
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        callbackManager.onActivityResult(requestCode, resultCode, data)
        super.onActivityResult(requestCode, resultCode, data)

        if (requestCode == RC_SIGN_IN) {
            val signInAccountTask: Task<GoogleSignInAccount> = GoogleSignIn.getSignedInAccountFromIntent(data)
            signInAccountTask.addOnSuccessListener {
                val googleLoginRequest = GoogleLoginRequest(it.idToken!!, fcmToken)
                googleLoginViewModel.googleLogin(googleLoginRequest)
            }
            signInAccountTask.addOnFailureListener {
                if (it is ApiException) {
                    val apiException: ApiException = it
                    if (apiException.statusCode == 12501)
                        toast("Cancelled")
                    else
                        ErrorMessage(mContext, "Error : " + CommonStatusCodes.getStatusCodeString(apiException.statusCode)).show()
                } else {
                    ErrorMessage(mContext, "An error occurred " + it.message).show()
                }
            }
            signInAccountTask.addOnCanceledListener {
                toast("Cancelled")
            }
        }
    }

    fun setAllErrorFalse() {
        binding.etFullName.setError(null)
        binding.etEmail.setError(null)
        binding.etPassword.setError(null)
        binding.etAddressLine1.setError(null)
        binding.etAddressLine2.setError(null)
    }

    private fun setToken(token: Token) {
        this.token = token
    }
}