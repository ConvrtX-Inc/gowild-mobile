package com.android.gowild.ui.main

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import com.android.gowild.databinding.ActivityMainBinding
import com.android.gowild.ui.base.BaseActivity
import com.android.gowild.ui.main.handler.MainMenuHandler
import com.android.gowild.ui.map.MapActivity
import dagger.hilt.android.AndroidEntryPoint
import timber.log.Timber
import javax.inject.Inject

@AndroidEntryPoint
class MainActivity : BaseActivity() {

    companion object {
        fun start(activity: Activity) {
            val intent = Intent(activity, MainActivity::class.java)
            intent.flags = Intent.FLAG_ACTIVITY_CLEAR_TASK or Intent.FLAG_ACTIVITY_NEW_TASK
            activity.startActivity(intent)
        }
    }

    @Inject
    lateinit var mainMenuHandler: MainMenuHandler

    lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        mainMenuHandler.setUpClickListeners(this, binding)
        binding.ivHome.performClick()
        onNewIntent(intent)
    }

    override fun onNewIntent(intent: Intent?) {
        super.onNewIntent(intent)
        if (intent != null) {
            if (intent.data != null) {
                val uri = intent.data!!
                if (isRouteIntent(uri)) {
                    Timber.tag("GW_INTENT").wtf("onNewIntent Data = isRouteIntent")
                }
                if (isFeedIntent(uri)) {
                    Timber.tag("GW_INTENT").wtf("onNewIntent Data = isFeedIntent")
                }
            } else {
                Timber.tag("GW_INTENT").wtf("onNewIntent noUri")
                if (intent.hasExtra("type")) {
                    Timber.tag("GW_INTENT").wtf("onNewIntent hasType")
                } else {
                    Timber.tag("GW_INTENT").wtf("onNewIntent hasNoType")
                }

            }
        } else {
            Timber.tag("GW_INTENT").wtf("onNewIntent noData")
        }
        handleIntent(intent)
    }

    private fun isRouteIntent(uri: Uri): Boolean = uri.path == "/route"
    private fun isFeedIntent(uri: Uri): Boolean = uri.path == "/feed"

    private fun handleIntent(intent: Intent?) {
        if (intent != null) {
            if (intent.data != null) {
                handleDeepLinksRedirection(intent.data!!)
            } else if (intent.hasExtra("type")) {
                handleNotificationsRedirection(intent.getStringExtra("type")!!)
            }
        }
    }

    private fun handleDeepLinksRedirection(uri: Uri) {
        if (isRouteIntent(uri)) {
            Timber.tag("GW_INTENT").wtf("isRouteIntent")
            intent.putExtra("route_id", uri.getQueryParameter("routeID"))
            startActivity(MapActivity.start(this, "RouteDetails", route_id = uri.getQueryParameter("routeID")))
        } else if (isFeedIntent(uri)) {
            Timber.tag("GW_INTENT").wtf("isFeedIntent")
            Timber.tag("GW_INTENT").wtf("isFeedIntent ${uri.getQueryParameter("feedID")}")
            startActivity(MapActivity.start(this, "FeedDetails", postID = uri.getQueryParameter("feedID")))
        }
    }

    private fun handleNotificationsRedirection(type: String) {
        when (type) {
            "routes" -> {
                startActivity(MapActivity.start(this, "MyTrailCard"))
            }
            "treasureChest" -> {
                startActivity(MapActivity.start(this, "TreasureWildCard"))
            }
            "approve" -> {
                startActivity(MapActivity.start(this, "MyTrailCard"))
            }
            "notification" -> {
                startActivity(MapActivity.start(this, "Notification"))
            }
            "inbox" -> {
                startActivity(MapActivity.start(this, "FriendList"))
            }
            "support" -> {
                startActivity(MapActivity.start(this, "Support"))
            }
        }
    }
}