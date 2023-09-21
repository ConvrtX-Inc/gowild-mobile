package com.android.gowild.ui.setting

import android.app.Activity
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentActivity
import com.android.gowild.R
import com.android.gowild.databinding.ActivitySettingsBinding
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class SettingsActivity : AppCompatActivity() {

    companion object {
        fun start(activity: Activity) {
            val intent = Intent(activity, SettingsActivity::class.java)
            activity.startActivity(intent)
        }

        fun replaceFragment(requireActivity: FragmentActivity, nextFragment: Fragment) {
            requireActivity
                .supportFragmentManager
                .beginTransaction()
                .replace(R.id.settingFragmentContainerView, nextFragment)
                .addToBackStack(nextFragment::class.java.name)
                .commit()
        }

        fun addFragment(
            requireActivity: FragmentActivity, nextFragment: Fragment
        ) {
            requireActivity
                .supportFragmentManager
                .beginTransaction()
                .add(R.id.settingFragmentContainerView, nextFragment)
                .addToBackStack(nextFragment::class.java.name)
                .commit()
        }
    }

    private lateinit var binding: ActivitySettingsBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivitySettingsBinding.inflate(layoutInflater)
        setContentView(binding.root)
        setFragment()
    }

    private fun setFragment() {
        supportFragmentManager
            .beginTransaction()
            .add(R.id.settingFragmentContainerView, SettingsFragment.newInstance())
            .commit()
    }
}