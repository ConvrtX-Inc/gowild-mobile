package com.android.gowild.ui.setting

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.viewModels
import androidx.viewbinding.ViewBinding
import com.android.gowild.databinding.FragmentSettingsBinding
import com.android.gowild.networking.Errors
import com.android.gowild.networking.NetworkResult
import com.android.gowild.ui.achievements.AchievementFragment
import com.android.gowild.ui.base.BaseFragment
import com.android.gowild.ui.editprofile.EditProfileFragment
import com.android.gowild.ui.login.LoginActivity
import com.android.gowild.ui.messages.FriendListFragment
import com.android.gowild.ui.notification.NotificationFragment
import com.android.gowild.ui.support.SupportFragment
import com.android.gowild.ui.user.dialog.ErrorDialog
import com.android.gowild.utils.extension.loadUserImage
import com.android.gowild.utils.extension.showBar
import com.android.gowild.utils.local.UserPrefs
import com.facebook.FacebookSdk.getApplicationContext
import com.facebook.login.LoginManager
import com.google.android.gms.auth.api.signin.GoogleSignIn
import com.google.android.gms.auth.api.signin.GoogleSignInOptions

class SettingsFragment : BaseFragment() {

    companion object {
        @JvmStatic
        fun newInstance() =
            SettingsFragment()
    }

    lateinit var binding: FragmentSettingsBinding
    private val logoutViewModel by viewModels<LogoutVM>()

    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentSettingsBinding.inflate(layoutInflater)

        return binding
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        val userPrefs = UserPrefs(requireContext())
        setUpObserver()
        binding.txtEditProfile.setOnClickListener {
            activity?.let { it1 ->
                SettingsActivity.replaceFragment(
                    it1,
                    EditProfileFragment.newInstance()
                )
            }
        }

        binding.txtAchievements.setOnClickListener {
            activity?.let { it1 ->
                SettingsActivity.replaceFragment(
                    it1,
                    AchievementFragment.newInstance()
                )
            }
        }

        binding.txtNotification.setOnClickListener {
            activity?.let { it1 ->
                SettingsActivity.replaceFragment(
                    it1,
                    NotificationFragment.newInstance()
                )
            }
        }

        binding.txtSupport.setOnClickListener {
            activity?.let { it1 ->
                SettingsActivity.replaceFragment(
                    it1,
                    SupportFragment.newInstance()
                )
            }
        }

        binding.txtLogout.setOnClickListener {
            activity?.let {
                logoutViewModel.logout("Bearer " + userPrefs.getUser()!!.accessToken.toString())
            }
        }

        binding.backIv.setOnClickListener {
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }

        /**
         * this is callback for my races, commented until CR comes again
         */
//        binding.txtUser.setOnClickListener {
//            activity?.let { it1 ->
//                SettingsActivity.replaceFragment(
//                    it1,
//                    TreasureWildFragment.newInstance()
//                )
//            }
//        }
//
//        binding.icUser.setOnClickListener {
//            activity?.let { it1 ->
//                SettingsActivity.replaceFragment(
//                    it1,
//                    TreasureWildFragment.newInstance()
//                )
//            }
//        }

        binding.icMessage.setOnClickListener {
            activity?.let { it1 ->
                SettingsActivity.replaceFragment(
                    it1,
                    FriendListFragment.newInstance()
                )
            }
        }

        binding.txtMessage.setOnClickListener {
            activity?.let { it1 ->
                SettingsActivity.replaceFragment(
                    it1,
                    FriendListFragment.newInstance()
                )
            }
        }
    }

    override fun onResume() {
        super.onResume()
        setUserData()
    }

    fun setUserData() {
        binding.nameTv.text = userPrefs.getUser()!!.firstName + " " + userPrefs.getUser()!!.lastName
        binding.achievementProfileImg.loadUserImage(userPrefs.getUser()!!)
    }

    private fun setUpObserver() {
        logoutViewModel.logoutResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    LoginManager.getInstance().logOut()
                    GoogleSignIn.getClient(getApplicationContext(), GoogleSignInOptions.DEFAULT_SIGN_IN).signOut();
                    userPrefs.deleteUser()
                    hideProgress()
                    LoginActivity.start(requireActivity())
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