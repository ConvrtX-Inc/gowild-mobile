package com.android.gowild.ui.path

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.viewbinding.ViewBinding
import com.android.gowild.databinding.FragmentPathBinding
import com.android.gowild.ui.base.BaseFragment


class PathFragment : BaseFragment() {

    companion object {
        @JvmStatic
        fun newInstance() = PathFragment()
    }

    private lateinit var binding: FragmentPathBinding

    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentPathBinding.inflate(layoutInflater)
        return binding
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
    }
}