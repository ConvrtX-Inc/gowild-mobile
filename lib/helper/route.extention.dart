import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gowild_api/gowild_api.dart';

extension RouteLatLng on Route {
  LatLng toStart() {
    return LatLng(startPointLat, startPointLong);
  }

  LatLng toEnd() {
    return LatLng(stopPointLat, stopPointLat);
  }
}

extension LatLngToPoint on LatLng {
  PointLatLng toPoint() {
    return PointLatLng(latitude, longitude);
  }
}
