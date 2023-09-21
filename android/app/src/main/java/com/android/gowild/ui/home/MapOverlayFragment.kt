package com.android.gowild.ui.home

import android.app.Activity
import android.content.Intent
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.core.os.bundleOf
import androidx.viewbinding.ViewBinding
import com.android.gowild.databinding.FragmentMapOverlayBinding
import com.android.gowild.ui.base.BaseFragment
import com.android.gowild.ui.map.MapActivity
import com.android.gowild.utils.constant.MAP_TYPE
import com.mapbox.maps.Style

class MapOverlayFragment : BaseFragment() {

    companion object {
        @JvmStatic
        fun newInstance() = MapOverlayFragment()
    }

    lateinit var binding: FragmentMapOverlayBinding

    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentMapOverlayBinding.inflate(layoutInflater)
        init()
        return binding
    }

    fun init() {
        setDefault()
        setCallbacks()
    }

    private fun setDefault() {
        when (MAP_TYPE) {
            Style.MAPBOX_STREETS -> {
                binding.tvSetAsDefaultRoadMap.text = "Selected"
            }

            Style.SATELLITE -> {
                binding.tvSetAsDefaultTerrain.text = "Selected"
            }

            Style.OUTDOORS -> {
                binding.tvSetAsDefaultSatellite.text = "Selected"
            }
        }
    }

    private fun setCallbacks() {
        binding.tvSetAsDefaultRoadMap.setOnClickListener {
            MAP_TYPE = Style.MAPBOX_STREETS
            val intent = Intent()
            intent.putExtras(bundleOf("map_type" to MAP_TYPE))
            (requireActivity() as MapActivity).setResult(Activity.RESULT_OK, intent)
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }
        binding.tvSetAsDefaultTerrain.setOnClickListener {
            MAP_TYPE = Style.SATELLITE
            val intent = Intent()
            intent.putExtras(bundleOf("map_type" to MAP_TYPE))
            (requireActivity() as MapActivity).setResult(Activity.RESULT_OK, intent)
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }
        binding.tvSetAsDefaultSatellite.setOnClickListener {
            MAP_TYPE = Style.OUTDOORS
            val intent = Intent()
            intent.putExtras(bundleOf("map_type" to MAP_TYPE))
            (requireActivity() as MapActivity).setResult(Activity.RESULT_OK, intent)
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }
        binding.backIv.setOnClickListener {
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }
    }
}