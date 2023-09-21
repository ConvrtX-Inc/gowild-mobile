package com.android.gowild.ui.navhost

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import androidx.fragment.app.FragmentActivity
import com.android.gowild.R
import com.android.gowild.databinding.ActivityNavHostBinding
import com.android.gowild.ui.base.BaseActivity
import com.android.gowild.ui.base.BaseFragment
import com.android.gowild.ui.ewaiver.EWaiverFragment
import com.android.gowild.ui.register.RegisterFragment
import com.android.gowild.ui.resetpassword.ResetPasswordFragment
import com.android.gowild.utils.constant.NameConst
import dagger.hilt.android.AndroidEntryPoint


@AndroidEntryPoint
class NavHostActivity : BaseActivity() {

    companion object {
        fun start(activity: Activity, isRegister: Boolean = false, isTerms: Boolean = false, isPrivacy: Boolean = false) {
            activity.startActivity(
                Intent(activity, NavHostActivity::class.java)
                    .putExtra(NameConst.IS_REGISTER, isRegister)
                    .putExtra(NameConst.IS_TERMS, isTerms)
                    .putExtra(NameConst.IS_PRIVACY, isPrivacy)
            )
        }

        fun replaceFragment(
            requireActivity: FragmentActivity,
            fragment: BaseFragment
        ) {
            requireActivity
                .supportFragmentManager
                .beginTransaction()
                .add(R.id.fragmentContainerView, fragment)
                .addToBackStack(fragment::class.java.simpleName)
                .setCustomAnimations(
                    R.anim.enter,
                    R.anim.exit,
                    R.anim.pop_enter,
                    R.anim.pop_exit
                ).commit()
        }

        fun addFirst(
            requireActivity: FragmentActivity,
            fragment: BaseFragment
        ) {
            requireActivity
                .supportFragmentManager
                .beginTransaction()
                .add(R.id.fragmentContainerView, fragment)
                .setCustomAnimations(
                    R.anim.enter,
                    R.anim.exit,
                    R.anim.pop_enter,
                    R.anim.pop_exit
                ).commit()
        }
    }

    private lateinit var binding: ActivityNavHostBinding
    private var isRegister: Boolean = false
    private var isTerms: Boolean = false
    private var isPrivacy: Boolean = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityNavHostBinding.inflate(layoutInflater)
        setContentView(binding.root)
        isRegister = intent.getBooleanExtra(NameConst.IS_REGISTER, false)
        isTerms = intent.getBooleanExtra(NameConst.IS_TERMS, false)
        isPrivacy = intent.getBooleanExtra(NameConst.IS_PRIVACY, false)
        if (isRegister) {
            addFirst(this, RegisterFragment.newInstance())
        } else {
            if (isTerms) {
                addFirst(this, EWaiverFragment.newInstance(NameConst.TERMS_CONDITIONS, email = "", password = ""))
            } else if (isPrivacy) {
                addFirst(this, EWaiverFragment.newInstance(NameConst.PRIVACY_POLICY, email = "", password = ""))
            } else {
                addFirst(this, ResetPasswordFragment.newInstance())
            }
        }

    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        for (fragment in supportFragmentManager.fragments) {
            fragment.onActivityResult(requestCode, resultCode, data)
        }
        super.onActivityResult(requestCode, resultCode, data)
    }
}