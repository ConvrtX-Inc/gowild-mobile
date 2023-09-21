package com.android.gowild.ui.base

import android.graphics.Color
import android.os.Bundle
import android.view.MenuItem
import android.view.View
import android.view.WindowManager
import com.android.gowild.databinding.ActivityBaseToolbarBinding
import com.android.gowild.utils.extension.hide
import com.android.gowild.utils.extension.show
import com.android.gowild.utils.local.UserPrefs
import dagger.hilt.android.AndroidEntryPoint
import javax.inject.Inject

@AndroidEntryPoint
open class BaseToolbarActivity : BaseActivity() {
//

    protected lateinit var baseBinding: ActivityBaseToolbarBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        baseBinding = ActivityBaseToolbarBinding.inflate(layoutInflater)
        super.setContentView(baseBinding.root)
        setSupportActionBar(baseBinding.toolbar)
        if (supportParentActivityIntent != null) supportActionBar?.setDisplayHomeAsUpEnabled(true)

    }

    override fun setContentView(view: View) {
        baseBinding.container.addView(view)
    }

    protected override fun showProgress() {
        window.setFlags(
            WindowManager.LayoutParams.FLAG_NOT_TOUCHABLE,
            WindowManager.LayoutParams.FLAG_NOT_TOUCHABLE
        )
        baseBinding.progressLayout.show()
        baseBinding.ivProgress.show()
    }

    protected override fun hideProgress() {
        window.clearFlags(WindowManager.LayoutParams.FLAG_NOT_TOUCHABLE)
        baseBinding.progressLayout.hide()
        baseBinding.ivProgress.hide()
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        if (item.itemId == android.R.id.home) {
            onBackPressed()
            return true
        } else onBackPressed()
        return false
    }

    protected fun setToolBarColor(color: String) {
        window.statusBarColor = Color.parseColor(color) //status bar color
        baseBinding.toolbar.setBackgroundColor(Color.parseColor(color)) //toolbar color
    }

}