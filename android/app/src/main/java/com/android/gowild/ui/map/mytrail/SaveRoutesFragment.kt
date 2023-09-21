package com.android.gowild.ui.map.mytrail

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.activity.result.contract.ActivityResultContracts
import androidx.fragment.app.viewModels
import androidx.viewbinding.ViewBinding
import com.android.gowild.R
import com.android.gowild.adapters.HomeAdapter
import com.android.gowild.data.model.myTrail.SaveRoutesDataModel
import com.android.gowild.data.model.myTrail.SaveRoutesLeaderboardModel
import com.android.gowild.data.model.myTrail.UnSaveRouteRequestModel
import com.android.gowild.data.model.routes.RouteDataModel
import com.android.gowild.data.model.settings.MyAchievementsDataModel
import com.android.gowild.databinding.FragmentSaveRoutesBinding
import com.android.gowild.interfaces.CreatedRoutesCallback
import com.android.gowild.interfaces.UnSaveRouteCallback
import com.android.gowild.networking.Errors
import com.android.gowild.networking.NetworkResult
import com.android.gowild.ui.base.BaseFragment
import com.android.gowild.ui.base.BindingRecyclerAdapter
import com.android.gowild.ui.map.MapActivity
import com.android.gowild.ui.map.TryRouteActivityNew
import com.android.gowild.ui.map.runwild.RouteDetailsFragmentNew
import com.android.gowild.ui.user.dialog.ErrorDialog
import com.android.gowild.utils.extension.getAsColor
import com.android.gowild.utils.extension.setRecyclerViewAdapter
import com.android.gowild.utils.extension.shareText
import com.android.gowild.utils.extension.showBar
import com.android.gowild.utils.extension.toast
import com.google.gson.Gson

class SaveRoutesFragment : BaseFragment() {

    companion object {
        @JvmStatic
        fun newInstance() = SaveRoutesFragment()
    }

    private lateinit var binding: FragmentSaveRoutesBinding
    private val saveRoutesVM: SaveRoutesVM by viewModels()

    private lateinit var createdRoutesAdapter: BindingRecyclerAdapter<RouteDataModel, CreatedRoutesCallback>
    private lateinit var savedRoutesAdapter: BindingRecyclerAdapter<SaveRoutesDataModel, UnSaveRouteCallback>

    val savedRoutesList: ArrayList<SaveRoutesDataModel> = ArrayList()
    val createdRoutesList: ArrayList<RouteDataModel> = ArrayList()

    var createdTryRouteResultLauncher = registerForActivityResult(ActivityResultContracts.StartActivityForResult()) { result ->
        if (result.resultCode == Activity.RESULT_OK && result.data != null) {
            val routeCompleted: MyAchievementsDataModel =
                Gson().fromJson(result.data!!.getStringExtra("route_leader_board"), MyAchievementsDataModel::class.java)
            val routePosition = result.data!!.getIntExtra("route_position", 0)
            val saveRoutesLeaderBoardResponse = SaveRoutesLeaderboardModel(
                routeCompleted.route_id,
                userPrefs.getUser()!!.picture,
                userPrefs.getUser()!!.firstName + " " + userPrefs.getUser()!!.lastName,
                userPrefs.getUser()!!.id!!
            )
            // TODO: send payload with route position check how to do this
            if (createdRoutesList[routePosition].leaderboard == null) {
                createdRoutesList[routePosition].leaderboard = ArrayList()
            }
            createdRoutesList[routePosition].leaderboard!!.add(saveRoutesLeaderBoardResponse)

            createdRoutesAdapter.notifyItemChanged(routePosition, arrayOf(HomeAdapter.HomePayLoads.PAYLOAD_FEED_UPDATE_USER_IMAGE, routePosition))
        }
    }

    var savedTryRouteResultLauncher = registerForActivityResult(ActivityResultContracts.StartActivityForResult()) { result ->
        if (result.resultCode == Activity.RESULT_OK && result.data != null) {
            val routeCompleted: MyAchievementsDataModel =
                Gson().fromJson(result.data!!.getStringExtra("route_leader_board"), MyAchievementsDataModel::class.java)
            val routePosition = result.data!!.getIntExtra("route_position", 0)
            val saveRoutesLeaderBoardResponse = SaveRoutesLeaderboardModel(
                routeCompleted.route_id,
                userPrefs.getUser()!!.picture,
                userPrefs.getUser()!!.firstName + " " + userPrefs.getUser()!!.lastName,
                userPrefs.getUser()!!.id!!
            )
            if (createdRoutesList[routePosition].leaderboard == null) {
                createdRoutesList[routePosition].leaderboard = ArrayList()
            }
            createdRoutesList[routePosition].leaderboard!!.add(saveRoutesLeaderBoardResponse)
            savedRoutesAdapter.notifyItemChanged(routePosition, arrayOf(HomeAdapter.HomePayLoads.PAYLOAD_FEED_UPDATE_USER_IMAGE, routePosition))
        }
    }

    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentSaveRoutesBinding.inflate(layoutInflater)
        init()
        return binding
    }

    private fun init() {
        getRoutes()
        setListeners()
        setupObservers()
        setAdapters()
    }

    private fun setAdapters() {
        savedRoutesAdapter = binding.rvSaveRoutes.setRecyclerViewAdapter(
            R.layout.list_item_saved_routes,
            savedRoutesList,
            userPrefs.getUser()!!.id,
            listener = object : UnSaveRouteCallback {
                override fun onUnSaveRoute(route_id: String, position: Int) {
                    saveRoutesVM.unSaveRoutes(UnSaveRouteRequestModel(route_id))
                    savedRoutesList.removeAt(position)
                }

                override fun openDetailsFragment(route_id: String) {
//                    val routeDetailsFragment = RouteDetailsFragment.newInstance()
                    val routeDetailsFragment = RouteDetailsFragmentNew.newInstance()
                    val bundle = Bundle()
                    bundle.putString("route_id", route_id)
                    routeDetailsFragment.arguments = bundle
                    MapActivity.replaceFragment(requireActivity(), routeDetailsFragment)
                }

                override fun onTryRoute(route: RouteDataModel, position: Int) {
//                    if (route.leaderboard != null && route.leaderboard!!.firstOrNull { it.user_id == userPrefs.getUser()!!.id } != null) {
//                        if (route.route_path != null && route.route_path != "") {
                    val intent = Intent(requireContext(), TryRouteActivityNew::class.java)
                    intent.putExtra("route", Gson().toJson(route))
                    intent.putExtra("position", position)
                    savedTryRouteResultLauncher.launch(intent)
//                        } else {
//                            toast("Route unavailable")
//                        }
//                    } else {
//                        toast("Route tried already")
//                    }
                }
            }
        )
        createdRoutesAdapter = binding.rvCreatedRoutes.setRecyclerViewAdapter(
            R.layout.list_item_created_route,
            createdRoutesList,
            null,
            listener = object : CreatedRoutesCallback {
                override fun onEdit(route: RouteDataModel, position: Int) {
                    val addRoutesFragment = AddRoutesFragment.newInstance()
                    val bundle = Bundle()
                    bundle.putString("route", Gson().toJson(route))
                    addRoutesFragment.arguments = bundle
                    MapActivity.replaceFragment(requireActivity(), addRoutesFragment)
                }

                override fun onDelete(route: RouteDataModel, position: Int) {
                    saveRoutesVM.deleteCreatedRoute(route.id)
                    createdRoutesList.removeAt(position)
                }

                override fun openDetailsFragment(route_id: String) {
//                    val routeDetailsFragment = RouteDetailsFragment.newInstance()
                    val routeDetailsFragment = RouteDetailsFragmentNew.newInstance()
                    val bundle = Bundle()
                    bundle.putString("route_id", route_id)
                    routeDetailsFragment.arguments = bundle
                    MapActivity.replaceFragment(requireActivity(), routeDetailsFragment)
                }

                override fun onShareRoute(route_id: String) {
                    shareText(desc = "Check out this route at Go-Wild-History\n https://gowild.appscorridor.com/route?routeID=$route_id")
                }

                override fun onTryRoute(route: RouteDataModel, position: Int) {
//                    if (route.leaderboard != null && route.leaderboard!!.firstOrNull { it.user_id == userPrefs.getUser()!!.id } != null) {
//                        if (route.route_path != null && route.route_path != "") {
                    val intent = Intent(requireContext(), TryRouteActivityNew::class.java)
                    intent.putExtra("route", Gson().toJson(route))
                    intent.putExtra("position", position)
                    createdTryRouteResultLauncher.launch(intent)
//                        } else {
//                            toast("Route unavailable")
//                        }
//                    } else {
//                        toast("Route tried already")
//                    }
                }
            }
        )
    }

    private fun getRoutes() {
        saveRoutesVM.getSaveRoutes()
        saveRoutesVM.getCreatedRoutes()
    }

    private fun setListeners() {
        binding.btnSaveRoutes.setOnClickListener {
            binding.btnSaveRoutes.setTextColor(getAsColor(R.color.white))
            binding.btnSaveRoutes.setBackgroundResource(R.drawable.tab_left_active_bg)
            binding.btnCreatedRoutes.setTextColor(getAsColor(R.color.gold_orange))
            binding.btnCreatedRoutes.setBackgroundResource(R.drawable.tab_right_off_bg)

            binding.rvSaveRoutes.visibility = View.VISIBLE
            binding.rvCreatedRoutes.visibility = View.GONE
        }

        binding.btnCreatedRoutes.setOnClickListener {
            binding.btnCreatedRoutes.setTextColor(resources.getColor(R.color.white))
            binding.btnCreatedRoutes.setBackgroundResource(R.drawable.tab_right_active_bg)
            binding.btnSaveRoutes.setTextColor(resources.getColor(R.color.gold_orange))
            binding.btnSaveRoutes.setBackgroundResource(R.drawable.tab_left_off_bg)

            binding.rvSaveRoutes.visibility = View.GONE
            binding.rvCreatedRoutes.visibility = View.VISIBLE
        }

        binding.ivAddNewRoute.setOnClickListener {
            activity?.let { it1 ->
                MapActivity.replaceFragment(it1, AddRoutesFragment.newInstance())
            }
        }

        binding.backIv.setOnClickListener {
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }
    }

    private fun setupObservers() {
        observeSavedRoutesResponse()
        observeCreatedRoutesResponse()
        observeDeleteRouteResponse()
        observeUnSaveRouteResponse()
    }

    private fun observeUnSaveRouteResponse() {
        saveRoutesVM.getUnSaveRouteResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    hideProgress()
                    toast(response.data!!.message)
                    savedRoutesAdapter.notifyDataSetChanged()
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

    private fun observeDeleteRouteResponse() {
        saveRoutesVM.getDeleteRouteResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    hideProgress()
                    toast(response.data!!.message)
                    createdRoutesAdapter.notifyDataSetChanged()
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

    private fun observeCreatedRoutesResponse() {
        saveRoutesVM.getCreatedRoutesResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    hideProgress()
                    createdRoutesList.clear()
                    createdRoutesList.addAll(response.data!!.data)
                    createdRoutesAdapter.notifyDataSetChanged()
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

    private fun observeSavedRoutesResponse() {
        saveRoutesVM.getSaveRoutesResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    hideProgress()
                    savedRoutesList.clear()
                    savedRoutesList.addAll(response.data!!.data)
                    savedRoutesAdapter.notifyDataSetChanged()
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