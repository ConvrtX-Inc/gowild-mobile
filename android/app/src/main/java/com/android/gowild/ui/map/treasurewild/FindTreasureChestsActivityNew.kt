package com.android.gowild.ui.map.treasurewild

import android.os.Bundle
import androidx.activity.viewModels
import androidx.appcompat.content.res.AppCompatResources
import com.android.gowild.R
import com.android.gowild.data.model.treasureWild.TreasureWildResponse
import com.android.gowild.databinding.ActivityFindTreasureChestsNewBinding
import com.android.gowild.networking.Errors
import com.android.gowild.networking.NetworkResult
import com.android.gowild.ui.base.BaseActivity
import com.android.gowild.ui.user.dialog.ErrorDialog
import com.android.gowild.utils.extension.showBar
import com.android.gowild.utils.extension.toast
import com.android.gowild.utils.helper.LocationPermissionHelper
import com.android.gowild.utils.mapboxUtils.CustomLocationProvider
import com.google.gson.Gson
import com.mapbox.geojson.Point
import com.mapbox.maps.CameraOptions
import com.mapbox.maps.EdgeInsets
import com.mapbox.maps.extension.style.expressions.dsl.generated.interpolate
import com.mapbox.maps.plugin.LocationPuck2D
import com.mapbox.maps.plugin.gestures.gestures
import com.mapbox.maps.plugin.locationcomponent.OnIndicatorBearingChangedListener
import com.mapbox.maps.plugin.locationcomponent.OnIndicatorPositionChangedListener
import com.mapbox.maps.plugin.locationcomponent.location
import com.mapbox.turf.TurfConstants
import com.mapbox.turf.TurfMeasurement
import dagger.hilt.android.AndroidEntryPoint
import timber.log.Timber
import java.lang.ref.WeakReference

@AndroidEntryPoint
class FindTreasureChestsActivityNew : BaseActivity() {

    lateinit var binding: ActivityFindTreasureChestsNewBinding
    private val findTreasureChestViewModel: FindTreasureChestsVM by viewModels()

    private lateinit var treasure: TreasureWildResponse.TreasureWildListingData

    private lateinit var locationPermissionHelper: LocationPermissionHelper
    private lateinit var currentLocation: Point

    var isTreasureFound = false
    var isLocationFound = false

    private val onIndicatorBearingChangedListener = OnIndicatorBearingChangedListener {
        binding.mapView.getMapboxMap().setCamera(CameraOptions.Builder().bearing(it).build())
    }

    private val onIndicatorPositionChangedListener = OnIndicatorPositionChangedListener {
        currentLocation = it
        if (!isLocationFound) {
            isLocationFound = true
            setDefaultCameraAngle()
        }
        binding.mapView.getMapboxMap().setCamera(CameraOptions.Builder().center(it).build())
        binding.mapView.gestures.focalPoint = binding.mapView.getMapboxMap().pixelForCoordinate(it)
        checkTreasureChestFound()
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityFindTreasureChestsNewBinding.inflate(layoutInflater)
        setContentView(binding.root)
        init()
    }

    fun init() {
        setPermissions()
        setTreasureData()
        observeCreateWinnerResponse()
    }

    private fun setDefaultCameraAngle() {
        val cameraPosition = binding.mapView.getMapboxMap().cameraForCoordinates(
            listOf(currentLocation),
            EdgeInsets(
                -100.0,
                -100.0,
                -100.0,
                -100.0,
            )
        )
        binding.mapView.getMapboxMap().setCamera(cameraPosition)
        binding.mapView.getMapboxMap().setCamera(CameraOptions.Builder().zoom(17.5).pitch(45.0).build())
    }

    private fun setTreasureData() {
        val data = intent.extras!!.getString("treasure")
        treasure = Gson().fromJson(data, TreasureWildResponse.TreasureWildListingData::class.java)
        Timber.tag("Treasure").wtf(Gson().newBuilder().setPrettyPrinting().create().toJson(treasure))
    }

    private fun setPermissions() {
        locationPermissionHelper = LocationPermissionHelper(WeakReference(this))
        locationPermissionHelper.checkPermissions {
            initLocationComponent()
        }
    }

    private fun initLocationComponent() {
        val locationComponentPlugin = binding.mapView.location
        locationComponentPlugin.setLocationProvider(CustomLocationProvider(applicationContext))
        locationComponentPlugin.updateSettings {
            this.enabled = true
            this.locationPuck = LocationPuck2D(
                bearingImage = AppCompatResources.getDrawable(
                    this@FindTreasureChestsActivityNew,
                    R.drawable.ic_navigate_location_green
                ),
                shadowImage = AppCompatResources.getDrawable(
                    this@FindTreasureChestsActivityNew,
                    com.mapbox.maps.R.drawable.mapbox_user_icon_shadow,
                ),
                scaleExpression = interpolate {
                    linear()
                    zoom()
                    stop {
                        literal(0.0)
                        literal(0.6)
                    }
                    stop {
                        literal(20.0)
                        literal(1.0)
                    }
                }.toJson()
            )
        }
        locationComponentPlugin.addOnIndicatorPositionChangedListener(onIndicatorPositionChangedListener)
        locationComponentPlugin.addOnIndicatorBearingChangedListener(onIndicatorBearingChangedListener)
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        locationPermissionHelper.onRequestPermissionsResult(requestCode, permissions, grantResults)
    }

    override fun onDestroy() {
        super.onDestroy()
        binding.mapView.location.removeOnIndicatorBearingChangedListener(onIndicatorBearingChangedListener)
        binding.mapView.location.removeOnIndicatorPositionChangedListener(onIndicatorPositionChangedListener)
    }

    private fun checkTreasureChestFound() {
        val distanceBetweenDeviceAndTarget = TurfMeasurement.distance(
            currentLocation,
            Point.fromLngLat(treasure.location.longitude, treasure.location.latitude),
            TurfConstants.UNIT_METERS
        )
        Timber.tag("TREASURE_DISTANCE").wtf("---------------------------------------------------------------------------------------------")
        Timber.tag("TREASURE_DISTANCE").wtf(currentLocation.latitude().toString() + " " + currentLocation.longitude().toString())
        Timber.tag("TREASURE_DISTANCE").wtf(treasure.location.latitude.toString() + " " + treasure.location.longitude.toString())
        Timber.tag("TREASURE_DISTANCE").wtf(distanceBetweenDeviceAndTarget.toString())
        Timber.tag("TREASURE_DISTANCE").wtf("---------------------------------------------------------------------------------------------")
        if (distanceBetweenDeviceAndTarget <= 10) {
            findTreasureChestViewModel.createTreasureWildWinner(treasure.id)
        }
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
}