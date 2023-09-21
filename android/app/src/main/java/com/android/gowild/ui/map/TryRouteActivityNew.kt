package com.android.gowild.ui.map

import android.os.Bundle
import android.util.Log
import androidx.activity.viewModels
import androidx.annotation.DrawableRes
import androidx.appcompat.content.res.AppCompatResources
import com.android.gowild.R
import com.android.gowild.data.model.myTrail.HistoricalEvents
import com.android.gowild.data.model.routes.CreateLeaderboardRequest
import com.android.gowild.data.model.routes.RouteDataModel
import com.android.gowild.databinding.ActivityTryRouteNewBinding
import com.android.gowild.dialogs.HistoricalEventDialog
import com.android.gowild.networking.Errors
import com.android.gowild.networking.NetworkResult
import com.android.gowild.ui.base.BaseActivity
import com.android.gowild.ui.user.dialog.ErrorDialog
import com.android.gowild.utils.constant.MAP_TYPE
import com.android.gowild.utils.extension.gone
import com.android.gowild.utils.extension.showBar
import com.android.gowild.utils.extension.toast
import com.android.gowild.utils.extension.visible
import com.android.gowild.utils.helper.BitmapHelpers
import com.android.gowild.utils.helper.LocationPermissionHelper
import com.android.gowild.utils.mapboxUtils.CustomLocationProvider
import com.android.gowild.utils.toTime
import com.google.gson.Gson
import com.mapbox.core.constants.Constants
import com.mapbox.geojson.LineString
import com.mapbox.geojson.Point
import com.mapbox.geojson.utils.PolylineUtils
import com.mapbox.maps.CameraOptions
import com.mapbox.maps.EdgeInsets
import com.mapbox.maps.MapView
import com.mapbox.maps.Style
import com.mapbox.maps.extension.style.expressions.dsl.generated.interpolate
import com.mapbox.maps.extension.style.layers.generated.lineLayer
import com.mapbox.maps.extension.style.layers.properties.generated.LineCap
import com.mapbox.maps.extension.style.layers.properties.generated.LineJoin
import com.mapbox.maps.extension.style.sources.generated.geoJsonSource
import com.mapbox.maps.extension.style.style
import com.mapbox.maps.plugin.LocationPuck2D
import com.mapbox.maps.plugin.annotation.AnnotationConfig
import com.mapbox.maps.plugin.annotation.annotations
import com.mapbox.maps.plugin.annotation.generated.PointAnnotationOptions
import com.mapbox.maps.plugin.annotation.generated.PolylineAnnotation
import com.mapbox.maps.plugin.annotation.generated.PolylineAnnotationManager
import com.mapbox.maps.plugin.annotation.generated.PolylineAnnotationOptions
import com.mapbox.maps.plugin.annotation.generated.createPointAnnotationManager
import com.mapbox.maps.plugin.annotation.generated.createPolylineAnnotationManager
import com.mapbox.maps.plugin.gestures.gestures
import com.mapbox.maps.plugin.locationcomponent.OnIndicatorBearingChangedListener
import com.mapbox.maps.plugin.locationcomponent.OnIndicatorPositionChangedListener
import com.mapbox.maps.plugin.locationcomponent.location
import com.mapbox.maps.plugin.locationcomponent.location2
import com.mapbox.turf.TurfConstants
import com.mapbox.turf.TurfMeasurement
import dagger.hilt.android.AndroidEntryPoint
import timber.log.Timber
import java.lang.ref.WeakReference

@AndroidEntryPoint
class TryRouteActivityNew : BaseActivity() {

    lateinit var binding: ActivityTryRouteNewBinding
    private val tryRouteViewModel: TryRouteVM by viewModels()

    private lateinit var locationPermissionHelper: LocationPermissionHelper

    private lateinit var routeData: RouteDataModel

    private lateinit var currentLocation: Point

    private var isRouteStarted: Boolean = false
    private var isRouteCompleted: Boolean = false
    private var isHistoricalEventDialogShowing: Boolean = false
    private var startTime: Long = 0

    private lateinit var polyLineAnnotation: PolylineAnnotation
    private lateinit var polyLineAnnotationManager: PolylineAnnotationManager

    var userTrack: ArrayList<Point> = ArrayList()

    private val onIndicatorBearingChangedListener = OnIndicatorBearingChangedListener {
        if (isRouteStarted)
            binding.mapView.getMapboxMap().setCamera(CameraOptions.Builder().bearing(it).build())
    }

    private val onIndicatorPositionChangedListener = OnIndicatorPositionChangedListener {
        currentLocation = it
        if (isRouteStarted) {
//            updateTrack(currentLocation)
            checkRouteFinished()
            checkHistoricalEvent()
            binding.mapView.getMapboxMap().setCamera(CameraOptions.Builder().center(it).build())
            binding.mapView.gestures.focalPoint = binding.mapView.getMapboxMap().pixelForCoordinate(it)
        }
    }

    private fun checkHistoricalEvent() {
        if (isHistoricalEventDialogShowing)
            return
        if (!routeData.historicalEvents.isNullOrEmpty()) {
            routeData.historicalEvents?.forEachIndexed { index, historicalEvent ->
                if (!historicalEvent.isPopupShown) {
                    val distanceBetweenDeviceAndTarget = TurfMeasurement.distance(
                        currentLocation,
                        Point.fromLngLat(historicalEvent.historical_event.longitude, historicalEvent.historical_event.latitude),
                        TurfConstants.UNIT_METERS
                    )
                    Timber.tag("HistoricalEvent").wtf("$index $distanceBetweenDeviceAndTarget")
                    if (distanceBetweenDeviceAndTarget <= 5) {
                        if (!isHistoricalEventDialogShowing) {
                            isHistoricalEventDialogShowing = true
                            val historicalEventDialog = HistoricalEventDialog(historicalEvent) {
                                isHistoricalEventDialogShowing = false
                                routeData.historicalEvents!![index].isPopupShown = true
                            }
                            historicalEventDialog.show(supportFragmentManager, "")
//                        historicalEventDialog.onDismiss(object : DialogInterface {
//                            override fun cancel() {
//                                isHistoricalEventDialogShowing = false
//                            }
//
//                            override fun dismiss() {
//                                isHistoricalEventDialogShowing = false
//                            }
//                        })
                        }
                    }
                }
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityTryRouteNewBinding.inflate(layoutInflater)
        setContentView(binding.root)
        init()
    }

    fun init() {
        setPermissions()
        setRouteData()
        observeCreateLeaderBoard()
        setCallbacks()
    }

    private fun setCallbacks() {
        binding.btnStartRoute.setOnClickListener {
            if (canStartRoute()) {
                isRouteStarted = true
                addPolyLine(routeData.polyline!!, 60.0)
                binding.tvRouteDetails.gone()
                binding.btnStartRoute.gone()
                binding.tvRouteTitle.gone()
                startTime = System.currentTimeMillis()
                binding.mapView.getMapboxMap().setCamera(CameraOptions.Builder().zoom(17.5).pitch(45.0).build())
            } else if (isRouteCompleted) {
                startActivity(MapActivity.start(this, "Leaderboard", route_id = routeData.id))
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

    private fun canStartRoute(): Boolean {
        if (!::currentLocation.isInitialized) {
            toast("Failed to get location")
            return false
        }

        if (isRouteCompleted)
            return false
        val distanceBetweenDeviceAndTarget = TurfMeasurement.distance(
            currentLocation,
            Point.fromLngLat(routeData.start.longitude, routeData.start.latitude),
            TurfConstants.UNIT_METERS
        )
        Timber.tag("Distance").wtf("Distance from start $distanceBetweenDeviceAndTarget")
        if (distanceBetweenDeviceAndTarget > 5) {
            toast("You are not in the proximity of the starting point of this route.")
            return false
        }
        return true
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

    private fun setRouteData() {
        val route = intent.extras!!.getString("route")
        routeData = Gson().fromJson(route, RouteDataModel::class.java)!!

        binding.tvRouteTitle.text = routeData.title
        binding.tvTitle.text = routeData.title

        addPolyLine(routeData.polyline!!, 5.0)

        setMarkers(
            PolylineUtils.decode(routeData.polyline!!, Constants.PRECISION_6).first(),
            PolylineUtils.decode(routeData.polyline!!, Constants.PRECISION_6).last()
        )

        animateToRoute(routeData)
        setHistoricalMarkers(routeData.historicalEvents)
    }

    private fun setHistoricalMarkers(historicalEvents: ArrayList<HistoricalEvents>?) {
        if (!historicalEvents.isNullOrEmpty()) {
            historicalEvents.forEach {
                addMarker(Point.fromLngLat(it.historical_event.longitude, it.historical_event.latitude), R.drawable.ic_historical_marker)
            }
        }
    }

    private fun animateToRoute(routeData: RouteDataModel) {
        val cameraPosition = binding.mapView.getMapboxMap().cameraForCoordinates(
            PolylineUtils.decode(routeData.polyline!!, Constants.PRECISION_6),
            EdgeInsets(
                -150.0,
                -150.0,
                -150.0,
                -150.0,
            )
        )
        binding.mapView.getMapboxMap().setCamera(cameraPosition)
    }

    private fun setPermissions() {
        locationPermissionHelper = LocationPermissionHelper(WeakReference(this))
        locationPermissionHelper.checkPermissions {
            onMapReady()
        }
    }

    private fun onMapReady() {
//        initializePolyLine()
        initializeLocationComponent()
    }

    private fun initializeLocationComponent() {
        val locationComponentPlugin = binding.mapView.location
        locationComponentPlugin.setLocationProvider(CustomLocationProvider(applicationContext))
        locationComponentPlugin.updateSettings {
            this.enabled = true
            this.locationPuck = LocationPuck2D(
                bearingImage = AppCompatResources.getDrawable(
                    this@TryRouteActivityNew,
                    R.drawable.ic_navigate_location_green
                ),
                shadowImage = AppCompatResources.getDrawable(
                    this@TryRouteActivityNew,
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

    private fun setMarkers(startPoint: Point, endPoint: Point) {
        addMarker(startPoint, R.drawable.ic_end_marker_new)
        addMarker(endPoint, R.drawable.ic_start_marker_new)
    }

    private fun addMarker(point: Point, @DrawableRes resourceId: Int) {
        BitmapHelpers().bitmapFromDrawableRes(
            applicationContext,
            resourceId
        )?.let {
            val annotationApi = binding.mapView.annotations
            val pointAnnotationManager = annotationApi.createPointAnnotationManager(AnnotationConfig())
            val pointAnnotationOptions: PointAnnotationOptions = PointAnnotationOptions()
                .withPoint(point)
                .withIconImage(it)
            pointAnnotationManager.create(pointAnnotationOptions)
        }
    }

    private fun checkRouteFinished() {
        val distanceBetweenDeviceAndTarget = TurfMeasurement.distance(
            currentLocation,
            PolylineUtils.decode(routeData!!.polyline!!, Constants.PRECISION_6).last(),
            TurfConstants.UNIT_METERS
        )
        Timber.tag("Distance").wtf("Distance from end $distanceBetweenDeviceAndTarget")
        var isRouteFinished = false
        if (routeData.distance_meters <= 100 && distanceBetweenDeviceAndTarget <= 5) {
            isRouteFinished = true
        } else if (routeData.distance_meters > 100 && distanceBetweenDeviceAndTarget <= 10) {
            isRouteFinished = true
        }
        if (isRouteFinished) {
            isRouteStarted = false
            tryRouteViewModel.createLeaderboard(CreateLeaderboardRequest(routeData.id, startTime.toTime(), System.currentTimeMillis().toTime()))
        }
    }

    private fun removePolyLine() {
        binding.mapView.getMapboxMap().loadStyle(
            style(styleUri = Style.OUTDOORS) {

            }
        )
    }

    private fun addPolyLine(points: MutableList<Point>) {
        val polylineString = PolylineUtils.encode(points, Constants.PRECISION_6)
        addPolyLine(polylineString)
    }

    private fun addPolyLine(polylineString: String, size: Double = 5.0) {
        val lineStringJson = LineString.fromPolyline(polylineString, Constants.PRECISION_6).toJson()
        val data = geoJsonSource(GEOJSON_SOURCE_ID) {
            this.data(lineStringJson, GEOJSON_SOURCE_ID)
        }

        binding.mapView.getMapboxMap().loadStyle(
            style(styleUri = MAP_TYPE) {
                +data
                +lineLayer("linelayer", GEOJSON_SOURCE_ID) {
                    lineCap(LineCap.ROUND)
                    lineJoin(LineJoin.ROUND)
                    lineOpacity(1.0)
                    lineWidth(size)
                    lineColor("#E4572E")
                }
            }
        )
        binding.mapView.placeLocationPuckOverOtherLayers()
    }

    private fun MapView.placeLocationPuckOverOtherLayers() {
        this.location2.enabled = false
        this.location2.enabled = true
    }

    private fun initializePolyLine() {
        polyLineAnnotationManager = binding.mapView.annotations.createPolylineAnnotationManager()
        val polylineAnnotationOptions: PolylineAnnotationOptions = PolylineAnnotationOptions()
            .withGeometry(
                LineString.fromPolyline(
                    PolylineUtils.encode(userTrack, Constants.PRECISION_6),
                    Constants.PRECISION_6
                )
            )
            .withLineColor("#3B5998")
            .withLineWidth(5.0)
        polyLineAnnotation = polyLineAnnotationManager.create(polylineAnnotationOptions)!!
    }

    private fun updatePolyLineAnnotation() {
        polyLineAnnotation.geometry = LineString.fromPolyline(PolylineUtils.encode(userTrack, Constants.PRECISION_6), Constants.PRECISION_6!!)
        Log.wtf("PolyLineAnnotation", polyLineAnnotation.geometry.coordinates().size.toString())
        polyLineAnnotationManager.update(polyLineAnnotation)
    }

    private fun updateTrack(location: Point) {
        Log.wtf("SizeBefore", userTrack.size.toString())
        if (userTrack.isEmpty()) {
            userTrack.add(location)
            return
        }

        val distanceBetweenDeviceAndTarget = TurfMeasurement.distance(
            location,
            userTrack.last(),
            TurfConstants.UNIT_METERS
        )
        Log.wtf("DistanceBetweenLastPoint", distanceBetweenDeviceAndTarget.toString())
        if (distanceBetweenDeviceAndTarget > 2) {
            userTrack.add(location)
            updatePolyLineAnnotation()
        }
    }


    companion object {
        const val GEOJSON_SOURCE_ID = "line"
    }

    override fun onDestroy() {
        super.onDestroy()
        binding.mapView.location.removeOnIndicatorBearingChangedListener(onIndicatorBearingChangedListener)
        binding.mapView.location.removeOnIndicatorPositionChangedListener(onIndicatorPositionChangedListener)
    }
}