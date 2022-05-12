import 'package:flutter/material.dart';

import '../services/dio_client.dart';

class MapHelper extends ChangeNotifier {
  double? endLat;
  double? endLong;
  bool isSwitched = false;
  // var markers = <Marker>[];
  List points = [];
  String setAsDefaultRoadMap = '';
  String setAsDefaultSatellite = '';
  String setAsDefaultTerrain = '';
  double? startLat;
  double? startLong;
  Future getRoutes() async {
    final routes = await DioClient().getRoute();
    // final user = await DioClient().getUser();

    // setState(() {
    startLat = routes.startPointLat;
    startLong = routes.startPointLong;
    endLat = routes.stopPointLat;
    endLong = routes.stopPointLong;
    points.add([startLat!, startLong]);
    points.add([endLat!, endLong!]);
    // });
    notifyListeners();
    // setState(() {});
  }
}
