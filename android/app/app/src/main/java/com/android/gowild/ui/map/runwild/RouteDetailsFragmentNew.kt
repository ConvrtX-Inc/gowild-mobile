package com.android.gowild.ui.map.runwild

import android.util.Log
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.annotation.DrawableRes
import androidx.fragment.app.viewModels
import androidx.viewbinding.ViewBinding
import com.android.gowild.R
import com.android.gowild.data.model.routes.RouteDataModel
import com.android.gowild.data.model.settings.MyAchievementsDataModel
import com.android.gowild.databinding.FragmentRouteDetailsNewBinding
import com.android.gowild.networking.Errors
import com.android.gowild.networking.NetworkResult
import com.android.gowild.ui.base.BaseFragment
import com.android.gowild.ui.map.MapActivity
import com.android.gowild.ui.map.TryRouteActivityNew
import com.android.gowild.ui.user.dialog.ErrorDialog
import com.android.gowild.utils.TIME_FORMAT_TIME
import com.android.gowild.utils.extension.showBar
import com.android.gowild.utils.extension.toast
import com.android.gowild.utils.extension.visible
import com.android.gowild.utils.helper.BitmapHelpers
import com.android.gowild.utils.toCalendar
import com.mapbox.api.tilequery.MapboxTilequery
import com.mapbox.core.constants.Constants
import com.mapbox.geojson.Feature
import com.mapbox.geojson.FeatureCollection
import com.mapbox.geojson.LineString
import com.mapbox.geojson.Point
import com.mapbox.geojson.utils.PolylineUtils
import com.mapbox.maps.EdgeInsets
import com.mapbox.maps.Style
import com.mapbox.maps.extension.style.layers.generated.lineLayer
import com.mapbox.maps.extension.style.layers.properties.generated.LineCap
import com.mapbox.maps.extension.style.layers.properties.generated.LineJoin
import com.mapbox.maps.extension.style.sources.generated.geoJsonSource
import com.mapbox.maps.extension.style.style
import com.mapbox.maps.plugin.annotation.AnnotationConfig
import com.mapbox.maps.plugin.annotation.annotations
import com.mapbox.maps.plugin.annotation.generated.PointAnnotationOptions
import com.mapbox.maps.plugin.annotation.generated.createPointAnnotationManager
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import timber.log.Timber
import java.math.BigDecimal
import java.math.RoundingMode
import java.text.DecimalFormat
import java.util.Calendar

class RouteDetailsFragmentNew : BaseFragment() {

    companion object {
        @JvmStatic
        fun newInstance() = RouteDetailsFragmentNew()
    }

    lateinit var binding: FragmentRouteDetailsNewBinding
    private val routeDetailsVM: RouteDetailsVM by viewModels()

    private lateinit var routeData: RouteDataModel

    override fun getBinding(inflater: LayoutInflater, container: ViewGroup?): ViewBinding {
        binding = FragmentRouteDetailsNewBinding.inflate(layoutInflater)
        init()
        return binding
    }

    fun init() {
        getRouteDetails()
        observeNetworkResponses()
        setupListener()
    }

    private fun observeNetworkResponses() {
        observeRouteDetails()
        observeRouteLeaderboard()
    }

    private fun setupListener() {
        binding.btnLeaderBoard.setOnClickListener {
            requireActivity().startActivity(MapActivity.start(requireActivity(), "Leaderboard", route_id = routeData.id))
        }

        binding.ivBack.setOnClickListener {
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }
    }

    private fun getRouteDetails() {
        if (arguments != null) {
            val routeID = requireArguments().getString("route_id")
            Timber.tag("GW_INTENT").wtf("getRouteId $routeID")
            routeDetailsVM.getRouteDetail(routeID.toString())
        } else {
            toast("Route not found")
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }
    }

    private fun observeRouteLeaderboard() {
        routeDetailsVM.routeLeaderboardResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    if (response.data!!.data.isNotEmpty()) {
                        setLeaderboardData(response.data!!.data.first())
                    }
                }

                is NetworkResult.Failure -> {
                    response.junkError?.let { junkErrors ->
                        ErrorDialog(mContext, junkErrors.errors!![0].map { it.value }).show()
                    } ?: kotlin.run {
                        binding.root.showBar(response.message ?: "Failure")
                    }
                }

                is NetworkResult.Loading -> {
                }

                is NetworkResult.Error -> {
                }
            }
        }

    }

    private fun setLeaderboardData(leaderboard: MyAchievementsDataModel) {
        binding.tvElapsedTimeValue.text = leaderboard.completionTime
        binding.tvMovingTimeValue.text = leaderboard.completionTime
        binding.tvAvgSpeedValue.text = calculateSpeed(leaderboard.completionTime, routeData.distance_meters).toString().round() + " km/h"

    }

    fun String.round(zeroes: Int = 2): String {
        return roundFormatter(this.toDouble())
        return this.toDouble().round(zeroes)
    }

    fun Double.round(zeroes: Int = 2): String {
        return roundFormatter(this)
        return BigDecimal(this).setScale(zeroes, RoundingMode.HALF_EVEN).toString()
    }

    fun roundFormatter(amount: Double): String {
        if (amount == 0.0)
            return "0.00"
        val decimalFormat = DecimalFormat("###,###,###,###,###.00")
        return decimalFormat.format(amount)
    }

    private fun calculateSpeed(completionTime: String, distanceMeters: Int): Double {
        return ((distanceMeters.toDouble() / getTotalSeconds(completionTime).toDouble())) * 3.6
    }

    private fun getTotalSeconds(completionTime: String): Int {
        val calendar = completionTime.toCalendar(TIME_FORMAT_TIME)
        val hours = calendar.get(Calendar.HOUR_OF_DAY)
        val minutes = calendar.get(Calendar.MINUTE)
        val seconds = calendar.get(Calendar.SECOND)
        var total = 0
        total += hours * 60 * 60
        total += minutes * 60
        total += seconds
        return total
    }


    private fun observeRouteDetails() {
        routeDetailsVM.routeDetailsResponse.observe(viewLifecycleOwner) { response ->
            when (response) {
                is NetworkResult.Success -> {
                    hideProgress()
                    binding.parentLayout.visible()
                    routeData = response.data!!.data
                    showData(routeData)
                    getElevationData(routeData)
                    routeDetailsVM.getRouteLeaderBoard(routeData.id)
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

    private fun getElevationData(routeData: RouteDataModel) {
        val elevationQuery = MapboxTilequery.builder()
            .accessToken(getString(R.string.mapbox_access_token))
            .tilesetIds("mapbox.mapbox-terrain-v2")
            .query(Point.fromLngLat(routeData.start.longitude, routeData.start.latitude))
            .radius(routeData.distance_meters / 2)
            .geometry("polygon")
            .layers("contour")
            .build()



        elevationQuery.enqueueCall(object : Callback<FeatureCollection?> {
            override fun onResponse(call: Call<FeatureCollection?>, response: Response<FeatureCollection?>) {
                if (response.body()?.features() != null) {
                    val featureList: List<Feature> = response.body()!!.features() as List<Feature>
                    var listOfElevationNumbers = ""

// Build a list of the elevation numbers in the response.
                    for (singleFeature in featureList) {
                        listOfElevationNumbers = listOfElevationNumbers + singleFeature.getStringProperty("ele") + ", "
                    }
                    if (featureList.isNotEmpty()) {
                        binding.tvMaxElevationValue.text = featureList.last().getStringProperty("ele") + " m"
                        if (featureList.size > 1) {
                            binding.tvElevationValue.text =
                                (featureList.last().getStringProperty("ele").toInt() - featureList.first().getStringProperty("ele")
                                    .toInt()).toString() + " m"
                        }
                    }

// Set this TextViews with the response info/JSON.
                    Log.wtf("ElevationJson", response.body()!!.toJson())
//                    binding.elevationQueryApiResponseElevationNumbersOnly.text = featureList.size.toString() + " " + listOfElevationNumbers
//                    binding.elevationQueryApiResponseJsonTextview.text = response.body()!!.toJson()

// Update the SymbolLayer that's responsible for showing the number text with the highest/lowest
// elevation number
//                    if (featureList.isNotEmpty()) {
//                        val resultSource: GeoJsonSource? = mapView.getMapboxMap().getStyle().getSourceAs(RESULT_GEOJSON_SOURCE_ID)
//                        resultSource.data (featureList[featureList.size - 1])
//                    }
                } else {

//                    val noFeaturesString = getString(R.string.elevation_tilequery_no_features)
//                    Timber.d(noFeaturesString)
//                    Toast.makeText(this@ElevationQueryActivity, noFeaturesString, Toast.LENGTH_SHORT).show()
//                    binding.elevationQueryNumbersOnlyResponseTextView.setText(noFeaturesString)
//                    binding.elevationQueryJsonResponseTextView.setText(noFeaturesString)
                }
            }

            override fun onFailure(call: Call<FeatureCollection?>, throwable: Throwable) {
                binding.tvMaxElevationValue.text = "N/A"
//                Toast.makeText(
//                    applicationContext,
//                    "Elevation Fialed",
//                    Toast.LENGTH_SHORT
//                ).show()
            }
        })
    }

    private fun showData(data: RouteDataModel) {
        binding.tvTitle.text = data.title
        binding.tvRouteName.text = data.title
//        val roundedDistance = data.distance_meters.toBigDecimal().setScale(2, RoundingMode.UP).toDouble()
        binding.tvDistanceValue.text = "${data.distance_meters} m"
        setRouteData()
    }

    private fun setRouteData() {
        binding.tvTitle.text = routeData.title

//        addPolyLine(PolylineUtils.decode(routeData.route_path!!, Constants.PRECISION_6))
        addPolyLine(routeData.polyline!!)

        setMarkers(
            PolylineUtils.decode(routeData!!.polyline!!, Constants.PRECISION_6).first(),
            PolylineUtils.decode(routeData!!.polyline!!, Constants.PRECISION_6).last()
        )

        animateToRoute(routeData)
    }

    private fun animateToRoute(routeData: RouteDataModel) {
        val cameraPosition = binding.mapView.getMapboxMap().cameraForCoordinates(
            PolylineUtils.decode(routeData.polyline!!, Constants.PRECISION_6),
            EdgeInsets(
                150.0,
                150.0,
                150.0,
                150.0,
            )
        )
        binding.mapView.getMapboxMap().setCamera(cameraPosition)
    }

    private fun setMarkers(startPoint: Point, endPoint: Point) {
        addMarker(startPoint, R.drawable.ic_start_marker_new)
        addMarker(endPoint, R.drawable.ic_end_marker_new)
    }

    private fun addMarker(point: Point, @DrawableRes resourceId: Int) {
        BitmapHelpers().bitmapFromDrawableRes(
            requireContext(),
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

    private fun addPolyLine(points: MutableList<Point>) {
        val polylineString = PolylineUtils.encode(points, Constants.PRECISION_6)
        addPolyLine(polylineString)
    }

    private fun addPolyLine(polylineString: String) {
        val lineStringJson = LineString.fromPolyline(polylineString, Constants.PRECISION_6).toJson()
        val data = geoJsonSource(TryRouteActivityNew.GEOJSON_SOURCE_ID) {
            this.data(lineStringJson, TryRouteActivityNew.GEOJSON_SOURCE_ID)
        }

        binding.mapView.getMapboxMap().loadStyle(
            style(styleUri = Style.OUTDOORS) {
                +data
                +lineLayer("linelayer", TryRouteActivityNew.GEOJSON_SOURCE_ID) {
                    lineCap(LineCap.ROUND)
                    lineJoin(LineJoin.ROUND)
                    lineOpacity(1.0)
                    lineWidth(5.0)
                    lineColor("#E4572E")
                }
            }
        )
    }
}