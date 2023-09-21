package com.android.gowild.ui.map.runwild

import android.Manifest
import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.content.Intent
import android.content.IntentSender
import android.location.Location
import android.location.LocationManager
import android.os.Bundle
import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.Toast
import androidx.activity.result.IntentSenderRequest
import androidx.activity.result.contract.ActivityResultContracts
import androidx.fragment.app.viewModels
import androidx.viewbinding.ViewBinding
import com.android.gowild.adapters.HomeAdapter
import com.android.gowild.data.model.homeModels.HomeMapModel
import com.android.gowild.data.model.myTrail.SaveRoutesLeaderboardModel
import com.android.gowild.data.model.myTrail.UnSaveRouteRequestModel
import com.android.gowild.data.model.routes.RouteDataModel
import com.android.gowild.data.model.settings.MyAchievementsDataModel
import com.android.gowild.databinding.FragmentRunWildBinding
import com.android.gowild.dialogs.MapDialog
import com.android.gowild.interfaces.HomeCallback
import com.android.gowild.networking.Errors
import com.android.gowild.networking.NetworkResult
import com.android.gowild.ui.base.BaseFragment
import com.android.gowild.ui.map.MapActivity
import com.android.gowild.ui.map.TryRouteActivityNew
import com.android.gowild.ui.user.dialog.ErrorDialog
import com.android.gowild.utils.RouteSelectorHelper
import com.android.gowild.utils.extension.showBar
import com.android.gowild.utils.extension.toast
import com.android.gowild.utils.local.UserPrefs
import com.google.android.gms.common.api.ApiException
import com.google.android.gms.common.api.ResolvableApiException
import com.google.android.gms.location.*
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.MapsInitializer
import com.google.android.gms.tasks.CancellationTokenSource
import com.google.android.gms.tasks.Task
import com.google.gson.Gson
import com.permissionx.guolindev.PermissionX
import timber.log.Timber

class RunWildFragment : BaseFragment() {

    companion object {
        @JvmStatic
        fun newInstance() = RunWildFragment()
    }

    private lateinit var binding: FragmentRunWildBinding
    private val runWildViewModel: RunWildVM by viewModels()

    var routes: ArrayList<RouteDataModel> = ArrayList()
    var homeMapModel = HomeMapModel()

    private var homeDataList: ArrayList<Any> = ArrayList()
    private lateinit var homeAdapter: HomeAdapter
    private lateinit var homeCallback: HomeCallback

    private var routeSelectorHelper: RouteSelectorHelper = RouteSelectorHelper()

    var userLat: Double = 0.0
    var userLng: Double = 0.0

    lateinit var googleMap: GoogleMap
    private val fusedLocationClient: FusedLocationProviderClient by lazy {
        LocationServices.getFusedLocationProviderClient(requireActivity())
    }
    private var cancellationTokenSource = CancellationTokenSource()
    private var isGPS: Boolean = false

    var mapPosition = -1

    var mapOverlayLauncher = registerForActivityResult(ActivityResultContracts.StartActivityForResult()) { result ->
        if (result.resultCode == Activity.RESULT_OK && result.data != null && result.data!!.extras != null) {
            val mapType = result.data!!.extras!!.getString("map_type")
            Timber.tag("MAP_OVERLAY").wtf("mapOverLayResultHome mapType?${mapType}")
            (homeDataList[0] as HomeMapModel).mapType = mapType!!
            homeAdapter.notifyItemChanged(0, HomeAdapter.HomePayLoads.PAYLOAD_MAP_TYPE_UPDATED)
        }
    }

    var tryRouteResultLauncher = registerForActivityResult(ActivityResultContracts.StartActivityForResult()) { result ->
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
            homeMapModel.routes[routePosition].crr_user_leaderboard = saveRoutesLeaderBoardResponse
            homeAdapter.notifyItemChanged(0, arrayOf(HomeAdapter.HomePayLoads.PAYLOAD_MAP_ROUTE_LEADERBOARD_UPDATED, routePosition))
        }
    }

    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentRunWildBinding.inflate(layoutInflater)
        init()
        return binding
    }

    fun init() {
        initGoogleMaps()
        setObservers()
        setListeners()
        setAdapter()
        runWildViewModel.getApprovedRoutes(userLat, userLng, 1)
    }

    private fun initGoogleMaps() {
        MapsInitializer.initialize(requireContext(), MapsInitializer.Renderer.LATEST) { p0 ->
            Timber.tag("MAP_SDK_ISSUE").wtf(p0.name)
        }
        requestPermissionsX()
    }

    private fun setObservers() {
        setApprovedRoutesObserver()
        observeSaveUnSaveRoute()
    }

    private fun setAdapter() {
        homeAdapter = HomeAdapter(homeDataList, homeCallback, UserPrefs(requireContext()).getUser()!!.id!!)
        homeDataList.add(homeMapModel)
        binding.rvMap.adapter = homeAdapter
    }

    private fun setListeners() {
        binding.backIv.setOnClickListener {
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }
        homeCallback = object : HomeCallback {
            override fun onMapReady(googleMap: GoogleMap) {
                this@RunWildFragment.googleMap = googleMap
                googleMap.uiSettings.isZoomControlsEnabled = false
                googleMap.uiSettings.isMapToolbarEnabled = false
                googleMap.uiSettings.isMyLocationButtonEnabled = true
            }

            override fun onPreviousRoutes() {
                routeSelectorHelper.selectPrevious()
            }

            override fun onNextRoutes() {
                routeSelectorHelper.selectNext()
            }

            override fun onMapClick(route: RouteDataModel) {
                val mapDialog = MapDialog(route)
                mapDialog.show(childFragmentManager, "")
            }

            override fun onSelectRoute(position: Int) {
                Timber.tag("ROUTE_POSITION").wtf("HomeFragment $position")
                routeSelectorHelper.updateSelectedRoute(position)
            }

            override fun onTryRoute(routeDataModel: RouteDataModel, position: Int) {
//                if (routeDataModel.crr_user_leaderboard == null) {
                if (routeDataModel.polyline != null && routeDataModel.polyline != "") {
                    val intent = Intent(requireContext(), TryRouteActivityNew::class.java)
                    intent.putExtra("route", Gson().toJson(routeDataModel))
                    intent.putExtra("position", position)
                    tryRouteResultLauncher.launch(intent)
                } else {
                    toast("Route unavailable")
                }
//                } else {
//                    toast("Route tried already")
//                }
            }

            override fun onRouteDetail(routeDataModel: RouteDataModel) {
                val routeDetailsFragment = RouteDetailsFragmentNew.newInstance()
                val bundle = Bundle()
                bundle.putString("route_id", routeDataModel.id)
                routeDetailsFragment.arguments = bundle
                MapActivity.addFragment(requireActivity(), routeDetailsFragment)
            }

            override fun onSaveUnSaveRoute(routeDataModel: RouteDataModel, position: Int) {
                runWildViewModel.saveUnSaveRoute(UnSaveRouteRequestModel(routeDataModel.id), position)
            }

            override fun onSelectMapOverlay(mapType: String) {
                mapOverlayLauncher.launch(MapActivity.start(requireActivity(), "MapOverlay"))
            }
        }
    }

    private fun setApprovedRoutesObserver() {
        runWildViewModel.approvedRoutesResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    if (response.data?.currentPage == 1) {
                        routeSelectorHelper.setupHelper(homeMapModel, response.data, homeAdapter,0) {
                            runWildViewModel.getApprovedRoutes(userLat, userLng, homeMapModel.apiCurrentPage + 1)
                        }
                    } else {
                        routeSelectorHelper.addMoreRoutes(response.data!!)
                    }
                    homeAdapter.notifyItemChanged(0)
                    hideProgress()
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

    private fun observeSaveUnSaveRoute() {
        runWildViewModel.saveUnSaveRouteResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    homeMapModel.routes[response.extra as Int].saved = response.data!!.data
                    homeAdapter.notifyItemChanged(0)
                    hideProgress()
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


    @SuppressLint("MissingPermission")
    private fun requestPermissionsX() {
        PermissionX.init(this).permissions(Manifest.permission.ACCESS_COARSE_LOCATION, Manifest.permission.ACCESS_FINE_LOCATION)
            .onExplainRequestReason { scope, deniedList ->
                scope.showRequestReasonDialog(deniedList, "Go Wild needs location permission give accurate results", "OK", "Cancel")
            }.onForwardToSettings { scope, deniedList ->
                scope.showForwardToSettingsDialog(deniedList, "You need to allow necessary permissions in Settings manually", "OK", "Cancel")
            }.request { allGranted, grantedList, deniedList ->
                if (allGranted) {
                    turnGPSOn()
                }
            }
    }

    private fun turnGPSOn() {
        val mLocationSettingsRequest: LocationSettingsRequest

        val mSettingsClient: SettingsClient = LocationServices.getSettingsClient(requireActivity())

        val locationManager: LocationManager = requireActivity().getSystemService(Context.LOCATION_SERVICE) as LocationManager
        val locationRequest: LocationRequest = LocationRequest.Builder(1000).build()

        val builder = LocationSettingsRequest.Builder().addLocationRequest(locationRequest)
        mLocationSettingsRequest = builder.build()

        builder.setAlwaysShow(true)

        if (locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER)) {
            requestCurrentLocation()
        } else {
            mSettingsClient.checkLocationSettings(mLocationSettingsRequest).addOnSuccessListener(requireActivity()) {
                toast("Location Setting ON")
                requestCurrentLocation()
            }.addOnFailureListener(requireActivity()) { e ->
                when ((e as ApiException).statusCode) {
                    LocationSettingsStatusCodes.RESOLUTION_REQUIRED -> {
                        try {
                            settingsLauncher.launch(IntentSenderRequest.Builder((e as ResolvableApiException).resolution).build())
                        } catch (cce: ClassCastException) {
                            val status: com.google.android.gms.common.api.Status = e.status

                            val resolvable = ResolvableApiException(status)
                            settingsLauncher.launch(IntentSenderRequest.Builder(resolvable.resolution).build())
                            toast("Location Failure ${cce.message}", Toast.LENGTH_LONG)
                        } catch (sie: IntentSender.SendIntentException) {
                            toast("Unable to turn on settings.")
                        }
                    }

                    LocationSettingsStatusCodes.SETTINGS_CHANGE_UNAVAILABLE -> {
                        val errorMessage = "Location settings are inadequate, and cannot be fixed here. Fix in Settings."
                        toast(errorMessage)
                    }
                }
            }
        }
    }

    @SuppressLint("MissingPermission")
    private fun requestCurrentLocation() {
        val currentLocationTask: Task<Location> = fusedLocationClient.getCurrentLocation(
            Priority.PRIORITY_HIGH_ACCURACY, cancellationTokenSource.token
        )
        currentLocationTask.addOnCompleteListener { task: Task<Location> ->
            if (task.isSuccessful && task.result != null) {
                val result: Location = task.result
                Timber.tag("LOCATION_UPDATED").wtf("${result.latitude} ${result.longitude}")
                if (::googleMap.isInitialized) {
                    googleMap.isMyLocationEnabled = true
                }
            } else {
                val exception = task.exception
            }
        }
    }

    var settingsLauncher = registerForActivityResult(ActivityResultContracts.StartIntentSenderForResult()) { result ->
        if (result.resultCode == Activity.RESULT_OK) {
            isGPS = true
            requestCurrentLocation()
        } else {
            isGPS = false
            toast("Please turn on location services for accurate results")
        }
    }

}