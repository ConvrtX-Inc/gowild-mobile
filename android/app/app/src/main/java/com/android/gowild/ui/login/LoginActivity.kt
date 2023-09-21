package com.android.gowild.ui.login

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import androidx.activity.viewModels
import com.android.gowild.R
import com.android.gowild.data.model.login.FacebookLoginRequest
import com.android.gowild.data.model.login.GoogleLoginRequest
import com.android.gowild.data.model.login.LoginRequest
import com.android.gowild.data.model.user.Token
import com.android.gowild.databinding.ActivityLoginBinding
import com.android.gowild.networking.Errors
import com.android.gowild.networking.NetworkResult
import com.android.gowild.ui.base.BaseActivity
import com.android.gowild.ui.main.MainActivity
import com.android.gowild.ui.navhost.NavHostActivity
import com.android.gowild.ui.user.dialog.ErrorDialog
import com.android.gowild.ui.user.dialog.ErrorMessage
import com.android.gowild.utils.constant.ValidationConst.validateEmail
import com.android.gowild.utils.constant.fcmToken
import com.android.gowild.utils.extension.getAsColor
import com.android.gowild.utils.extension.showBar
import com.android.gowild.utils.extension.toast
import com.android.gowild.utils.fieldwatcher.TextFieldValidation
import com.facebook.CallbackManager
import com.facebook.FacebookCallback
import com.facebook.FacebookException
import com.facebook.login.LoginResult
import com.google.android.gms.auth.api.signin.*
import com.google.android.gms.common.api.ApiException
import com.google.android.gms.common.api.CommonStatusCodes.getStatusCodeString
import com.google.android.gms.tasks.OnCompleteListener
import com.google.android.gms.tasks.Task
import com.google.firebase.messaging.FirebaseMessaging
import dagger.hilt.android.AndroidEntryPoint
import timber.log.Timber
import java.util.*


@AndroidEntryPoint
class LoginActivity : BaseActivity() {

    companion object {
        fun start(activity: Activity) {
            val intent = Intent(activity, LoginActivity::class.java)
            intent.flags = Intent.FLAG_ACTIVITY_CLEAR_TASK or Intent.FLAG_ACTIVITY_NEW_TASK
            activity.startActivity(intent)
        }

        private const val RC_SIGN_IN = 1
        private const val EMAIL = "email"
    }

    private lateinit var binding: ActivityLoginBinding
    private val loginViewModel by viewModels<LoginVM>()
    private val authViewModel by viewModels<AuthVM>()
    private val facebookLoginViewModel by viewModels<FacebookLoginVM>()
    private val googleLoginViewModel by viewModels<GoogleLoginVM>()
    private lateinit var callbackManager: CallbackManager
    private var googleSignInClient: GoogleSignInClient? = null
    private lateinit var token: Token

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityLoginBinding.inflate(layoutInflater)
        setContentView(binding.root)
        callbackManager = CallbackManager.Factory.create()
        listeners()
        setUpObserver()
        changeStatusBarColour(getAsColor(R.color.primaryColor), getAsColor(R.color.primaryColor))

        val googleSignInOptions = GoogleSignInOptions.Builder(GoogleSignInOptions.DEFAULT_SIGN_IN)
//            .requestIdToken(getString(R.string.client_id))
            .requestIdToken("321129921779-bit1jtnm7aap0l7krnhcpul96gmefndb.apps.googleusercontent.com")
            .requestEmail()
            .build()
        googleSignInClient = GoogleSignIn.getClient(this, googleSignInOptions)
        getFcmToken()
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

    private fun listeners() {

        binding.etEmail.addTextChangedListener(TextFieldValidation(binding.etEmail))
        binding.etPassword.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {

            }

            override fun onTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {
                validateField(p0)
            }

            override fun afterTextChanged(p0: Editable?) {

            }

        })

        binding.btnLogin.setOnClickListener {
            if (isValidate()) {
                val loginRequest = LoginRequest(
                    binding.etEmail.text.toString(),
                    binding.etPassword.text.toString(),
                    fcmToken
                )
                loginViewModel.login(loginRequest)
            }
        }

        binding.loginWithFacebookBtn.setOnClickListener {
            binding.facebookLoginButtonHidden.performClick()
        }

        binding.signUpTv.setOnClickListener {
            NavHostActivity.start(this, isRegister = true)
        }

        binding.termsConditionsTv.setOnClickListener {
            NavHostActivity.start(this, isTerms = true)
        }

        binding.privacyPolicyTv.setOnClickListener {
            NavHostActivity.start(this, isPrivacy = true)
        }

        binding.forgetPasswordTv.setOnClickListener {
            NavHostActivity.start(this)
        }

        binding.facebookLoginButtonHidden.setReadPermissions(Arrays.asList(EMAIL))
        binding.facebookLoginButtonHidden.registerCallback(callbackManager, object : FacebookCallback<LoginResult> {
            override fun onCancel() {

            }

            override fun onError(error: FacebookException) {
                toast("Could not connect to facebook sdk")
            }

            override fun onSuccess(result: LoginResult) {
                val facebookLoginRequest = FacebookLoginRequest(
                    result.accessToken.token,
                    fcmToken
                )
                facebookLoginViewModel.facebookLogin(facebookLoginRequest)
            }
        })


        binding.loginWithGoogleBtn.setOnClickListener {
            val intent = googleSignInClient!!.signInIntent
            // TODO: Replace deprecated code
            startActivityForResult(intent, RC_SIGN_IN)
        }
    }

    private fun validateField(p0: CharSequence?): Boolean {
        return if (p0?.isEmpty() == true) {
            binding.etPassword.error = getString(R.string.required_field)
            binding.etPassword.requestFocus()
            false
        } else {
            binding.etPassword.error = null
            true
        }
    }

    private fun isValidate(): Boolean {
        return (validateEmail(binding.etEmail) && validateField(binding.etPassword.text.toString()))
    }

    private fun setUpObserver() {
        observeLoginResponse()
        observeAuthResponse()
        observeFacebookLoginResponse()
        observeGoogleLoginResponse()
    }

    private fun observeGoogleLoginResponse() {
        googleLoginViewModel.googleLoginResponse.observe(this) { response ->
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
        facebookLoginViewModel.facebookLoginResponse.observe(this) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    setToken(response.data!!.token)
                    authViewModel.auth("Bearer " + response.data!!.token.accessToken)
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
        authViewModel.authResponse.observe(this) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    hideProgress()
                    response.data!!.accessToken = token.accessToken
                    response.data.refreshToken = token.refreshToken
                    userPrefs.saveUser(response.data)
                    MainActivity.start(this)
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
        loginViewModel.loginResponse.observe(this) { response ->
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
                        ErrorMessage(mContext, "Error : " + getStatusCodeString(apiException.statusCode)).show()
                } else {
                    ErrorMessage(mContext, "An error occurred " + it.message).show()
                }
            }
            signInAccountTask.addOnCanceledListener {
                toast("Cancelled")
            }
        }
    }
}