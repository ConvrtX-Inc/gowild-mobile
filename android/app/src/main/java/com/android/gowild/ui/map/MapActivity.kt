package com.android.gowild.ui.map

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentActivity
import com.android.gowild.R
import com.android.gowild.databinding.ActivityMapBinding
import com.android.gowild.ui.home.CommentsFragment
import com.android.gowild.ui.home.FeedDetailsFragment
import com.android.gowild.ui.home.FriendRequestFragment
import com.android.gowild.ui.home.MapOverlayFragment
import com.android.gowild.ui.map.mytrail.SaveRoutesFragment
import com.android.gowild.ui.map.runwild.LeaderBoardDetailFragment
import com.android.gowild.ui.map.runwild.LeaderBoardFragment
import com.android.gowild.ui.map.runwild.RouteDetailsFragmentNew
import com.android.gowild.ui.map.runwild.RunWildFragment
import com.android.gowild.ui.map.treasurewild.TreasureWildFragment
import com.android.gowild.ui.messages.FriendListFragment
import com.android.gowild.ui.notification.NotificationFragment
import com.android.gowild.ui.support.SupportFragment
import com.android.gowild.ui.user.SelfieVerificationFragment
import dagger.hilt.android.AndroidEntryPoint
import timber.log.Timber

@AndroidEntryPoint
class MapActivity : AppCompatActivity() {

    companion object {
        fun start(
            activity: Activity,
            fragmentName: String,
            postID: String? = null,
            route_id: String? = null,
            position: Int? = null,
            leaderboardData: String? = null
        ): Intent {
            val intent = Intent(activity, MapActivity::class.java)
            intent.putExtra("fragmentName", fragmentName)
            if (postID != null) {
                intent.putExtra("postID", postID)
                Timber.tag("GW_INTENT").wtf("MapActivityStart() $postID")
                if (position != null)
                    intent.putExtra("position", position)
            }
            if (route_id != null) {
                Timber.tag("GW_INTENT").wtf("MapActivityStart $route_id")
                intent.putExtra("route_id", route_id)
            }
            if (leaderboardData != null) {
                Timber.tag("GW_INTENT").wtf("MapActivityStart $leaderboardData")
                intent.putExtra("leaderboardData", leaderboardData)
            }
            return intent
        }

        fun replaceFragment(requireActivity: FragmentActivity, nextFragment: Fragment) {
            requireActivity
                .supportFragmentManager
                .beginTransaction()
                .replace(R.id.mapFragmentContainerView, nextFragment)
                .addToBackStack(nextFragment::class.java.name)
                .commit()
        }

        fun addFragment(requireActivity: FragmentActivity, nextFragment: Fragment) {
            requireActivity
                .supportFragmentManager
                .beginTransaction()
                .add(R.id.mapFragmentContainerView, nextFragment)
                .addToBackStack(nextFragment::class.java.name)
                .commit()
        }
    }

    private lateinit var binding: ActivityMapBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMapBinding.inflate(layoutInflater)
        setContentView(binding.root)
        setFragment()
    }

    private fun setFragment() {
        if (intent.getStringExtra("fragmentName").equals("TreasureWildCard")) {
            addFirst(TreasureWildFragment.newInstance())
        } else if (intent.getStringExtra("fragmentName").equals("friendRequestFragment")) {
            addFirst(FriendRequestFragment.newInstance())
        } else if (intent.getStringExtra("fragmentName").equals("RunWildCard")) {
            addFirst(RunWildFragment.newInstance())
        } else if (intent.getStringExtra("fragmentName").equals("MyTrailCard")) {
            addFirst(SaveRoutesFragment.newInstance())
        } else if (intent.getStringExtra("fragmentName").equals("CommentsFragment")) {
            val commentsFragment = CommentsFragment.newInstance()
            commentsFragment.arguments = intent.extras
            addFirst(commentsFragment)
        } else if (intent.getStringExtra("fragmentName").equals("RouteDetails")) {
//            val routeDetailsFragment = RouteDetailsFragment.newInstance()
            val routeDetailsFragment = RouteDetailsFragmentNew.newInstance()
            routeDetailsFragment.arguments = intent.extras
            addFirst(routeDetailsFragment)
        } else if (intent.getStringExtra("fragmentName").equals("MapOverlay")) {
            addFirst(MapOverlayFragment.newInstance())
        } else if (intent.getStringExtra("fragmentName").equals("SelfieVerification")) {
            addFirst(SelfieVerificationFragment.newInstance())
        } else if (intent.getStringExtra("fragmentName").equals("FeedDetails")) {
            val feedDetailsFragment = FeedDetailsFragment.newInstance()
            feedDetailsFragment.arguments = intent.extras
            addFirst(feedDetailsFragment)
        } else if (intent.getStringExtra("fragmentName").equals("Leaderboard")) {
            val leaderBoardFragment = LeaderBoardFragment.newInstance()
            leaderBoardFragment.arguments = intent.extras
            addFirst(leaderBoardFragment)
        } else if (intent.getStringExtra("fragmentName").equals("Notification")) {
            addFirst(NotificationFragment.newInstance())
        } else if (intent.getStringExtra("fragmentName").equals("FriendList")) {
            addFirst(FriendListFragment.newInstance())
        } else if (intent.getStringExtra("fragmentName").equals("Support")) {
            addFirst(SupportFragment.newInstance())
        } else if (intent.getStringExtra("fragmentName").equals("LeaderboardDetails")) {
            val leaderBoardFragment = LeaderBoardDetailFragment.newInstance()
            leaderBoardFragment.arguments = intent.extras
            addFirst(leaderBoardFragment)
        }
    }

    private fun replace(nextFragment: Fragment) {
        replaceFragment(this, nextFragment)
    }

    private fun addFirst(nextFragment: Fragment) {
        this
            .supportFragmentManager
            .beginTransaction()
            .replace(R.id.mapFragmentContainerView, nextFragment, nextFragment::class.java.name)
            .commit()
    }

    fun popUpToTreasureWild() {
        while (supportFragmentManager.backStackEntryCount != 0) {
            supportFragmentManager.popBackStackImmediate()
        }
    }
}
