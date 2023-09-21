package com.android.gowild.ui.map.treasurewild

import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentManager
import androidx.fragment.app.FragmentPagerAdapter
import com.android.gowild.ui.map.treasurewild.TreasureWildFragmentOngoing
import com.android.gowild.ui.map.treasurewild.TreasureWildFragmentUpcoming


class TreasureWildPagerAdapter(fm: FragmentManager) : FragmentPagerAdapter(fm) {
    override fun getCount(): Int {
        return 2;
    }

    override fun getItem(position: Int): Fragment {
        when (position) {
            0 -> {
                return TreasureWildFragmentUpcoming()
            }
            else -> {
                return TreasureWildFragmentOngoing()
            }
        }
    }

    override fun getPageTitle(position: Int): CharSequence? {
        when (position) {
            0 -> {
                return "Upcoming"
            }
            1 -> {
                return "On Going"
            }
        }
        return super.getPageTitle(position)
    }



}