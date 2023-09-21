package com.android.gowild.ui.map.runwild

import android.Manifest
import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.content.IntentSender
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.location.Location
import android.location.LocationManager
import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.Toast
import androidx.activity.result.IntentSenderRequest
import androidx.activity.result.contract.ActivityResultContracts
import androidx.annotation.DrawableRes
import androidx.fragment.app.viewModels
import androidx.viewbinding.ViewBinding
import com.android.gowild.R
import com.android.gowild.data.model.routes.RouteDataModel
import com.android.gowild.databinding.FragmentRouteDetailsBinding
import com.android.gowild.networking.Errors
import com.android.gowild.networking.NetworkResult
import com.android.gowild.ui.base.BaseFragment
import com.android.gowild.ui.map.MapActivity
import com.android.gowild.ui.map.mytrail.AddRoutesFragment
import com.android.gowild.ui.user.dialog.ErrorDialog
import com.android.gowild.utils.extension.*
import com.google.android.gms.common.api.ApiException
import com.google.android.gms.common.api.ResolvableApiException
import com.google.android.gms.location.*
import com.google.android.gms.maps.CameraUpdateFactory
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.MapsInitializer
import com.google.android.gms.maps.model.*
import com.google.android.gms.tasks.CancellationTokenSource
import com.google.android.gms.tasks.Task
import com.google.maps.android.PolyUtil
import com.permissionx.guolindev.PermissionX
import timber.log.Timber
import java.math.RoundingMode

class RouteDetailsFragment : BaseFragment() {

    companion object {
        @JvmStatic
        fun newInstance() = RouteDetailsFragment()
    }

    private lateinit var binding: FragmentRouteDetailsBinding
    private val routeDetailsVM: RouteDetailsVM by viewModels()

    private lateinit var routeData: RouteDataModel

    private lateinit var mGoogleMap: GoogleMap

    private var startDestination: Marker? = null
    private var endDestination: Marker? = null

    private var routeLine: Polyline? = null
    private val polylineArrayList: ArrayList<LatLng> = ArrayList()

    private var cancellationTokenSource = CancellationTokenSource()
    var isGPS = false
    private val fusedLocationClient: FusedLocationProviderClient by lazy {
        LocationServices.getFusedLocationProviderClient(requireActivity())
    }

    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentRouteDetailsBinding.inflate(layoutInflater)
        init()
        return binding
    }

    private fun init() {
        setUpMap()
        getRouteId()
        setupListener()
        setupObserver()
        requestPermissionsX()
    }

    @SuppressLint("MissingPermission")
    private fun setUpMap() {
        MapsInitializer.initialize(requireContext())
        binding.mapView.onCreate(null)
        binding.mapView.onResume()
        binding.mapView.getMapAsync { googleMap ->
            mGoogleMap = googleMap
            if (isGPS)
                googleMap.isMyLocationEnabled = true
        }
    }

    private fun getRouteId() {
        if (arguments != null) {
            val routeID = requireArguments().getString("route_id")
            Timber.tag("GW_INTENT").wtf("getRouteId $routeID")
            routeDetailsVM.getRouteDetail(routeID.toString())
        } else {
            toast("Route not found")
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }
    }

    private fun setupListener() {
        binding.btnLeaderBoard.setOnClickListener {
            requireActivity().startActivity(MapActivity.start(requireActivity(), "Leaderboard", route_id = routeData.id))
        }

        binding.ivBack.setOnClickListener {
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }
    }

    private fun setupObserver() {
        routeDetailsVM.routeDetailsResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    hideProgress()
                    binding.parentLayout.visible()
                    routeData = response.data!!.data
                    showData(routeData)
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

    private fun showData(data: RouteDataModel) {
        binding.tvTitle.text = data.title
        binding.tvRouteName.text = data.title
        val roundedDistance = data.distance_miles.toBigDecimal().setScale(2, RoundingMode.UP).toDouble()
        binding.tvDistanceValue.text = "$roundedDistance Miles"
        setMapData()
    }

    private fun setMapData() {
        polylineArrayList.clear()
        try {
            polylineArrayList.addAll(PolyUtil.decode(routeData.route_path))
        } catch (e: Exception) {
            Timber.tag("TAG").d(e.message.toString())
        }

        val origin = LatLng(routeData.start.latitude, routeData.start.longitude)
        val destination = LatLng(routeData.end.latitude, routeData.end.longitude)

        setValues(origin, AddRoutesFragment.DESTINATION.START)
        setValues(destination, AddRoutesFragment.DESTINATION.END)
        drawPolyline()
        routeLine!!.color = getAsColor(R.color.green)
        animateToRoute(routeData)
    }

    private fun animateToRoute(data: RouteDataModel) {
        val builder: LatLngBounds.Builder = LatLngBounds.Builder()

        val startLatLng = LatLng(data.start.latitude, data.start.longitude)
        builder.include(startLatLng)
        val endLatLng = LatLng(data.end.latitude, data.end.longitude)
        builder.include(endLatLng)

        mGoogleMap.animateCamera(CameraUpdateFactory.newLatLngBounds(builder.build(), 200), 500, null)
    }


    private fun setValues(latLng: LatLng, destinationState: AddRoutesFragment.DESTINATION) {
        when (destinationState) {
            AddRoutesFragment.DESTINATION.START -> {
                startDestination = addMarker(latLng, AddRoutesFragment.DESTINATION.START)
            }
            AddRoutesFragment.DESTINATION.END -> {
                endDestination = addMarker(latLng, AddRoutesFragment.DESTINATION.END)
            }
        }
    }

    fun addMarker(latLng: LatLng, destinationState: AddRoutesFragment.DESTINATION, googleMap: GoogleMap = mGoogleMap): Marker? {
        return when (destinationState) {
            AddRoutesFragment.DESTINATION.START -> {
                val markerOptions = MarkerOptions().position(latLng).icon(getMarker(requireContext(), R.drawable.ic_start_marker))
                googleMap.addMarker(markerOptions)
            }
            AddRoutesFragment.DESTINATION.END -> {
                val markerOptions = MarkerOptions().position(latLng).icon(getMarker(requireContext(), R.drawable.ic_end_marker))
                googleMap.addMarker(markerOptions)
            }
        }
    }

    private fun getMarker(context: Context, @DrawableRes drawableRes: Int, height: Int = 30, width: Int = 25): BitmapDescriptor {
        return BitmapDescriptorFactory.fromBitmap(
            Bitmap.createScaledBitmap(
                BitmapFactory.decodeResource(
                    context.resources, drawableRes
                ), width.dp, height.dp, false
            )
        )
    }

    private fun drawPolyline() {
        routeLine = mGoogleMap.addPolyline(
            PolylineOptions().addAll(
                polylineArrayList
            )
        )
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
                if (::mGoogleMap.isInitialized) mGoogleMap.isMyLocationEnabled = true

            } else {
//                val exception = task.exception
            }
        }
    }

    private var settingsLauncher = registerForActivityResult(ActivityResultContracts.StartIntentSenderForResult()) { result ->
        if (result.resultCode == Activity.RESULT_OK) {
            isGPS = true
            requestCurrentLocation()
        } else {
            isGPS = false
            toast("Please turn on location services for accurate results")
        }
    }
}