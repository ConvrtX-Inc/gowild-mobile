package com.android.gowild.ui.map

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.activity.addCallback
import androidx.viewbinding.ViewBinding
import com.android.gowild.databinding.FragmentMapBinding
import com.android.gowild.ui.base.BaseFragment
import com.android.gowild.ui.main.MainActivity

class MapFragment : BaseFragment() {

    companion object {
        @JvmStatic
        fun newInstance() = MapFragment()
    }

    private lateinit var binding: FragmentMapBinding

    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentMapBinding.inflate(layoutInflater)
        init()
        return binding
    }

    fun init() {
        setCallbacks()
    }

    private fun setCallbacks() {
        binding.treasureWildCard.setOnClickListener {
            requireActivity().startActivity(MapActivity.start(requireActivity(), "TreasureWildCard"))
        }

        binding.runWildCard.setOnClickListener {
            requireActivity().startActivity(MapActivity.start(requireActivity(), "RunWildCard"))
        }

        binding.myTrailsCard.setOnClickListener {
            requireActivity().startActivity(MapActivity.start(requireActivity(), "MyTrailCard"))
        }

        binding.backIv.setOnClickListener {
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }

        requireActivity().onBackPressedDispatcher.addCallback(owner = viewLifecycleOwner, enabled = true) {
            (requireActivity() as MainActivity).binding.ivHome.performClick()
        }
    }
}