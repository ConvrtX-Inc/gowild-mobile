package com.android.gowild.ui.map.runwild

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.viewbinding.ViewBinding
import com.android.gowild.data.model.settings.MyAchievementsDataModel
import com.android.gowild.databinding.FragmentLeaderBoardDetailBinding
import com.android.gowild.ui.base.BaseFragment
import com.android.gowild.utils.extension.gone
import com.android.gowild.utils.extension.loadUserImage
import com.android.gowild.utils.extension.toast
import com.google.gson.Gson

class LeaderBoardDetailFragment : BaseFragment() {

    companion object {
        @JvmStatic
        fun newInstance() = LeaderBoardDetailFragment()
    }

    private lateinit var binding: FragmentLeaderBoardDetailBinding
    private lateinit var leaderBoardData: MyAchievementsDataModel

    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentLeaderBoardDetailBinding.inflate(layoutInflater)
        init()
        return binding
    }

    fun init() {
        getLeaderboardData()
        setCallbacks()
    }

    private fun setCallbacks() {
        binding.backIv.setOnClickListener {
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }
    }

    private fun getLeaderboardData() {
        if (requireArguments().containsKey("leaderboardData") && requireArguments().getString("leaderboardData") != null && requireArguments().getString(
                "leaderboardData"
            ) != ""
        ) {
            leaderBoardData = Gson().fromJson(requireArguments().getString("leaderboardData")!!, MyAchievementsDataModel::class.java)
            setLeaderBoardData()
        } else {
            toast("Leaderboard not found")
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }
    }

    private fun getRankText(rank: Int): String {
        return when (rank) {
            1 -> {
                "1st"
            }

            2 -> {
                "2nd"
            }

            3 -> {
                "3rd"
            }

            else -> {
                rank.toString() + "th"
            }
        }
    }

    private fun setLeaderBoardData() {
        if (leaderBoardData.user != null) {
            binding.achievementProfileImg.loadUserImage(leaderBoardData.user!!)
            binding.name.text = leaderBoardData.user!!.firstName + " " + leaderBoardData.user!!.lastName
        } else {
            binding.achievementProfileImg.loadUserImage(userPrefs.getUser()!!)
            binding.name.text = userPrefs.getUser()!!.firstName + " " + userPrefs.getUser()!!.lastName
        }
        binding.congratulationsTxt.text = "congratulations\nyou are ${getRankText(leaderBoardData.rank)} place on this route"
        binding.tvTime.text = leaderBoardData.completionTime
        binding.distanceStartHint.gone()
        binding.distanceEndHint.gone()
        binding.distanceStart.text = leaderBoardData.route.startLocation
        binding.distanceEnd.text = leaderBoardData.route.endLocation
    }
}