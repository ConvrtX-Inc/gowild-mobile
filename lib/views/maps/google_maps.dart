import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gowild_mobile/constants/size.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' show cos, sqrt, asin;

import '../../services/prefs_service.dart';

class MyGoogleMap extends StatefulWidget {
  const MyGoogleMap({Key? key}) : super(key: key);

  @override
  _MyGoogleMapState createState() => _MyGoogleMapState();
}

class _MyGoogleMapState extends State<MyGoogleMap> {
  late GoogleMapController controller;
  List<LatLng> latlngSegment1 = [];
  List<LatLng> latlngSegment2 = [];

  static const LatLng _lat1 = LatLng(13.035606, 77.562381);
  static const LatLng _lat2 = LatLng(14.090930, 77.693071);
  static const LatLng _lat3 = LatLng(12.970387, 77.693621);
  static const LatLng _lat4 = LatLng(12.858433, 77.575691);
  static const LatLng _lat5 = LatLng(12.948029, 77.472936);
  static const LatLng _lat6 = LatLng(13.069280, 77.455844);

  final LatLng _lastMapPosition = _lat1;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  String distance = '';
  @override
  void initState() {
    super.initState();
    //line segment 1
    latlngSegment1.add(_lat1);
    latlngSegment1.add(_lat2);
    latlngSegment1.add(_lat3);
    latlngSegment1.add(_lat4);

    //line segment 2
    latlngSegment2.add(_lat4);
    latlngSegment2.add(_lat5);
    latlngSegment2.add(_lat6);
    latlngSegment2.add(_lat1);

    calculateDistance(
        _lat1.latitude, _lat1.longitude, _lat2.latitude, _lat2.longitude);
    // mapType();
  }

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      controller = controllerParam;
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 50.0,
          target: _lastMapPosition,
          tilt: 10.0,
          zoom: 8.0,
        ),
      ));

      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        //_lastMapPosition is any coordinate which should be your default
        //position when map opens up
        position: _lastMapPosition,
        infoWindow: const InfoWindow(
          title: 'Start here',
          snippet: 'details',
        ),
      ));
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lat2.toString()),
        //_lastMapPosition is any coordinate which should be your default
        //position when map opens up
        position: _lat2,
        infoWindow: const InfoWindow(
          title: 'End here',
          snippet: 'details',
        ),
      ));

      _polyline.add(Polyline(
        polylineId: const PolylineId('line1'),
        visible: true,
        //latlng is List<LatLng>
        points: latlngSegment1,
        width: 6,
        color: Colors.blue,
      ));
      //different sections of polyline can have different colors
      _polyline.add(Polyline(
        polylineId: const PolylineId('line2'),
        visible: true,
        //latlng is List<LatLng>
        points: latlngSegment2,
        width: 6,
        color: Colors.red,
      ));
    });
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((_lat2.latitude - _lat1.latitude) * p) / 2 +
        c(_lat1.latitude * p) *
            c(_lat2.latitude * p) *
            (1 - c((_lat2.longitude - _lat1.longitude) * p)) /
            2;
    final dis = 12742 * asin(sqrt(a));
    setState(() {
      distance = dis.truncate().toString();
    });
    return dis;
  }

  final _preferenceService = PrefService();
  MapType? _mapType;

  Future mapType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('roadMapString');
    await prefs.remove('terrainString');
    await prefs.remove('satelliteString');
    final value = await _preferenceService.getMapType();

    if (value.roadMapString == 'roadMapString') {
      setState(() => _mapType = MapType.normal);

      print(_mapType);
    } else if (value.terrainString == 'terrainString') {
      setState(() => _mapType = MapType.terrain);

      print(_mapType);
    } else if (value.satelliteString == 'satelliteString') {
      setState(() => _mapType = MapType.satellite);

      print(_mapType);
    } else {
      print('no');
    }
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: const Alignment(0.0, 0.0), children: [
        GoogleMap(
          zoomGesturesEnabled: false,
          scrollGesturesEnabled: false,
          tiltGesturesEnabled: false,
          rotateGesturesEnabled: false,
          zoomControlsEnabled: false,
          polylines: _polyline,
          markers: _markers,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _lastMapPosition,
            zoom: 7.0,
          ),
          mapType: MapType.satellite,
        ),
        sizedBox(20, 0),
        Center(
          child: Text(
            '$distance KM',
            style: const TextStyle(fontSize: 22, color: Colors.white),
          ),
        ),
      ]),
    );
  }
}
