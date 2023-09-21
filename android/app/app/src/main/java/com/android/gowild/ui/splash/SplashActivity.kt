package com.android.gowild.ui.splash

import android.annotation.SuppressLint
import android.content.Intent
import android.os.Bundle
import androidx.core.view.WindowCompat
import androidx.lifecycle.lifecycleScope
import com.android.gowild.R
import com.android.gowild.ui.base.BaseActivity
import com.android.gowild.ui.start.StartActivity
import kotlinx.coroutines.coroutineScope
import kotlinx.coroutines.currentCoroutineContext
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlin.coroutines.coroutineContext

@SuppressLint("CustomSplashScreen")
class SplashActivity : BaseActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_splash)
//        hideStatusBar()
        WindowCompat.setDecorFitsSystemWindows(window, false)
//        StartActivity.start(this)
        lifecycleScope.launchWhenCreated {
            delay(1000)
            val intent = Intent(this@SplashActivity, StartActivity::class.java)
            startActivity(intent)
            finishAffinity()
        }
    }
}