import 'dart:math';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

/// App Geolocation services
class GeoLocationServices {
  ///Get coordinates (latitude/longitude)
  Future<Position> getCoordinates() async {
    requestPermissions();
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  double calculateDistanceInMeters(double startLat, double startLng,
      double endLat, double endLng) {
    return Geolocator.distanceBetween(startLat, startLng, endLat, endLng);
  }

  Future<void> requestPermissions() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }


  String calculateTime(double distanceInMeters) {
    String travelTime = '';

    double kms = distanceInMeters / 1000;

    double kms_per_min = 0.05;

    double mins_taken = kms / kms_per_min;


    if (mins_taken < 60) {
      travelTime = '${mins_taken.toStringAsFixed(2) } mins';
    } else {
      String minutes = (mins_taken % 60).toStringAsFixed(0);
      minutes = minutes.length == 1 ? "0" + minutes : minutes;
      travelTime = '${ (mins_taken / 60).toStringAsFixed(0)}   hour  $minutes mins';
    }

    return travelTime;
  }
}
