package com.android.gowild.dialogs

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.annotation.DrawableRes
import androidx.fragment.app.DialogFragment
import com.android.gowild.R
import com.android.gowild.data.model.myTrail.HistoricalEvents
import com.android.gowild.data.model.routes.RouteDataModel
import com.android.gowild.databinding.DialogMapBinding
import com.android.gowild.ui.map.TryRouteActivityNew
import com.android.gowild.utils.constant.MAP_TYPE
import com.android.gowild.utils.helper.BitmapHelpers
import com.mapbox.core.constants.Constants
import com.mapbox.geojson.LineString
import com.mapbox.geojson.Point
import com.mapbox.geojson.utils.PolylineUtils
import com.mapbox.maps.EdgeInsets
import com.mapbox.maps.extension.style.layers.generated.lineLayer
import com.mapbox.maps.extension.style.layers.properties.generated.LineCap
import com.mapbox.maps.extension.style.layers.properties.generated.LineJoin
import com.mapbox.maps.extension.style.sources.generated.geoJsonSource
import com.mapbox.maps.extension.style.style
import com.mapbox.maps.plugin.annotation.AnnotationConfig
import com.mapbox.maps.plugin.annotation.annotations
import com.mapbox.maps.plugin.annotation.generated.PointAnnotationOptions
import com.mapbox.maps.plugin.annotation.generated.createPointAnnotationManager

class MapDialog(private var routeData: RouteDataModel) : DialogFragment() {

    lateinit var binding: DialogMapBinding

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View {
        super.onCreateView(inflater, container, savedInstanceState)
        binding = DialogMapBinding.inflate(layoutInflater, container, false)
        init()
        return binding.root
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setStyle(STYLE_NO_TITLE, R.style.DialogStyle)
    }

    fun init() {
        setRouteData()
    }

    private fun setRouteData() {
        addPolyLine(routeData.polyline!!)

        setMarkers(
            PolylineUtils.decode(routeData.polyline!!, Constants.PRECISION_6).first(),
            PolylineUtils.decode(routeData.polyline!!, Constants.PRECISION_6).last()
        )

        animateToRoute(routeData)
        setHistoricalMarkers(routeData.historicalEvents)
    }

    private fun addPolyLine(polylineString: String) {
        val lineStringJson = LineString.fromPolyline(polylineString, Constants.PRECISION_6).toJson()
        val data = geoJsonSource(TryRouteActivityNew.GEOJSON_SOURCE_ID) {
            this.data(lineStringJson, TryRouteActivityNew.GEOJSON_SOURCE_ID)
        }

        binding.mapView.getMapboxMap().loadStyle(
            style(styleUri = MAP_TYPE) {
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

    private fun setMarkers(startPoint: Point, endPoint: Point) {
        addMarker(startPoint, R.drawable.ic_end_marker_new)
        addMarker(endPoint, R.drawable.ic_start_marker_new)
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
}