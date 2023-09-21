package com.android.gowild.ui.user

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.activity.addCallback
import androidx.viewbinding.ViewBinding
import com.android.gowild.databinding.FragmentUserBinding
import com.android.gowild.ui.base.BaseFragment
import com.android.gowild.ui.main.MainActivity
import com.android.gowild.ui.map.MapActivity
import com.android.gowild.utils.extension.gone
import com.android.gowild.utils.extension.loadUserImage
import com.android.gowild.utils.extension.toast
import com.android.gowild.utils.local.UserPrefs

class UserFragment : BaseFragment() {

    companion object {
        @JvmStatic
        fun newInstance() = UserFragment()
    }

    private lateinit var binding: FragmentUserBinding

    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentUserBinding.inflate(layoutInflater)
        init()
        return binding
    }

    private fun init() {
        setCallbacks()
    }

    private fun setCallbacks() {
        binding.btnSubmit.setOnClickListener {
            if (!userPrefs.getUser()!!.selfie_verified!!)
                requireActivity().startActivity(MapActivity.start(requireActivity(), "SelfieVerification"))
            else
                toast("Your selfie is already verified")
        }

        binding.ivBack.setOnClickListener {
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }

        requireActivity().onBackPressedDispatcher.addCallback(owner = viewLifecycleOwner, enabled = true) {
            (requireActivity() as MainActivity).binding.ivHome.performClick()
        }
    }

    private fun setUserData() {
        val user = UserPrefs(requireContext()).getUser()!!
        binding.tvName.text = "${user.firstName} ${user.lastName}"
        binding.tvDescription.text = user.about_me
        binding.ivProfile.loadUserImage(user)
    }

    override fun onResume() {
        super.onResume()
        setUserData()
    }
}