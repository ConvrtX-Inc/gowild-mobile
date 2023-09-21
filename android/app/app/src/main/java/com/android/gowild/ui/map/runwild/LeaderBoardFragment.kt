package com.android.gowild.ui.map.runwild


import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.fragment.app.viewModels
import androidx.viewbinding.ViewBinding
import com.android.gowild.BuildConfig
import com.android.gowild.R
import com.android.gowild.data.model.settings.MyAchievementsDataModel
import com.android.gowild.data.model.user.User
import com.android.gowild.databinding.FragmentLeaderBoardBinding
import com.android.gowild.interfaces.SimpleCallbackValue
import com.android.gowild.networking.Errors
import com.android.gowild.networking.NetworkResult
import com.android.gowild.ui.base.BaseFragment
import com.android.gowild.ui.map.MapActivity
import com.android.gowild.ui.user.dialog.ErrorDialog
import com.android.gowild.utils.extension.setRecyclerViewAdapter
import com.android.gowild.utils.extension.showBar
import com.android.gowild.utils.extension.toast
import com.android.gowild.utils.local.UserPrefs
import com.google.gson.Gson

class LeaderBoardFragment : BaseFragment() {

    companion object {
        @JvmStatic
        fun newInstance() = LeaderBoardFragment()
    }

    private lateinit var binding: FragmentLeaderBoardBinding
    private val routeDetailsVM: RouteDetailsVM by viewModels()
    var leaderboardDataList: ArrayList<MyAchievementsDataModel> = ArrayList()
    lateinit var user: User

    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentLeaderBoardBinding.inflate(layoutInflater)
        init()
        return binding
    }

    private fun init() {
        getLeaderboards()
        observeNetworkResponses()
        setCallbacks()
    }

    private fun observeNetworkResponses() {
        observeRouteLeaderboard()
    }

    private fun observeRouteLeaderboard() {
        routeDetailsVM.routeLeaderboardResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    hideProgress()
                    user = UserPrefs(requireContext()).getUser()!!
                    leaderboardDataList.clear()
                    leaderboardDataList.addAll(response.data!!.data)
                    binding.rvLeaderBoard.setRecyclerViewAdapter(
                        R.layout.list_item_achievements_route,
                        leaderboardDataList,
                        BuildConfig.BASE_URL + user.picture,
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

    private fun setCallbacks() {
        binding.ivBack.setOnClickListener {
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }
    }

    private fun getLeaderboards() {
        if (requireArguments().containsKey("route_id") && requireArguments().getString("route_id") != null && requireArguments().getString("route_id") != "") {
            val routeID = requireArguments().getString("route_id")!!
            routeDetailsVM.getRouteLeaderBoard(routeID)
        } else {
            toast("leaderboard not found")
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }
    }
}