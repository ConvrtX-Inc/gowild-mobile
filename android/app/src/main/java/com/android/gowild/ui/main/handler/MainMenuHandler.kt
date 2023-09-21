package com.android.gowild.ui.main.handler

import android.view.View
import com.android.gowild.R
import com.android.gowild.databinding.ActivityMainBinding
import com.android.gowild.ui.base.BaseFragment
import com.android.gowild.ui.camera.CameraFragment
import com.android.gowild.ui.home.FriendRequestFragment
import com.android.gowild.ui.home.HomeFragment
import com.android.gowild.ui.home.HomeFragmentNew
import com.android.gowild.ui.main.MainActivity
import com.android.gowild.ui.map.MapFragment
import com.android.gowild.ui.path.PathFragment
import com.android.gowild.ui.user.UserFragment
import javax.inject.Inject
import javax.inject.Singleton


@Singleton
class MainMenuHandler @Inject constructor() {

    fun setUpClickListeners(activity: MainActivity, binding: ActivityMainBinding) {
        binding.ivHome.setOnClickListener { onClickBottomMenuItem(it, activity, binding) }
        binding.ivMap.setOnClickListener { onClickBottomMenuItem(it, activity, binding) }
        binding.ivCamera.setOnClickListener { onClickBottomMenuItem(it, activity, binding) }
        binding.ivPath.setOnClickListener { onClickBottomMenuItem(it, activity, binding) }
        binding.ivUser.setOnClickListener { onClickBottomMenuItem(it, activity, binding) }
    }

    private fun onClickBottomMenuItem(
        button: View,
        activity: MainActivity,
        binding: ActivityMainBinding
    ) {
        when (button) {
            binding.ivHome -> {
                replaceFragment(HomeFragmentNew.newInstance(), activity, binding)
                binding.ivHome.setImageResource(R.drawable.ic_home_checked)
                binding.ivMap.setImageResource(R.drawable.ic_map)
                binding.ivCamera.setImageResource(R.drawable.ic_camera)
                binding.ivPath.setImageResource(R.drawable.ic_path)
                binding.ivUser.setImageResource(R.drawable.ic_user)
            }

            binding.ivMap -> {
                replaceFragment(MapFragment.newInstance(), activity, binding)
                binding.ivHome.setImageResource(R.drawable.ic_home)
                binding.ivMap.setImageResource(R.drawable.ic_map_checked)
                binding.ivCamera.setImageResource(R.drawable.ic_camera)
                binding.ivPath.setImageResource(R.drawable.ic_path)
                binding.ivUser.setImageResource(R.drawable.ic_user)
            }

            binding.ivCamera -> {
                replaceFragment(CameraFragment.newInstance(), activity, binding)
                binding.ivHome.setImageResource(R.drawable.ic_home)
                binding.ivMap.setImageResource(R.drawable.ic_map)
                binding.ivCamera.setImageResource(R.drawable.ic_camera)
                binding.ivPath.setImageResource(R.drawable.ic_path)
                binding.ivUser.setImageResource(R.drawable.ic_user)
            }

            binding.ivPath -> {
                replaceFragment(PathFragment.newInstance(), activity, binding)
//                replaceFragment(FriendRequestFragment.newInstance(), activity, binding)
                binding.ivHome.setImageResource(R.drawable.ic_home)
                binding.ivMap.setImageResource(R.drawable.ic_map)
                binding.ivCamera.setImageResource(R.drawable.ic_camera)
                binding.ivPath.setImageResource(R.drawable.ic_path_checked)
                binding.ivUser.setImageResource(R.drawable.ic_user)
            }

            binding.ivUser -> {
                replaceFragment(UserFragment.newInstance(), activity, binding)
                binding.ivHome.setImageResource(R.drawable.ic_home)
                binding.ivMap.setImageResource(R.drawable.ic_map)
                binding.ivCamera.setImageResource(R.drawable.ic_camera)
                binding.ivPath.setImageResource(R.drawable.ic_path)
                binding.ivUser.setImageResource(R.drawable.ic_user_checked)
            }
        }
    }

    private fun replaceFragment(
        fragment: BaseFragment,
        activity: MainActivity,
        binding: ActivityMainBinding
    ) {
        activity.supportFragmentManager.beginTransaction()
            .replace(R.id.container, fragment)
            .setCustomAnimations(
                R.anim.enter,
                R.anim.exit,
                R.anim.pop_enter,
                R.anim.pop_exit
            ).commit()
    }
}