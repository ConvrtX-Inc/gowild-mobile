import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapTypeController extends GetxController {
  MapType mapType = MapType.normal;

  String mapStyle =  MapboxStyles.OUTDOORS;

  void setMapType(MapType type) {
    mapType = type;
    update();
  }

  void setMapStyle (String style){
    mapStyle = style;
    update();
  }
}
