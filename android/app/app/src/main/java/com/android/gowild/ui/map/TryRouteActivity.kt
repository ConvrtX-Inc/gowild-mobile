package com.android.gowild.ui.map

import android.Manifest
import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.content.IntentSender
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.location.Location
import android.location.LocationManager
import android.os.Build
import android.os.Bundle
import android.os.Looper
import android.view.Display
import android.view.Surface
import android.widget.Toast
import androidx.activity.result.IntentSenderRequest
import androidx.activity.result.contract.ActivityResultContracts
import androidx.activity.viewModels
import androidx.annotation.DrawableRes
import androidx.lifecycle.lifecycleScope
import com.android.gowild.R
import com.android.gowild.data.model.routes.CreateLeaderboardRequest
import com.android.gowild.data.model.routes.RouteDataModel
import com.android.gowild.databinding.ActivityTryRouteBinding
import com.android.gowild.networking.Errors
import com.android.gowild.networking.NetworkResult
import com.android.gowild.ui.base.BaseActivity
import com.android.gowild.ui.map.mytrail.AddRoutesFragment
import com.android.gowild.ui.user.dialog.ErrorDialog
import com.android.gowild.utils.compassUtils.Azimuth
import com.android.gowild.utils.compassUtils.DisplayRotation
import com.android.gowild.utils.compassUtils.MathUtils
import com.android.gowild.utils.compassUtils.RotationVector
import com.android.gowild.utils.extension.*
import com.android.gowild.utils.toTime
import com.google.android.gms.common.api.ApiException
import com.google.android.gms.common.api.ResolvableApiException
import com.google.android.gms.location.*
import com.google.android.gms.maps.CameraUpdateFactory
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.model.*
import com.google.gson.Gson
import com.google.maps.android.PolyUtil
import com.google.maps.android.SphericalUtil
import com.permissionx.guolindev.PermissionX
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import timber.log.Timber
import kotlin.math.roundToInt

@AndroidEntryPoint
class TryRouteActivity : BaseActivity(), SensorEventListener {

    lateinit var binding: ActivityTryRouteBinding
    private val tryRouteViewModel: TryRouteVM by viewModels()

    private lateinit var azimuth: Azimuth

    private var lat: Double = 0.0
    private var lng: Double = 0.0

    private var isRouteStarted: Boolean = false
    private var isRouteCompleted: Boolean = false
    private var startTime: Long = 0

    lateinit var mGoogleMap: GoogleMap
    private var startDestination: Marker? = null
    private var endDestination: Marker? = null
    private var routeLine: Polyline? = null
    private val polylineArrayList: ArrayList<LatLng> = ArrayList()
    private lateinit var routeData: RouteDataModel

    var isGPS = false

    lateinit var fusedLocationClient: FusedLocationProviderClient
    private lateinit var mLocationCallback: LocationCallback
    private lateinit var locationRequest: LocationRequest

    private lateinit var sensorManager: SensorManager

    lateinit var navigationMarker: Marker

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityTryRouteBinding.inflate(layoutInflater)
        setContentView(binding.root)
        init()
    }

    fun init() {
        requestPermissionsX()
        initGoogleMap()
        setCallbacks()
        setSensor()
        observeNetworkResponses()
        initializeLocationUpdates()
    }

    private fun observeNetworkResponses() {
        observeGoogleRoutesResponse()
        observeCreateLeaderBoard()
    }

    private fun observeGoogleRoutesResponse() {
        tryRouteViewModel.googleRoutesResponse.observe(this) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    if (response.data!!.status == "OK") {
                        polylineArrayList.clear()
                        polylineArrayList.addAll(PolyUtil.decode(response.data.routes[0].overview_polyline.points))
                        if (routeLine != null) {
                            routeLine!!.remove()
                            routeLine = null
                        }
                        drawPolyline(polylineArrayList)
                    }
                    lifecycleScope.launch {
                        delay(500)
                        getGoogleRoutes()
                    }
                }
                is NetworkResult.Failure -> {
                    lifecycleScope.launch {
                        delay(500)
                        getGoogleRoutes()
                    }
                    response.junkError?.let { junkErrors ->
                        ErrorDialog(mContext, junkErrors.errors!![0].map { it.value }).show()
                    } ?: kotlin.run {
                        binding.root.showBar(response.message ?: "Failure")
                    }
                }
                is NetworkResult.Loading -> {

                }
                is NetworkResult.Error -> {
                    lifecycleScope.launch {
                        delay(500)
                        getGoogleRoutes()
                    }
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


    private fun observeCreateLeaderBoard() {
        tryRouteViewModel.createLeaderBoardResponse.observe(this) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    isRouteCompleted = true
                    toast("Route Completed Successfully")
                    hideProgress()
                    binding.tvRouteDetails.gone()
                    binding.tvRouteTitle.gone()
                    binding.tvCongratulations.visible()
                    binding.btnStartRoute.visible()
                    binding.btnStartRoute.text = "Show my results"

//                    val intent = Intent()
//                    intent.putExtra("route_leader_board", Gson().toJson(response.data!!.data))
//                    if (this.intent.extras != null && this.intent.extras!!.containsKey("route_position")) {
//                        val routePosition = this.intent.extras!!.getInt("route_position", 0)
//                        intent.putExtra("route_position", routePosition)
//                    }
//                    setResult(RESULT_OK, intent)
//                    finish()
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

    private fun setSensor() {
        sensorManager = getSystemService(SENSOR_SERVICE) as SensorManager
    }

    override fun onPause() {
        super.onPause()
        sensorManager.unregisterListener(this)
    }

    override fun onResume() {
        super.onResume()
        sensorManager.registerListener(
            this, sensorManager.getDefaultSensor(Sensor.TYPE_ROTATION_VECTOR),
            SensorManager.SENSOR_DELAY_FASTEST
        )
    }

    private fun setCallbacks() {
        binding.btnStartRoute.setOnClickListener {
            if (isValidData()) {
                isRouteStarted = true
                requestLocationUpdates()
                setNavigationMarker()
                binding.tvRouteDetails.gone()
                binding.btnStartRoute.gone()
                binding.tvRouteTitle.gone()
                startTime = System.currentTimeMillis()
                getGoogleRoutes()
            } else if (isRouteCompleted) {
                startActivity(MapActivity.start(this, "Leaderboard"))
                finish()
            }
        }

        binding.tvRouteDetails.setOnClickListener {
            startActivity(MapActivity.start(this, "RouteDetails", route_id = routeData.id))
            finish()
        }

        binding.ivBack.setOnClickListener {
            onBackPressedDispatcher.onBackPressed()
        }
    }

    private fun getGoogleRoutes() {
        val origin = "$lat,$lng"
        val destination = "${routeData.end.latitude},${routeData.end.longitude}"
        Timber.tag("LOCATION_UPDATED").wtf("origin = $origin")
        Timber.tag("LOCATION_UPDATED").wtf("destination = $destination")
        tryRouteViewModel.getGoogleRoutes(origin, destination)
    }

    private fun isValidData(): Boolean {
        if (isRouteCompleted)
            return false
        val distance = SphericalUtil.computeDistanceBetween(LatLng(lat, lng), LatLng(routeData.start.latitude, routeData.start.longitude))
        if (distance > 50) {
            toast("You are not in the proximity of the starting point of this route.")
            return false
        }
        return true
    }

    private fun setNavigationMarker() {
        val markerOptions =
            MarkerOptions().position(LatLng(lat, lng)).icon(getMarker(applicationContext, R.drawable.ic_navigate_location, height = 50, width = 50))
        navigationMarker = mGoogleMap.addMarker(markerOptions)!!
        navigationMarker.isFlat = true
    }

    private fun updateNavigationMarker() {
        navigationMarker.rotation = azimuth.degrees
        navigationMarker.position = LatLng(lat, lng)
    }

    @SuppressLint("MissingPermission")
    private fun initGoogleMap() {
        binding.mapView.onCreate(null)
        binding.mapView.onResume()
        binding.mapView.getMapAsync { googleMap ->
            mGoogleMap = googleMap
            mGoogleMap.uiSettings.isMapToolbarEnabled = true
            mGoogleMap.uiSettings.isCompassEnabled = false
            setRoute()
        }
    }

    private fun setRoute() {
        val route = intent.extras!!.getString("route")
        routeData = Gson().fromJson(route, RouteDataModel::class.java)

        binding.tvRouteTitle.text = routeData.title
        binding.tvTitle.text = routeData.title

        setPolyLine()

        val origin = LatLng(routeData.start.latitude, routeData.start.longitude)
        val destination = LatLng(routeData.end.latitude, routeData.end.longitude)

        setValues(origin, AddRoutesFragment.DESTINATION.START)
        setValues(destination, AddRoutesFragment.DESTINATION.END)

        animateToRoute(routeData)
    }

    private fun setPolyLine() {
        polylineArrayList.clear()
        try {
            polylineArrayList.addAll(PolyUtil.decode(routeData.route_path))
            drawPolyline(polylineArrayList)
        } catch (e: Exception) {
            Timber.tag("POLYLINE_EXCEPTION").d(e.message.toString())
        }
    }


    private fun drawPolyline(polylineArrayList: ArrayList<LatLng>) {
        routeLine = mGoogleMap.addPolyline(
            PolylineOptions().addAll(
                polylineArrayList
            )
        )
        routeLine!!.color = getAsColor(R.color.orange)
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

    private fun moveCameraWithAnimation(position: LatLng) {
        val cameraPosition: CameraPosition = CameraPosition.Builder()
            .target(position) // Sets the center of the map to Mountain View
            .zoom(19f) // Sets the zoom
            .bearing(azimuth.degrees) // Sets the orientation of the camera to east
            .tilt(65f) // Sets the tilt of the camera to 30 degrees
            .build() // Creates a CameraPosition from the builder



        mGoogleMap.animateCamera(CameraUpdateFactory.newCameraPosition(cameraPosition))
    }

    private fun turnGPSOn() {
        val mLocationSettingsRequest: LocationSettingsRequest
        val mSettingsClient: SettingsClient = LocationServices.getSettingsClient(this)
        val locationManager: LocationManager = getSystemService(Context.LOCATION_SERVICE) as LocationManager
        val locationRequest: LocationRequest = LocationRequest.Builder(1000).build()
        val builder = LocationSettingsRequest.Builder().addLocationRequest(locationRequest)
        mLocationSettingsRequest = builder.build()

        builder.setAlwaysShow(true)

        if (locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER)) {
            requestLocationUpdates()
        } else {
            mSettingsClient.checkLocationSettings(mLocationSettingsRequest).addOnSuccessListener(this) {
                toast("Location Setting ON")
                requestLocationUpdates()
            }.addOnFailureListener(this) { e ->
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

    fun onNewLocation(result: Location?) {
        if (result != null) {
            lat = result.latitude
            lng = result.longitude
            Timber.tag("LOCATION_UPDATED").wtf("location = ${result.latitude} ${result.longitude}")
            if (::mGoogleMap.isInitialized && isRouteStarted) {
                moveCameraWithAnimation(LatLng(result.latitude, result.longitude))
                updateNavigationMarker()
                checkRouteFinished()
            }
        }
    }

    private fun requestLocationUpdates() {
        if (!::fusedLocationClient.isInitialized) {
            initializeLocationUpdates()
        } else {
            try {
                fusedLocationClient.requestLocationUpdates(
                    locationRequest,
                    mLocationCallback, Looper.myLooper()
                )
            } catch (unlikely: SecurityException) {
                toast("GPS not available")
                val e = unlikely
                val message = e.message
                onBackPressedDispatcher.onBackPressed()
            }
        }
    }

    private fun initializeLocationUpdates() {
        Timber.tag("LOCATION_UPDATED").wtf("initialized")
        fusedLocationClient = LocationServices.getFusedLocationProviderClient(this)
        if (!::mLocationCallback.isInitialized)
            mLocationCallback = object : LocationCallback() {
                override fun onLocationResult(locationResult: LocationResult) {
                    super.onLocationResult(locationResult)
                    onNewLocation(locationResult.lastLocation)
                }
            }
        if (!::locationRequest.isInitialized)
            locationRequest = LocationRequest.Builder(Priority.PRIORITY_HIGH_ACCURACY, 1000)
                .setWaitForAccurateLocation(false)
                .setMinUpdateIntervalMillis(100)
                .setMaxUpdateDelayMillis(1000)
                .build()
        requestLocationUpdates()
    }

    private fun checkRouteFinished() {
        val distance = SphericalUtil.computeDistanceBetween(LatLng(lat, lng), LatLng(routeData.end.latitude, routeData.end.longitude))
        var isRouteFinished = false
        if (routeData.distance_meters <= 200 && distance < 5) {
            isRouteFinished = true
        } else if (routeData.distance_meters > 200 && distance < 10) {
            isRouteFinished = true
        }
        if (isRouteFinished) {
            isRouteStarted = false
            tryRouteViewModel.createLeaderboard(CreateLeaderboardRequest(routeData.id, startTime.toTime(), System.currentTimeMillis().toTime()))
        }
    }

    var settingsLauncher = registerForActivityResult(ActivityResultContracts.StartIntentSenderForResult()) { result ->
        if (result.resultCode == Activity.RESULT_OK) {
            isGPS = true
            requestLocationUpdates()
        } else {
            isGPS = false
            toast("Please turn on location services for accurate results")
        }
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

    private fun addMarker(latLng: LatLng, destinationState: AddRoutesFragment.DESTINATION): Marker? {
        return when (destinationState) {
            AddRoutesFragment.DESTINATION.START -> {
                val markerOptions = MarkerOptions().position(latLng).icon(getMarker(applicationContext, R.drawable.ic_start_marker))
                mGoogleMap.addMarker(markerOptions)
            }
            AddRoutesFragment.DESTINATION.END -> {
                val markerOptions = MarkerOptions().position(latLng).icon(getMarker(applicationContext, R.drawable.ic_end_marker))
                mGoogleMap.addMarker(markerOptions)
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

    private fun animateToRoute(data: RouteDataModel) {
        val builder: LatLngBounds.Builder = LatLngBounds.Builder()

        val startLatLng = LatLng(data.start.latitude, data.start.longitude)
        builder.include(startLatLng)
        val endLatLng = LatLng(data.end.latitude, data.end.longitude)
        builder.include(endLatLng)

        mGoogleMap.animateCamera(CameraUpdateFactory.newLatLngBounds(builder.build(), 200), 500, null)
    }

    override fun onSensorChanged(event: SensorEvent?) {
        when (event?.sensor?.type) {
            Sensor.TYPE_ROTATION_VECTOR -> {
                val rotationVector = RotationVector(event.values[0], event.values[1], event.values[2])
                val displayRotation = getDisplayRotation()
                azimuth = MathUtils.calculateAzimuth(rotationVector, displayRotation)
                Timber.tag("ROTATION").wtf("azimuth${azimuth.degrees.roundToInt()}")
            }
        }
    }

    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {

    }

    private fun getDisplayRotation(): DisplayRotation {
        return when (getDisplayCompat()?.rotation) {
            Surface.ROTATION_90 -> DisplayRotation.ROTATION_90
            Surface.ROTATION_180 -> DisplayRotation.ROTATION_180
            Surface.ROTATION_270 -> DisplayRotation.ROTATION_270
            else -> DisplayRotation.ROTATION_0
        }
    }

    private fun getDisplayCompat(): Display? {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            display
        } else {
            windowManager.defaultDisplay
        }
    }

    override fun onDestroy() {
        Timber.tag("LOCATION_UPDATED").wtf("destroyed")
        fusedLocationClient.removeLocationUpdates(mLocationCallback)
        super.onDestroy()
    }
}