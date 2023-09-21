package com.android.gowild.ui.achievements

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.fragment.app.viewModels
import androidx.viewbinding.ViewBinding
import com.android.gowild.BuildConfig
import com.android.gowild.R
import com.android.gowild.data.model.settings.MyAchievementsDataModel
import com.android.gowild.data.model.user.User
import com.android.gowild.databinding.FragmentAchievementBinding
import com.android.gowild.interfaces.SimpleCallbackValue
import com.android.gowild.networking.Errors
import com.android.gowild.networking.NetworkResult
import com.android.gowild.ui.base.BaseFragment
import com.android.gowild.ui.map.MapActivity
import com.android.gowild.ui.user.dialog.ErrorDialog
import com.android.gowild.utils.extension.setRecyclerViewAdapter
import com.android.gowild.utils.extension.showBar
import com.android.gowild.utils.local.UserPrefs
import com.google.gson.Gson
import dagger.hilt.android.AndroidEntryPoint
import timber.log.Timber

@AndroidEntryPoint
class AchievementFragment : BaseFragment() {

    companion object {
        @JvmStatic
        fun newInstance() =
            AchievementFragment()
    }

    lateinit var binding: FragmentAchievementBinding
    private val achievementVM: AchievementVM by viewModels()
    var achievementDataList: ArrayList<MyAchievementsDataModel> = ArrayList()
    lateinit var user: User

    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentAchievementBinding.inflate(layoutInflater)
        init()
        return binding
    }

    private fun init() {
        user = UserPrefs(requireContext()).getUser()!!
        achievementVM.getAchievementsLeaderboard()
        binding.ivBack.setOnClickListener {
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }
        setupObservers()
    }

    private fun setupObservers() {
        achievementVM.getAchievementsLeaderboardResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    hideProgress()
                    achievementDataList.addAll(response.data!!.data)
                    binding.rvAchievements.setRecyclerViewAdapter(
                        R.layout.list_item_achievements_user,
                        achievementDataList,
                        Gson().toJson(userPrefs.getUser()!!),
                        SimpleCallbackValue {
                            requireActivity().startActivity(
                                MapActivity.start(
                                    requireActivity(),
                                    "LeaderboardDetails",
                                    leaderboardData = Gson().toJson(it as MyAchievementsDataModel)
                                )
                            )
                        }
                    )

                    Timber.tag("userImg").d("setupObservers: ${BuildConfig.BASE_URL}${user.picture}")
                }

                is NetworkResult.Failure -> {
                    hideProgress()
                    response.junkError?.let { junkErrors ->
                        ErrorDialog(mContext, junkErrors.errors!![0].map { it.value }).show()
                    } ?: kotlin.run {
                        binding.root.showBar(response.message ?: "Failure")
                    }
                }

                is NetworkResult.Loading -> {
                    showProgress()
                }

                is NetworkResult.Error -> {
                    when (response.error) {
                        is Errors.Error -> {
                            hideProgress()
                            binding.root.showBar("Please try again later")
                        }

                        is Errors.NetworkError -> {
                            hideProgress()
                            binding.root.showBar("Internet connection unavailable")
                        }

                        is Errors.ServerError -> {
                            hideProgress()
                            binding.root.showBar("Server error")
                        }

                        is Errors.TimeOutError -> {
                            hideProgress()
                            binding.root.showBar("Network time out")
                        }

                        null -> {
                            hideProgress()
                            binding.root.showBar("Please try again later")
                        }
                    }
                }
            }
        }
    }
}