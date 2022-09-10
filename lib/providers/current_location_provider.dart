import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gowild/helper/latlng_position.extensions.dart';
import 'package:gowild/providers/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const kLocationHive = 'location';
const kLastLocationKey = 'last_location';

final currentLocationProvider =
    StateNotifierProvider<CurrentLocation, LatLng>((ref) {
  final hive = ref.read(hiveProvider(kLocationHive));
  return CurrentLocation(hive);
});

class CurrentLocation extends StateNotifier<LatLng> {
  final HiveProvider<String> hiveProvider;

  CurrentLocation(this.hiveProvider) : super(const LatLng(4, 11)) {
    _init();
  }

  void _saveLocation() {
    hiveProvider.setValue(
        kLastLocationKey, '${state.latitude}#${state.longitude}');
  }

  LatLng? _retrieveSave() {
    final found = hiveProvider.value(kLastLocationKey);
    if (found == null) {
      return null;
    }

    final splitted = found.split('#');
    final a = double.tryParse(splitted[0]), b = double.tryParse(splitted[1]);
    if (a == null || b == null) {
      return null;
    }

    return LatLng(a, b);
  }

  void _init() async {
    await hiveProvider.init(kLocationHive);
    final position = _retrieveSave() ?? await _determinePosition();
    state = position;
    _saveLocation();
  }

  static Future<LatLng> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final position = await Geolocator.getCurrentPosition();
    return position.toLatLng();
  }

  Future<void> refreshLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    state = position.toLatLng();
    _saveLocation();
  }
}
