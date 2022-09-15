import 'dart:math';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gowild_api/gowild_api.dart';

extension AppPointLatLng on AppPoint {
  LatLng toPoint() {
    return LatLng(coordinates.first, coordinates.last);
  }
}

extension RouteHistoricalEventPointLatLng on RouteHistoricalEventPoint {
  LatLng toPoint() {
    return LatLng(coordinates.first, coordinates.last);
  }
}

extension RouteLatLng on Route {
  LatLngBounds toBounds() {
    final start$ = start?.toPoint();
    final end$ = end?.toPoint();
    if (end$ == null || start$ == null) {
      throw AssertionError('missing starting or ending point');
    }

    final northeast = LatLng(max(start$.latitude, end$.latitude), max(start$.longitude, end$.longitude));
    final southwest = LatLng(min(start$.latitude, end$.latitude), min(start$.longitude, end$.longitude));
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
