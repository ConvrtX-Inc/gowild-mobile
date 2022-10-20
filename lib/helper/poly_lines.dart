import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gowild/helper/logging.dart';
import 'package:gowild/helper/route.extention.dart';
import 'package:gowild_api/gowild_api.dart';

final polylinePoints = PolylinePoints();

Future<List<LatLng>> findPolyLines(Route route) async {
  final start = route.start?.toPoint();
  final end = route.end?.toPoint();
  if (end == null || start == null) {
    throw AssertionError('missing starting or ending point');
  }

  final value = await polylinePoints.getRouteBetweenCoordinates(
    'AIzaSyCgUycdQ8C8cnGaYTPymLvIzidBENWVicU',
    start.toPoint(),
    end.toPoint(),
  );

  logger.d('Got Poly-Lines from route#${route.id} : ${value.status}');
  if (value.errorMessage?.isNotEmpty == true) {
    logger.e('Could not find direction for ${route.id}: ${value.errorMessage}');
    throw Exception(value.errorMessage);
  }

  return value.points.map((e) => e.toLatLng()).toList();
}
