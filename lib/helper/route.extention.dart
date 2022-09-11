import 'dart:math';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gowild_api/gowild_api.dart';

extension RouteLatLng on Route {
  LatLng toStart() {
    return LatLng(startPointLat, startPointLong);
  }

  LatLng toEnd() {
    return LatLng(stopPointLat, stopPointLong);
  }

  LatLngBounds toBounds() {
    final start = toStart();
    final end = toEnd();
    final northeast = LatLng(max(start.latitude, end.latitude), max(start.longitude, end.longitude));
    final southwest = LatLng(min(start.latitude, end.latitude), min(start.longitude, end.longitude));
    return LatLngBounds(northeast: northeast, southwest: southwest);
  }
}

extension LatLngToPoint on LatLng {
  PointLatLng toPoint() {
    return PointLatLng(latitude, longitude);
  }
}

extension PointToLatLng on PointLatLng {
  LatLng toLatLng() {
    return LatLng(latitude, longitude);
  }
}
