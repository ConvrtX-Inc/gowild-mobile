package com.android.gowild.ui.map.treasurewild

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
import android.view.Display
import android.view.Surface
import android.widget.Toast
import androidx.activity.result.IntentSenderRequest
import androidx.activity.result.contract.ActivityResultContracts
import androidx.activity.viewModels
import androidx.annotation.DrawableRes
import com.android.gowild.R
import com.android.gowild.data.model.treasureWild.TreasureWildResponse
import com.android.gowild.databinding.ActivityFindTreasureChestsBinding
import com.android.gowild.networking.Errors
import com.android.gowild.networking.NetworkResult
import com.android.gowild.ui.base.BaseActivity
import com.android.gowild.ui.user.dialog.ErrorDialog
import com.android.gowild.utils.compassUtils.Azimuth
import com.android.gowild.utils.compassUtils.DisplayRotation
import com.android.gowild.utils.compassUtils.MathUtils
import com.android.gowild.utils.compassUtils.RotationVector
import com.android.gowild.utils.extension.*
import com.google.android.gms.common.api.ApiException
import com.google.android.gms.common.api.ResolvableApiException
import com.google.android.gms.location.*
import com.google.android.gms.maps.CameraUpdateFactory
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.model.*
import com.google.gson.Gson
import com.google.maps.android.SphericalUtil
import com.permissionx.guolindev.PermissionX
import dagger.hilt.android.AndroidEntryPoint
import timber.log.Timber
import kotlin.math.roundToInt

@AndroidEntryPoint
class FindTreasureChestsActivity : BaseActivity(), SensorEventListener {

    lateinit var binding: ActivityFindTreasureChestsBinding
    private val findTreasureChestViewModel: FindTreasureChestsVM by viewModels()

    private lateinit var treasure: TreasureWildResponse.TreasureWildListingData

    lateinit var mGoogleMap: GoogleMap

    lateinit var fusedLocationClient: FusedLocationProviderClient
    private lateinit var mLocationCallback: LocationCallback
    private lateinit var locationRequest: LocationRequest
    var isGPS = false
    private var lat: Double = 0.0
    private var lng: Double = 0.0
    lateinit var navigationMarker: Marker

    private lateinit var sensorManager: SensorManager
    private lateinit var azimuth: Azimuth

    var isTreasureFound = false

    var settingsLauncher = registerForActivityResult(ActivityResultContracts.StartIntentSenderForResult()) { result ->
        if (result.resultCode == Activity.RESULT_OK) {
            isGPS = true
            requestLocationUpdates()
        } else {
            isGPS = false
            toast("Please turn on location services for accurate results")
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityFindTreasureChestsBinding.inflate(layoutInflater)
        setContentView(binding.root)
        init()
    }

    fun init() {
        getData()
        requestPermissionsX()
        initGoogleMap()
        setSensor()
        initializeLocationUpdates()
        observeCreateWinnerResponse()
    }

    private fun observeCreateWinnerResponse() {
        findTreasureChestViewModel.createTreasureWildWinnerResponse.observe(this) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    isTreasureFound = true
                    toast("Congratulations! You have found a treasure chest")
                    finish()
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

    private fun getData() {
        val treasure = intent.extras!!.getString("treasure")
        this.treasure = Gson().fromJson(treasure, TreasureWildResponse.TreasureWildListingData::class.java)
    }

    override fun onResume() {
        super.onResume()
        sensorManager.registerListener(
            this, sensorManager.getDefaultSensor(Sensor.TYPE_ROTATION_VECTOR),
            SensorManager.SENSOR_DELAY_FASTEST
        )
    }

    @SuppressLint("MissingPermission")
    private fun initGoogleMap() {
        binding.mapView.onCreate(null)
        binding.mapView.onResume()
        binding.mapView.getMapAsync { googleMap ->
            mGoogleMap = googleMap
            mGoogleMap.uiSettings.isMapToolbarEnabled = true
            mGoogleMap.uiSettings.isCompassEnabled = false
            setNavigationMarker()
        }
    }

    private fun setSensor() {
        sensorManager = getSystemService(SENSOR_SERVICE) as SensorManager
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
            if (::mGoogleMap.isInitialized && !isTreasureFound) {
                moveCameraWithAnimation(LatLng(result.latitude, result.longitude))
                updateNavigationMarker()
                checkTreasureChestFound()
            }
        }
    }

    private fun checkTreasureChestFound() {
        val distance = SphericalUtil.computeDistanceBetween(LatLng(treasure.location.latitude, treasure.location.longitude), LatLng(lat, lng))
        Timber.tag("TREASURE_DISTANCE").wtf(distance.toString())
        if (distance < 50) {
            findTreasureChestViewModel.createTreasureWildWinner(treasure.id)
        }
    }

    private fun moveCameraWithAnimation(position: LatLng) {
        val cameraPosition: CameraPosition = CameraPosition.Builder()
            .target(position) // Sets the center of the map to Mountain View
            .zoom(19f) // Sets the zoom
            .bearing(if (::azimuth.isInitialized) azimuth.degrees else 0f) // Sets the orientation of the camera to east
            .tilt(65f) // Sets the tilt of the camera to 30 degrees
            .build() // Creates a CameraPosition from the builder

        mGoogleMap.animateCamera(CameraUpdateFactory.newCameraPosition(cameraPosition))
    }

    private fun requestLocationUpdates() {
        if (!::fusedLocationClient.isInitialized) {
            initializeLocationUpdates()
        } else {
            try {
                fusedLocationClient.requestLocationUpdates(
                    locationRequest,
                    mLocationCallback,
                    mainLooper
                    /*Looper.myLooper()*/
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

    private fun setNavigationMarker() {
        val markerOptions =
            MarkerOptions().position(LatLng(lat, lng)).icon(getMarker(applicationContext, R.drawable.ic_navigate_location, height = 50, width = 50))
        navigationMarker = mGoogleMap.addMarker(markerOptions)!!
        navigationMarker.isFlat = true
    }

    private fun updateNavigationMarker() {
        navigationMarker.rotation = if (::azimuth.isInitialized) azimuth.degrees else 0f
        navigationMarker.position = LatLng(lat, lng)
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

    override fun onDestroy() {
        Timber.tag("LOCATION_UPDATED").wtf("destroyed")
        fusedLocationClient.removeLocationUpdates(mLocationCallback)
        super.onDestroy()
    }
}