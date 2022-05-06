import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tappable_polyline/flutter_map_tappable_polyline.dart';
import 'package:gowild_mobile/constants/colors.dart';
import 'package:gowild_mobile/views/maps/map_overlay.dart';
import 'package:latlong2/latlong.dart';
import 'dart:math' show cos, sqrt, asin;

import '../../services/prefs_service.dart';
import 'data.dart';

class MyGoogleMap extends StatefulWidget {
  const MyGoogleMap({Key? key}) : super(key: key);

  @override
  _MyGoogleMapState createState() => _MyGoogleMapState();
}

class _MyGoogleMapState extends State<MyGoogleMap> {
  var markers = <Marker>[];
  final _preferenceService = PrefService();
  String setAsDefaultRoadMap = '';
  String setAsDefaultTerrain = '';
  String setAsDefaultSatellite = '';
  bool isSwitched = false;
  double currentZoom = 11.0;
  MapController _mapController = MapController();
  LatLng currentCenter = LatLng(45.1313258, 5.5171205);

  void _zoomAdd() {
    currentZoom = currentZoom + 1;
    _mapController.move(currentCenter, currentZoom);
  }

  void _zoomMinus() {
    currentZoom = currentZoom - 1;
    _mapController.move(currentCenter, currentZoom);
  }

  @override
  void initState() {
    // TODO: implement initState
    getAllSavedData();
    _mapController = MapController();
    super.initState();
  }

  Future getAllSavedData() async {
    final value = await _preferenceService.getMapType();
    setState(() {
      setAsDefaultRoadMap = value.roadMapString!;
      setAsDefaultTerrain = value.terrainString!;
      setAsDefaultSatellite = value.satelliteString!;
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    markers = [
      Marker(
        width: 80.0,
        height: 80.0,
        point: getPoints(0).first,
        builder: (ctx) => const Icon(
          Icons.location_on,
          color: Colors.red,
          size: 40,
        ),
      ),
      Marker(
        width: 80.0,
        height: 80.0,
        point: getPoints(1).last,
        builder: (ctx) => const Icon(
          Icons.location_on,
          color: Colors.black,
          size: 40,
        ),
      ),
      Marker(
        width: 80.0,
        height: 80.0,
        point: getPoints(1).first,
        builder: (ctx) => const Icon(
          Icons.location_on,
          color: Colors.blue,
          size: 40,
        ),
      ),
    ];
    return Scaffold(
        body: Column(
      children: [
        Container(
          child: Flexible(
            child: Stack(children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  plugins: [
                    TappablePolylineMapPlugin(),
                  ],
                  center: currentCenter,
                  zoom: currentZoom,
                  minZoom: 8.0,
                  maxZoom: 12.0,
                  // center: LatLng(lat, lng),
                  interactiveFlags:
                      InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                ),
                layers: [
                  if (setAsDefaultRoadMap.isNotEmpty)
                    //road
                    TileLayerOptions(
                        urlTemplate:
                            'http://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                        // maxZoom: 20,
                        subdomains: ['mt0', 'mt1', 'mt2', 'mt3']),
                  if (setAsDefaultSatellite.isNotEmpty)
                    //satellite
                    TileLayerOptions(
                        urlTemplate:
                            'http://{s}.google.com/vt/lyrs=s&x={x}&y={y}&z={z}',
                        // maxZoom: 20,
                        subdomains: ['mt0', 'mt1', 'mt2', 'mt3']),
                  if (setAsDefaultTerrain.isNotEmpty)
                    //terrain
                    TileLayerOptions(
                        urlTemplate:
                            'http://{s}.google.com/vt/lyrs=p&x={x}&y={y}&z={z}',
                        // maxZoom: 20,
                        subdomains: ['mt0', 'mt1', 'mt2', 'mt3']),
                  if (setAsDefaultRoadMap.isEmpty &&
                      setAsDefaultSatellite.isEmpty &&
                      setAsDefaultTerrain.isEmpty)
                    TileLayerOptions(
                        urlTemplate:
                            'http://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                        // maxZoom: 20,
                        subdomains: ['mt0', 'mt1', 'mt2', 'mt3']),
                  MarkerLayerOptions(
                    markers: markers,
                  ),
                  TappablePolylineLayerOptions(
                      // Will only render visible polylines, increasing performance
                      polylineCulling: true,
                      pointerDistanceTolerance: 20,
                      polylines: [
                        TaggedPolyline(
                          tag: '1st Polyline',
                          // An optional tag to distinguish polylines in callback
                          points: getPoints(0),
                          color: Colors.red,
                          strokeWidth: 9.0,
                        ),
                        TaggedPolyline(
                          tag: '2nd Polyline',
                          // An optional tag to distinguish polylines in callback
                          points: getPoints(1),
                          color: Colors.black,
                          strokeWidth: 3.0,
                        ),
                        TaggedPolyline(
                          tag: '3rd Polyline',
                          // An optional tag to distinguish polylines in callback
                          points: getPoints(0),
                          color: Colors.blue,
                          strokeWidth: 3.0,
                        ),
                      ],
                      onTap: (polylines, tapPosition) => print('Tapped: ' +
                          polylines.map((polyline) => polyline.tag).join(',') +
                          ' at ' +
                          tapPosition.globalPosition.toString()),
                      onMiss: (tapPosition) {
                        print('No polyline was tapped at position ' +
                            tapPosition.globalPosition.toString());
                      })
                ],
              ),
              Positioned(
                  top: 40,
                  right: 40,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: IconButton(
                      icon: const Icon(
                        Icons.map,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MapOverlay()));
                      },
                    ),
                  )),
              Positioned(
                  top: 100,
                  right: 45,
                  child: InkWell(
                    onTap: _zoomAdd,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                          shape: BoxShape.rectangle, color: Color(0xffC4C4C4)),
                      child: const Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    ),
                  )),
              Positioned(
                  top: 150,
                  right: 45,
                  child: InkWell(
                    onTap: _zoomMinus,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                          shape: BoxShape.rectangle, color: Color(0xffC4C4C4)),
                      child: const Icon(
                        Icons.remove,
                        color: Colors.black,
                      ),
                    ),
                  )),
              Positioned(
                  top: 40,
                  left: 40,
                  child: Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });
                    },
                    activeTrackColor: kprimaryOrange,
                    activeColor: Colors.white,
                  )),
            ]),
          ),
        ),
      ],
    ));
  }
}
