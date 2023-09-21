package com.android.gowild.ui.map.mytrail

import android.Manifest
import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.content.Context.LOCATION_SERVICE
import android.content.IntentSender
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.location.Location
import android.location.LocationManager
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.RelativeLayout
import android.widget.Toast
import androidx.activity.result.IntentSenderRequest
import androidx.activity.result.contract.ActivityResultContracts
import androidx.annotation.DrawableRes
import androidx.fragment.app.viewModels
import androidx.lifecycle.lifecycleScope
import androidx.viewbinding.ViewBinding
import com.android.gowild.R
import com.android.gowild.data.model.googleMapRoutesModel.GoogleRouteModel
import com.android.gowild.data.model.myTrail.AddRoutesRequestModel
import com.android.gowild.data.model.routes.LocationModel
import com.android.gowild.data.model.routes.RouteDataModel
import com.android.gowild.databinding.FragmentAddNewRouteBinding
import com.android.gowild.networking.Errors
import com.android.gowild.networking.NetworkResult
import com.android.gowild.ui.base.BaseFragment
import com.android.gowild.ui.user.dialog.ErrorDialog
import com.android.gowild.utils.extension.*
import com.google.android.gms.common.api.ApiException
import com.google.android.gms.common.api.ResolvableApiException
import com.google.android.gms.location.*
import com.google.android.gms.maps.CameraUpdateFactory
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.model.*
import com.google.android.gms.tasks.CancellationTokenSource
import com.google.android.gms.tasks.Task
import com.google.gson.Gson
import com.google.maps.android.PolyUtil
import com.permissionx.guolindev.PermissionX
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.MultipartBody
import okhttp3.RequestBody.Companion.asRequestBody
import org.apache.commons.io.FileUtils
import timber.log.Timber
import java.io.File
import java.net.URL

class AddRoutesFragment : BaseFragment() {

    companion object {
        @JvmStatic
        fun newInstance() = AddRoutesFragment()
    }

    var zoom: Float = 10f

    private lateinit var binding: FragmentAddNewRouteBinding
    private val addRoutesVM: AddRoutesVM by viewModels()

    lateinit var mGoogleMap: GoogleMap
    private var startDestination: Marker? = null
    private var endDestination: Marker? = null

    private var routeLine: Polyline? = null
    private val polylineArrayList: ArrayList<LatLng> = ArrayList()
    private lateinit var routesData: GoogleRouteModel
    private lateinit var updateRouteData: RouteDataModel
    private lateinit var file: File


    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentAddNewRouteBinding.inflate(layoutInflater)
        init()
        return binding
    }

    private fun init() {
        initGoogleMap()
        setListeners()
        setupObservers()
        requestPermissionsX()
    }

    private fun setupObservers() {
        observeGoogleRoutesResponse()
        observeCreateRoutesResponse()
        observeUpdateRoutesResponse()
        observeDeleteRouteResponse()
        observeUpdateRoutePictureResponse()
    }

    private fun observeUpdateRoutePictureResponse() {
        addRoutesVM.updateRoutePictureResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    hideProgress()
                    if (arguments == null) {
                        toast("Route created successfully")
                    } else {
                        toast("Route updated successfully")
                    }
                    requireActivity().onBackPressedDispatcher.onBackPressed()
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
        addRoutesVM.deleteRouteResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    hideProgress()
                    toast(response.data!!.message)
                    requireActivity().onBackPressedDispatcher.onBackPressed()
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

    private fun observeUpdateRoutesResponse() {
        addRoutesVM.updatedRoutesResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    updateRoutePicture(response.data!!.route)
                    Timber.tag("ROUTE_NULL").wtf("getUpdatedRoutesResponse: ${response.data}")
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

    private fun observeCreateRoutesResponse() {
        addRoutesVM.createRoutesResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    updateRoutePicture(response.data!!.route)
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

    private fun observeGoogleRoutesResponse() {
        addRoutesVM.googleRoutesResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    hideProgress()
                    if (response.data!!.status == "OK") {
                        polylineArrayList.addAll(PolyUtil.decode(response.data.routes[0].overview_polyline.points))
                        drawPolyline()
                        routeLine!!.color = getAsColor(R.color.orange)
                        routesData = response.data.routes[0]
                    }
                }
                is NetworkResult.Failure -> {
                    routeLine = null
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
                    routeLine = null
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

    private fun updateRoutePicture(response: RouteDataModel) {
        lifecycleScope.launch {
            withContext(Dispatchers.IO) {
                Timber.tag("ROUTE_NULL").wtf("updateRoutePicture: ${response.route_path}")
                file = File(requireActivity().getExternalFilesDir(null), "image.png")
                FileUtils.copyURLToFile(URL(getGoogleMapStaticURL(response.route_path!!)), file)
                Timber.tag("ROUTE_NULL").wtf("updateRoutePicture: ${response.route_path}")
                addRoutesVM.updateRoutePicture(
                    response.id, MultipartBody.Part.createFormData(
                        "file", file.name, file.asRequestBody("image/*".toMediaType())
                    )
                )
            }
        }
    }

    enum class DESTINATION {
        START, END;
    }

    private fun setListeners() {
        binding.ivBack.setOnClickListener {
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }

        binding.ivZoomPlus.setOnClickListener {
            updateZoom(++zoom)
        }

        binding.ivZoomMinus.setOnClickListener {
            updateZoom(--zoom)
        }

        binding.ivStartMarker.setOnClickListener {
            val latLng = LatLng(startDestination!!.position.latitude, startDestination!!.position.longitude)
            animateCamera(latLng)
        }

        binding.ivEndMarker.setOnClickListener {
            val latLng = LatLng(endDestination!!.position.latitude, endDestination!!.position.longitude)
            animateCamera(latLng)
        }

        binding.btnSubmit.setOnClickListener {
            if (arguments == null) {
                if (validateFields()) {
                    Timber.tag("ROUTE_NULL").wtf("validateFields() ${routesData.overview_polyline.points}")
                    addRoutesVM.createRoutes(
                        AddRoutesRequestModel(
                            binding.etRouteName.text.toString(),
                            routesData.legs[0].distance.value,
                            routesData.legs[0].distance.value * 0.000621371,
                            LocationModel(routesData.legs[0].end_location.latitude, routesData.legs[0].end_location.longitude),
                            routesData.legs[0].duration.text,
                            routesData.overview_polyline.points,
                            LocationModel(routesData.legs[0].start_location.latitude, routesData.legs[0].start_location.longitude),
                            binding.etRouteName.text.toString(),
                            routesData.legs[0].start_address,
                            routesData.legs[0].end_address,
                        )
                    )
                }
            } else if (arguments != null) {
                if (::routesData.isInitialized && validateFields()) {
                    Timber.tag("ROUTE_NULL").wtf("::routesData.isInitialized && validateFields() ${routesData.overview_polyline.points}")
                    addRoutesVM.updateCreatedRoute(
                        updateRouteData.id, AddRoutesRequestModel(
                            binding.etRouteName.text.toString(),
                            routesData.legs[0].distance.value,
                            routesData.legs[0].distance.value * 0.000621371,
                            LocationModel(routesData.legs[0].end_location.latitude, routesData.legs[0].end_location.longitude),
                            routesData.legs[0].duration.text,
                            routesData.overview_polyline.points,
                            LocationModel(routesData.legs[0].start_location.longitude, routesData.legs[0].start_location.longitude),
                            binding.etRouteName.text.toString(),
                            routesData.legs[0].start_address,
                            routesData.legs[0].end_address,
                        )
                    )
                } else {
                    if (validateFields() && binding.etRouteName.text.toString() != updateRouteData.title) {
                        Timber.tag("ROUTE_NULL")
                            .wtf("validateFields() && binding.etRouteName.text.toString() != updateRouteData.title ${updateRouteData.route_path}")
                        addRoutesVM.updateCreatedRoute(
                            updateRouteData.id, AddRoutesRequestModel(
                                binding.etRouteName.text.toString(),
                                updateRouteData.distance_meters,
                                updateRouteData.distance_miles,
                                LocationModel(updateRouteData.end.latitude, updateRouteData.end.longitude),
                                updateRouteData.estimate_time,
                                updateRouteData.route_path,
                                LocationModel(updateRouteData.start.latitude, updateRouteData.start.longitude),
                                binding.etRouteName.text.toString(),
                                updateRouteData.startLocation,
                                updateRouteData.endLocation,
                            )
                        )
                    } else {
                        toast("Noting to update")
                    }
                }
            }
        }

        binding.ivDelete.setOnClickListener {
            if (arguments != null) {
                addRoutesVM.deleteCreatedRoute(updateRouteData.id)
            }
        }

    }

    private fun validateFields(): Boolean {
        if (binding.etRouteName.text.toString().isEmpty()) {
            binding.etRouteName.error = "Route name cannot be empty"
            toast("Route name cannot be empty")
            return false
        }
        if (startDestination == null) {
            toast("Starting point cannot be empty")
            return false
        }
        if (endDestination == null) {
            toast("Ending point cannot be empty")
            return false
        }
        if (routeLine == null) {
            toast("Route cannot be empty")
            return false
        }
        return true
    }

    private fun animateCamera(position: LatLng, zoom: Float = 15f) {
        val updateCamera = CameraUpdateFactory.newLatLngZoom(position, zoom)
        mGoogleMap.animateCamera(updateCamera)
    }


    @SuppressLint("MissingPermission")
    private fun initGoogleMap() {
        binding.mapView.onCreate(null)
        binding.mapView.onResume()
        binding.mapView.getMapAsync { googleMap ->
            mGoogleMap = googleMap
            onMapClickListener(googleMap)
            onMarkerClickListener(googleMap)
            onCameraMoveListener(googleMap)
            mGoogleMap.uiSettings.isMapToolbarEnabled = false
            adjustLocationBtn()
            getData()
        }
    }

    private fun onCameraMoveListener(googleMap: GoogleMap) {
        googleMap.setOnCameraMoveListener {
            zoom = googleMap.cameraPosition.zoom
        }
    }

    private fun getData() {
        if (arguments != null) {
            val route = requireArguments().getString("route")
            updateRouteData = Gson().fromJson(route, RouteDataModel::class.java)

            binding.etRouteName.setText(updateRouteData.title)
            binding.tvTitle.text = updateRouteData.title
            binding.btnSubmit.text = "Update"
            binding.ivDelete.visible()

            polylineArrayList.clear()
            try {
                polylineArrayList.addAll(PolyUtil.decode(updateRouteData.route_path))
            } catch (e: Exception) {
                Timber.tag("TAG").d(e.message.toString())
            }

            val origin = LatLng(updateRouteData.start.latitude, updateRouteData.start.longitude)
            val destination = LatLng(updateRouteData.end.latitude, updateRouteData.end.longitude)

            setValues(origin, DESTINATION.START)
            setValues(destination, DESTINATION.END)
            drawPolyline()
            routeLine!!.color = getAsColor(R.color.green)
        }
    }

    private fun adjustLocationBtn() {
        val locationButton: ImageView = (binding.mapView.findViewById<View>("1".toInt()).parent as View).findViewById<View>("2".toInt()) as ImageView

        locationButton.elevation = 5f
        val layoutParams = locationButton.layoutParams as RelativeLayout.LayoutParams

        layoutParams.addRule(RelativeLayout.ALIGN_PARENT_TOP, 0)
        layoutParams.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM, RelativeLayout.TRUE)
        layoutParams.addRule(RelativeLayout.ALIGN_PARENT_END, RelativeLayout.TRUE)
        layoutParams.setMargins(0, 0, 50, 50)
    }

    @SuppressLint("PotentialBehaviorOverride")
    private fun onMarkerClickListener(googleMap: GoogleMap) {
        googleMap.setOnMarkerClickListener { marker ->
            when (marker) {
                startDestination -> {
                    setValues(null, DESTINATION.START)
                }
                endDestination -> {
                    setValues(null, DESTINATION.END)
                }
            }
            if (routeLine != null) {
                routeLine!!.remove()
                routeLine = null
                polylineArrayList.clear()
            }
            marker.remove()
            false
        }
    }

    private fun onMapClickListener(googleMap: GoogleMap) {
        googleMap.setOnMapClickListener { latLng ->
            if (startDestination == null) {
                setValues(latLng, DESTINATION.START)
            } else if (endDestination == null) {
                setValues(latLng, DESTINATION.END)
            }
            if (startDestination != null && endDestination != null && routeLine == null) {
                val origin: String = startDestination!!.position.latitude.toString() + "," + startDestination!!.position.longitude.toString()
                val destination: String = endDestination!!.position.latitude.toString() + "," + endDestination!!.position.longitude.toString()
                addRoutesVM.getGoogleRoutes(origin, destination)
            }
        }
    }

    private fun setValues(latLng: LatLng?, destinationState: DESTINATION) {
        when (destinationState) {
            DESTINATION.START -> {
                if (latLng != null) {
                    startDestination = addMarker(latLng, DESTINATION.START)
                    binding.tvStartLat.text = latLng.latitude.toString()
                    binding.tvStartLong.text = latLng.longitude.toString()
                    binding.ivStartMarker.visible()
                    animateCamera(latLng)
                } else {
                    binding.tvStartLat.text = ""
                    binding.tvStartLong.text = ""
                    startDestination = null
                    binding.ivStartMarker.gone()
                }
            }
            DESTINATION.END -> {
                if (latLng != null) {
                    endDestination = addMarker(latLng, DESTINATION.END)
                    binding.tvEndLat.text = latLng.latitude.toString()
                    binding.tvEndLong.text = latLng.longitude.toString()
                    binding.ivEndMarker.visible()
                    animateCamera(latLng)
                } else {
                    binding.tvEndLat.text = ""
                    binding.tvEndLong.text = ""
                    endDestination = null
                    binding.ivEndMarker.gone()
                }
            }
        }
    }

    fun addMarker(latLng: LatLng, destinationState: DESTINATION, googleMap: GoogleMap = mGoogleMap): Marker? {
        return when (destinationState) {
            DESTINATION.START -> {
                val markerOptions = MarkerOptions().position(latLng).icon(getMarker(requireContext(), R.drawable.ic_start_marker))
                googleMap.addMarker(markerOptions)
            }
            DESTINATION.END -> {
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

    private var cancellationTokenSource = CancellationTokenSource()
    var isGPS = false
    private val fusedLocationClient: FusedLocationProviderClient by lazy {
        LocationServices.getFusedLocationProviderClient(requireActivity())
    }

    private fun turnGPSOn() {
        val mLocationSettingsRequest: LocationSettingsRequest

        val mSettingsClient: SettingsClient = LocationServices.getSettingsClient(requireActivity())

        val locationManager: LocationManager = requireActivity().getSystemService(LOCATION_SERVICE) as LocationManager
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
                animateCamera(LatLng(result.latitude, result.longitude))
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

    private fun updateZoom(zoomLevel: Float) {
        if (::mGoogleMap.isInitialized)
            mGoogleMap.animateCamera(CameraUpdateFactory.zoomTo(zoomLevel))
    }
}