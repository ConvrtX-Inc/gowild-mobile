package com.android.gowild.ui.base

import android.content.Context
import android.os.Bundle
import android.os.PowerManager
import android.view.Window
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat
import com.android.gowild.ui.user.dialog.ProgressDialog
import com.android.gowild.utils.local.UserPrefs
import javax.inject.Inject

abstract class BaseActivity : AppCompatActivity() {

    protected lateinit var mContext: Context

    private lateinit var progressDialog: ProgressDialog

    @Inject
    lateinit var userPrefs: UserPrefs

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        mContext = this
    }

    // TODO: replace these waiting  
    protected open fun showProgress() {
        try {
            if (this::progressDialog.isInitialized && progressDialog.isShowing) return
            progressDialog = ProgressDialog(mContext)
            progressDialog.show()
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    protected open fun hideProgress() {
        if (this::progressDialog.isInitialized && progressDialog.isShowing) progressDialog.dismiss()
    }

    fun changeStatusBarColour(statusBar: Int, navigationBar: Int) {
        val window: Window = this.window
        window.statusBarColor = statusBar
        window.navigationBarColor = navigationBar
    }

    fun hideStatusBar() {
//        val windowInsetsController =
//            WindowCompat.getInsetsController(window, window.decorView)
//        // Configure the behavior of the hidden system bars.
//        windowInsetsController.systemBarsBehavior =
//            WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
//        windowInsetsController.hide(WindowInsetsCompat.Type.systemBars())
//        windowInsetsController.hide(WindowInsetsCompat.Type.statusBars())
//        windowInsetsController.hide(WindowInsetsCompat.Type.captionBar())
//        windowInsetsController.hide(WindowInsetsCompat.Type.navigationBars())


//        WindowCompat.setDecorFitsSystemWindows(window, false)
//        WindowInsetsControllerCompat(
//            window,
//            window.decorView.findViewById(android.R.id.content)
//        ).let { controller ->
//            controller.hide(WindowInsetsCompat.Type.systemBars())
//            controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
//        }

        val windowInsetsController =
            WindowCompat.getInsetsController(window, window.decorView)
        // Configure the behavior of the hidden system bars.
        windowInsetsController.systemBarsBehavior =
            WindowInsetsControllerCompat.BEHAVIOR_SHOW_BARS_BY_SWIPE

        // Add a listener to update the behavior of the toggle fullscreen button when
        // the system bars are hidden or revealed.
        window.decorView.setOnApplyWindowInsetsListener { view, windowInsets ->
            // You can hide the caption bar even when the other system bars are visible.
            // To account for this, explicitly check the visibility of navigationBars()
            // and statusBars() rather than checking the visibility of systemBars().
//            if (windowInsets.isVisible(WindowInsetsCompat.Type.navigationBars())
//                || windowInsets.isVisible(WindowInsetsCompat.Type.statusBars())) {
//                binding.toggleFullscreenButton.setOnClickListener {
//                    // Hide both the status bar and the navigation bar.
//            windowInsetsController.systemBarsBehavior =
//                WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
            windowInsetsController.systemBarsBehavior =
                WindowInsetsControllerCompat.BEHAVIOR_SHOW_BARS_BY_SWIPE
                    windowInsetsController.hide(WindowInsetsCompat.Type.systemBars())
//                }
//            } else {
//                binding.toggleFullscreenButton.setOnClickListener {
//                    // Show both the status bar and the navigation bar.
//                    windowInsetsController.show(WindowInsetsCompat.Type.systemBars())
//                }
//            }
//            WindowCompat.setDecorFitsSystemWindows(window, false)
            view.onApplyWindowInsets(windowInsets)
        }
    }
}