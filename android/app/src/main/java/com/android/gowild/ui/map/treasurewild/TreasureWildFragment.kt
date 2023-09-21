package com.android.gowild.ui.map.treasurewild

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.viewbinding.ViewBinding
import com.android.gowild.databinding.FragmentTreasureWildBinding
import com.android.gowild.ui.base.BaseFragment
import dagger.hilt.android.AndroidEntryPoint
import javax.inject.Inject

@AndroidEntryPoint
class TreasureWildFragment : BaseFragment() {

    companion object {
        @JvmStatic
        fun newInstance() =
            TreasureWildFragment()
    }

    @Inject
    lateinit var treasureWildAdapterUpcoming: TreasureWildAdapter

    @Inject
    lateinit var treasureWildAdapterOngoing: TreasureWildAdapter

    private lateinit var binding: FragmentTreasureWildBinding

    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentTreasureWildBinding.inflate(layoutInflater)
        init()
        return binding
    }

    private fun init() {
        setCallbacks()
//        setViewPager()
    }

    private fun setViewPager() {
        binding.root.post {
            binding.viewPager.adapter = null
            binding.viewPager.adapter = TreasureWildPagerAdapter(childFragmentManager)
            binding.tabLayout.setupWithViewPager(binding.viewPager)
        }
    }

    private fun setCallbacks() {
        binding.backIv.setOnClickListener {
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }
    }

    override fun onResume() {
        super.onResume()
        setViewPager()
    }
}