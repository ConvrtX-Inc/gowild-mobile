import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gowild/helper/latlng_position.extensions.dart';
import 'package:gowild/helper/location.dart';
import 'package:gowild/providers/hive.dart';
import 'package:gowild/services/logging.dart';
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

  CurrentLocation(this.hiveProvider) : super(const LatLng(49.597415, 10.945955)) {
    _init();
  }

  void _saveLocation() {
    hiveProvider.setValue(
        kLastLocationKey, '${state.latitude}#${state.longitude}');
  }

  LatLng? _retrieveSave() {
    final found = hiveProvider.value(kLastLocationKey);
    logger.d('Previous location $found');
    if (found == null) {
      return null;
    }

    final splitted = found.split('#');
    final a = double.tryParse(splitted[0]), b = double.tryParse(splitted[1]);
    if (a == null || b == null) {
      logger.d('Could not parse previous location ($a, $b)');
      return null;
    }

    logger.d('Parse previous location ($a, $b)');
    return LatLng(a, b);
  }

  void _init() async {
    await hiveProvider.init(kLocationHive);
    final position = _retrieveSave() ?? (await determinePosition()).toLatLng();
    logger.d('Current location provider init : $position');
    state = position;
    _saveLocation();
  }

  Future<void> refreshLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    state = position.toLatLng();
    _saveLocation();
  }
}
