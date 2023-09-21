package com.android.gowild.utils.mapboxUtils

import android.annotation.SuppressLint
import android.content.Context
import android.location.Location
import android.location.LocationListener
import android.location.LocationManager
import android.os.Handler
import android.util.Log
import androidx.annotation.VisibleForTesting
import com.mapbox.android.core.permissions.PermissionsManager
import com.mapbox.geojson.Point
import com.mapbox.maps.logW
import com.mapbox.maps.plugin.PuckBearingSource
import com.mapbox.maps.plugin.locationcomponent.LocationCompassCalibrationListener
import com.mapbox.maps.plugin.locationcomponent.LocationConsumer
import com.mapbox.maps.plugin.locationcomponent.LocationConsumer2
import com.mapbox.maps.plugin.locationcomponent.LocationProvider
import java.util.concurrent.CopyOnWriteArraySet

class CustomLocationProvider(
    context: Context,
    private val locationCompassEngine: LocationCompassEngine
) : LocationProvider {
    constructor(context: Context) : this(context, LocationCompassEngine(context.applicationContext))

    private val applicationContext = context.applicationContext
//    private val locationEngine = LocationEngineProvider.getBestLocationEngine(applicationContext)
//    private val locationEngineRequest =
//        LocationEngineRequest.Builder(LocationComponentConstants.DEFAULT_INTERVAL_MILLIS)
//            .setFastestInterval(LocationComponentConstants.DEFAULT_FASTEST_INTERVAL_MILLIS)
//            .setPriority(LocationEngineRequest.PRIORITY_HIGH_ACCURACY)
//            .setDisplacement(0.0f)
//            .setMaxWaitTime(1000)
//            .build()

    private val locationConsumers = CopyOnWriteArraySet<LocationConsumer>()
    private var currentPuckBearingSource: PuckBearingSource = PuckBearingSource.COURSE
    private var handler: Handler? = null
    private lateinit var runnable: Runnable
    private var updateDelay = INIT_UPDATE_DELAY

//    private val locationEngineCallback: LocationEngineCallback<LocationEngineResult> =
//        CurrentLocationEngineCallback(this)

    @VisibleForTesting(otherwise = VisibleForTesting.PRIVATE)
    internal val locationCompassListener =
        LocationCompassEngine.CompassListener { userHeading ->
            locationConsumers.forEach { consumer ->
                consumer.onBearingUpdated(userHeading.toDouble())
            }
        }

    @SuppressLint("MissingPermission")
    private fun requestLocationUpdates() {
        Log.wtf("requestLocationUpdates", "called")
        if (PermissionsManager.areLocationPermissionsGranted(applicationContext)) {
//            val request = LocationEngineRequest.Builder(LocationComponentConstants.DEFAULT_INTERVAL_MILLIS)
//                .setFastestInterval(LocationComponentConstants.DEFAULT_FASTEST_INTERVAL_MILLIS)
//                .setPriority(LocationEngineRequest.PRIORITY_HIGH_ACCURACY)
//                .build()

//            locationEngine.requestLocationUpdates(
//                locationEngineRequest, locationEngineCallback, Looper.getMainLooper()
//            )
            getLocation()
        } else {
            if (handler == null) {
                handler = Handler()
                runnable = Runnable { requestLocationUpdates() }
            }
            if (updateDelay * 2 < MAX_UPDATE_DELAY) {
                updateDelay *= 2
            } else {
                updateDelay = MAX_UPDATE_DELAY
            }
            handler?.postDelayed(runnable, updateDelay)
            logW(
                TAG,
                "Missing location permission, location component will not take effect before location permission is granted."
            )
        }
    }

    private fun notifyLocationUpdates(location: Location) {
        Log.wtf("notifyLocationUpdates", "called $location")
        val locationPoint = if (location.hasAltitude()) {
            Point.fromLngLat(location.longitude, location.latitude, location.altitude)
        } else {
            Point.fromLngLat(location.longitude, location.latitude)
        }

        locationConsumers.forEach { consumer ->
            Log.wtf("locationConsumer", "called $location")
            consumer.onLocationUpdated(locationPoint)
            if (currentPuckBearingSource == PuckBearingSource.COURSE) {
                consumer.onBearingUpdated(location.bearing.toDouble())
            }
            if (consumer is LocationConsumer2) {
                consumer.onAccuracyRadiusUpdated(location.accuracy.toDouble())
            }
        }
    }

    /**
     * Update the data source that drives the bearing updates of the [LocationProvider].
     *
     * @param source The [PuckBearingSource] used to drive the bearing updates.
     */
    fun updatePuckBearingSource(source: PuckBearingSource) {
        if (source == currentPuckBearingSource) {
            return
        }
        currentPuckBearingSource = source

        // No need to request compass update if no location consumer is registered.
        if (!locationConsumers.isEmpty()) {
            when (currentPuckBearingSource) {
                PuckBearingSource.HEADING -> locationCompassEngine.addCompassListener(
                    locationCompassListener
                )

                PuckBearingSource.COURSE -> locationCompassEngine.removeCompassListener(
                    locationCompassListener
                )
            }
        }
    }

    /**
     * Register the location consumer to the Location Provider.
     *
     * The Location Consumer will get location and bearing updates from the Location Provider.
     *
     * @param locationConsumer
     */
    @SuppressLint("MissingPermission")
    override fun registerLocationConsumer(locationConsumer: LocationConsumer) {
        if (locationConsumers.isEmpty()) {
            requestLocationUpdates()

            // Start to listen compass change in HEADING mode.
            if (currentPuckBearingSource == PuckBearingSource.HEADING) {
                locationCompassEngine.addCompassListener(locationCompassListener)
            }
        }
        locationConsumers.add(locationConsumer)
        if (PermissionsManager.areLocationPermissionsGranted(applicationContext)) {
            val locationManager = applicationContext.getSystemService(Context.LOCATION_SERVICE) as LocationManager
            val gpsEnabled = locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER)
            if (gpsEnabled) {


                // Or get last known location
                val location = locationManager.getLastKnownLocation(LocationManager.GPS_PROVIDER)
                location?.let {
                    notifyLocationUpdates(it)
                }
//            locationEngine.getLastLocation(locationEngineCallback)
            }

        } else {
            logW(
                TAG,
                "Missing location permission, location component will not take effect before location permission is granted."
            )
        }
    }

    /**
     * Unregister the location consumer from the Location Provider.
     *
     * @param locationConsumer
     */
    override fun unRegisterLocationConsumer(locationConsumer: LocationConsumer) {
        locationConsumers.remove(locationConsumer)
        if (locationConsumers.isEmpty()) {
//            locationEngine.removeLocationUpdates(locationEngineCallback)
            handler?.removeCallbacks(runnable)

            // Stop listening compass change when no consumer is registered to save power.
            if (currentPuckBearingSource == PuckBearingSource.HEADING) {
                locationCompassEngine.removeCompassListener(locationCompassListener)
            }
        }
    }

    /**
     * Register a listener to be invoked when compass needs to be calibrated.
     *
     * @param listener
     */
    fun addOnCompassCalibrationListener(listener: LocationCompassCalibrationListener) {
        locationCompassEngine.addCalibrationListener(listener)
    }

    /**
     * Unregister a listener to be invoked when compass needs to be calibrated.
     *
     * @param listener
     */
    fun removeCompassCalibrationListener(listener: LocationCompassCalibrationListener) {
        locationCompassEngine.removeCalibrationListener(listener)
    }

    // Callbacks may leak after GoogleLocationEngineImpl.removeLocationUpdates,
    // see https://github.com/mapbox/mapbox-events-android/issues/562 for more details
    // TODO: implement location listener
//    private class CurrentLocationEngineCallback(locationProvider: CustomLocationProvider) :
//        LocationEngineCallback<LocationEngineResult> {
//        private val locationProviderWeakReference: WeakReference<CustomLocationProvider> =
//            WeakReference(locationProvider)
//
//        override fun onSuccess(result: LocationEngineResult) {
//            result.lastLocation?.let { location ->
//                locationProviderWeakReference.get()?.let {
//                    it.notifyLocationUpdates(location)
//                }
//            }
//        }
//
//        override fun onFailure(exception: Exception) {
//            logE(
//                TAG,
//                "Failed to obtain location update: $exception"
//            )
//        }
//    }

    val locationListener = LocationListener { location ->
        notifyLocationUpdates(location)
    }

    @SuppressLint("MissingPermission")
    fun getLocation() {
        Log.wtf("getLocation", "called")
        val locationManager = applicationContext.getSystemService(Context.LOCATION_SERVICE) as LocationManager
        val gpsEnabled = locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER)
        if (gpsEnabled) {
            locationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER, 100, 0.0f, locationListener)

            // Or get last known location
            val location = locationManager.getLastKnownLocation(LocationManager.GPS_PROVIDER)
            location?.let {
                notifyLocationUpdates(it)
            }
        }
    }

    private companion object {
        private const val TAG = "MapboxLocationProvider"
        private const val INIT_UPDATE_DELAY = 100L
        private const val MAX_UPDATE_DELAY = 5000L
    }
}