package com.android.gowild.utils.helper

import android.app.Activity
import android.content.Context
import android.content.IntentSender
import android.location.LocationManager
import android.widget.Toast
import androidx.activity.ComponentActivity
import androidx.activity.result.IntentSenderRequest
import androidx.activity.result.contract.ActivityResultContracts
import com.android.gowild.utils.extension.toast
import com.google.android.gms.auth.api.phone.SmsRetrieverStatusCodes
import com.google.android.gms.common.api.ApiException
import com.google.android.gms.common.api.ResolvableApiException
import com.google.android.gms.location.LocationRequest
import com.google.android.gms.location.LocationServices
import com.google.android.gms.location.LocationSettingsRequest
import com.google.android.gms.location.LocationSettingsStatusCodes
import com.google.android.gms.location.SettingsClient
import com.mapbox.android.core.permissions.PermissionsListener
import com.mapbox.android.core.permissions.PermissionsManager
import java.lang.ref.WeakReference

class LocationPermissionHelper(val activity: WeakReference<Activity>) {
    private lateinit var callback: () -> Unit
    private lateinit var permissionsManager: PermissionsManager

    fun checkPermissions(onMapReady: () -> Unit) {
        callback = onMapReady
        if (PermissionsManager.areLocationPermissionsGranted(activity.get())) {
            turnGPSOn(onMapReady)
        } else {
            permissionsManager = PermissionsManager(object : PermissionsListener {
                override fun onExplanationNeeded(permissionsToExplain: List<String>) {
                    Toast.makeText(
                        activity.get(), "You need to accept location permissions.",
                        Toast.LENGTH_SHORT
                    ).show()
                }

                override fun onPermissionResult(granted: Boolean) {
                    if (granted) {
                        turnGPSOn(onMapReady)
                    } else {
                        activity.get()?.finish()
                    }
                }
            })
            permissionsManager.requestLocationPermissions(activity.get())
        }
    }

    var settingsLauncher = (activity.get()!! as ComponentActivity).registerForActivityResult(ActivityResultContracts.StartIntentSenderForResult()) { result ->
        if (result.resultCode == Activity.RESULT_OK) {
//            isGPS = true
//            turnGPSOn()
            callback()
        } else {
//            isGPS = false
//            toast("Please turn on location services for accurate results")
            callback()
        }
    }

    private fun turnGPSOn(onMapReady: () -> Unit) {
        val mLocationSettingsRequest: LocationSettingsRequest
        val mSettingsClient: SettingsClient = LocationServices.getSettingsClient(activity.get()!!)
        val locationManager: LocationManager = activity.get()!!.getSystemService(Context.LOCATION_SERVICE) as LocationManager
        val locationRequest: LocationRequest = LocationRequest.Builder(1000).build()
        val builder = LocationSettingsRequest.Builder().addLocationRequest(locationRequest)
        mLocationSettingsRequest = builder.build()

        builder.setAlwaysShow(true)

        if (locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER)) {
//            requestLocationUpdates()
            onMapReady()
        } else {
            mSettingsClient.checkLocationSettings(mLocationSettingsRequest).addOnSuccessListener(activity.get()!!) {
                activity.get()!!.toast("Location Setting ON")
                onMapReady()
            }.addOnFailureListener(activity.get()!!) { e ->
                when ((e as ApiException).statusCode) {
                    LocationSettingsStatusCodes.RESOLUTION_REQUIRED -> {
                        try {
                            settingsLauncher.launch(IntentSenderRequest.Builder((e as ResolvableApiException).resolution).build())
                        } catch (cce: ClassCastException) {
                            val status: com.google.android.gms.common.api.Status = e.status
                            val resolvable = ResolvableApiException(status)
                            settingsLauncher.launch(IntentSenderRequest.Builder(resolvable.resolution).build())
                            activity.get()!!.toast("Location Failure ${cce.message}", Toast.LENGTH_LONG)
                        } catch (sie: IntentSender.SendIntentException) {
                            activity.get()!!.toast("Unable to turn on settings.")
                        }
                    }
                    LocationSettingsStatusCodes.SETTINGS_CHANGE_UNAVAILABLE -> {
                        val errorMessage = "Location settings are inadequate, and cannot be fixed here. Fix in Settings."
                        activity.get()!!.toast(errorMessage)
                    }
                }
            }
        }
    }


    fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<String>,
        grantResults: IntArray
    ) {
        permissionsManager.onRequestPermissionsResult(requestCode, permissions, grantResults)
    }
}