import 'package:flutter/material.dart';
import 'package:flutter_geofence/geofence.dart';

class GeofencingServices {
  addRegion(double lat, double lng, double radius, String id) {
    Geolocation location =
        Geolocation(latitude: lat, longitude: lng, radius: radius, id: id);
    Geofence.addGeolocation(location, GeolocationEvent.entry).then((onValue) {
      debugPrint('Geofence Added!');
    }).catchError((onError) {
      debugPrint('Geofence Removed!');
    });
  }
}
