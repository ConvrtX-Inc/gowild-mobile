package com.android.gowild.ui.start

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.os.Handler
import androidx.core.view.WindowCompat
import androidx.lifecycle.lifecycleScope
import com.android.gowild.databinding.ActivityStartBinding
import com.android.gowild.ui.base.BaseActivity
import com.android.gowild.ui.login.LoginActivity
import com.android.gowild.ui.main.MainActivity
import com.android.gowild.utils.extension.gone
import com.android.gowild.utils.local.UserPrefs
import com.facebook.FacebookSdk
import com.facebook.appevents.AppEventsLogger
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

class StartActivity : BaseActivity() {

    companion object {
        fun start(activity: Activity) {
            Handler().postDelayed(Runnable {
                run {
                    val intent = Intent(activity, StartActivity::class.java)
                    activity.startActivity(intent)
                    activity.finishAffinity()
                }
            }, 1000)
        }
    }

    private lateinit var binding: ActivityStartBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityStartBinding.inflate(layoutInflater)
        setContentView(binding.root)
        userPrefs = UserPrefs(this)
        FacebookSdk.sdkInitialize(application);
        AppEventsLogger.activateApp(application)
//        hideStatusBar()
        WindowCompat.setDecorFitsSystemWindows(window, false)
        if (userPrefs.getUser() == null) {
            this.lifecycleScope.launch {
                delay(1000)
                LoginActivity.start(this@StartActivity)
            }
        } else {
            MainActivity.start(this)
        }
        binding.ivNext.gone()
        binding.ivNext.setOnClickListener {

        }
    }
}