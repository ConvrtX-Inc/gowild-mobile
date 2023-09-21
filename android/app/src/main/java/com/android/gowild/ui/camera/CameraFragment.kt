package com.android.gowild.ui.camera

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.viewbinding.ViewBinding
import com.android.gowild.databinding.FragmentCameraBinding
import com.android.gowild.ui.base.BaseFragment


class CameraFragment : BaseFragment() {

    companion object {
        @JvmStatic
        fun newInstance() = CameraFragment()
    }

    private lateinit var binding: FragmentCameraBinding

    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentCameraBinding.inflate(layoutInflater)
        return binding
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
    }
}