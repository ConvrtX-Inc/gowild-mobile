import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapTypeController extends GetxController {
  MapType mapType = MapType.normal;

  void setMapType(MapType type) {
    mapType = type;
    update();
  }
}
