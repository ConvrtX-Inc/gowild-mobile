package com.android.gowild.ui.home


import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.ViewGroup.MarginLayoutParams
import androidx.viewbinding.ViewBinding
import com.android.gowild.R
import com.android.gowild.data.model.user.User
import com.android.gowild.databinding.FragmentHomeBinding
import com.android.gowild.ui.base.BaseFragment
import com.android.gowild.ui.map.MapActivity
import com.android.gowild.ui.setting.SettingsActivity
import com.android.gowild.utils.extension.loadUserImage
import com.android.gowild.utils.local.UserPrefs
import java.util.*

class HomeFragment : BaseFragment() {

    companion object {
        @JvmStatic
        fun newInstance() = HomeFragment()
    }

    private lateinit var binding: FragmentHomeBinding

    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentHomeBinding.inflate(layoutInflater)

        init()

        return binding
    }


    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)


    }

    private fun init() {
        setUserData()
        setCallbacks()
        setAdapters()
    }

    private fun setAdapters() {
//        var adventures = arrayListOf(
//            HomeNearbyAdventuresModel(),
//            HomeNearbyAdventuresModel(),
//            HomeNearbyAdventuresModel(),
//            HomeNearbyAdventuresModel(),
//            HomeNearbyAdventuresModel(),
//        )
//        binding.rcAdvantureView.adapter = NearByAdventuresAdapter(adventures)
//        binding.rcView.adapter = GoWildFeedAdapter()
    }

    private fun setCallbacks() {
        binding.imageCard.setOnClickListener {
            activity?.let {
                SettingsActivity.start(it)
            }
        }
        binding.btnMyFeed.setOnClickListener {
            binding.btnMyFeed.setTextColor(resources.getColor(R.color.white))
            binding.btnMyFeed.setBackgroundResource(R.drawable.tab_left_active_bg)
            binding.btnMyFriend.setTextColor(resources.getColor(R.color.gold_orange))
            binding.btnMyFriend.setBackgroundResource(R.drawable.tab_right_off_bg)

            binding.goWildMsgField.visibility = View.VISIBLE
            binding.goWildUserField.visibility = View.VISIBLE
            binding.goWildRcView.visibility = View.VISIBLE

            binding.myFriendRcView.visibility = View.GONE
        }


        binding.btnMyFriend.setOnClickListener {
            binding.btnMyFriend.setTextColor(resources.getColor(R.color.white))
            binding.btnMyFriend.setBackgroundResource(R.drawable.tab_right_active_bg)
            binding.btnMyFeed.setTextColor(resources.getColor(R.color.gold_orange))
            binding.btnMyFeed.setBackgroundResource(R.drawable.tab_left_off_bg)

            binding.goWildMsgField.visibility = View.GONE
            binding.goWildUserField.visibility = View.GONE
            binding.goWildRcView.visibility = View.GONE

            binding.myFriendRcView.visibility = View.VISIBLE


        }

        var isRoutesSelected = false
        binding.ivRoutes.setOnClickListener {
            if (isRoutesSelected) {
                isRoutesSelected = false
                binding.cvRoutes.visibility = View.GONE
                binding.mapDetails.visibility = View.GONE
                binding.ivRoutes.setImageResource(R.drawable.ic_chevron_right)

                val p: MarginLayoutParams = binding.ivRoutes.layoutParams as MarginLayoutParams
                p.setMargins(0, 0, 0, 0)
            } else {
                isRoutesSelected = true
                binding.cvRoutes.visibility = View.VISIBLE
                binding.mapDetails.visibility = View.VISIBLE
                binding.ivRoutes.setImageResource(R.drawable.ic_chevron_down)

                val p: MarginLayoutParams = binding.ivRoutes.layoutParams as MarginLayoutParams
                p.setMargins(0, 0, 10, 0)
            }
        }


        var isAdventureSelected = false
        binding.ivNearByAdventure.setOnClickListener {
            if (isAdventureSelected) {
                isAdventureSelected = false
                binding.rcAdvantureView.visibility = View.GONE
                binding.ivNearByAdventure.setImageResource(R.drawable.ic_chevron_right)

                val p: MarginLayoutParams =
                    binding.ivNearByAdventure.layoutParams as MarginLayoutParams
                p.setMargins(0, 0, 0, 0)
            } else {
                isAdventureSelected = true
                binding.rcAdvantureView.visibility = View.VISIBLE
                binding.ivNearByAdventure.setImageResource(R.drawable.ic_chevron_down)

                val p: MarginLayoutParams =
                    binding.ivNearByAdventure.layoutParams as MarginLayoutParams
                p.setMargins(0, 0, 10, 0)
            }
        }


        var isGoWildSelected = false
        binding.ivGoWildFeed.setOnClickListener {
            if (isGoWildSelected) {
                isGoWildSelected = false
                binding.nestedConstraintLayout.visibility = View.GONE
                binding.ivGoWildFeed.setImageResource(R.drawable.ic_chevron_right)

                val p: MarginLayoutParams = binding.ivGoWildFeed.layoutParams as MarginLayoutParams
                p.setMargins(0, 0, 0, 0)

            } else {
                isGoWildSelected = true
                binding.nestedConstraintLayout.visibility = View.VISIBLE
                binding.ivGoWildFeed.setImageResource(R.drawable.ic_chevron_down)

                val p: MarginLayoutParams = binding.ivGoWildFeed.layoutParams as MarginLayoutParams
                p.setMargins(0, 0, 10, 0)

            }
        }

        binding.seeAll.setOnClickListener {
            requireActivity().startActivity(MapActivity.start(requireActivity(), "friendRequestFragment"))
        }
    }

    private fun setUserData() {
        val user: User = UserPrefs(requireContext()).getUser()!!
        binding.tvName.text = "${user.firstName} ${user.lastName}"
        binding.userImage.loadUserImage(user)
        setGreetings()
    }

    private fun setGreetings() {
        when (Calendar.getInstance().get(Calendar.HOUR_OF_DAY)) {
            in 0.rangeTo(11) -> binding.tvGreetings.text = "Good Morning,"
            in 12.rangeTo(17) -> binding.tvGreetings.text = "Good Afternoon,"
            in 18.rangeTo(23) -> binding.tvGreetings.text = "Good Evening,"
        }
    }
}