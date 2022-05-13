import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tappable_polyline/flutter_map_tappable_polyline.dart';
import 'package:gowild_mobile/constants/colors.dart';
import 'package:gowild_mobile/helper/authentication_helper.dart';
import 'package:gowild_mobile/services/dio_client.dart';
import 'package:gowild_mobile/views/maps/map_overlay.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'dart:math' show cos, sqrt, asin;

import '../../models/route.dart';
import '../../services/prefs_service.dart';
import 'data.dart';

class MyGoogleMap extends StatefulWidget {
  const MyGoogleMap({Key? key}) : super(key: key);

  @override
  _MyGoogleMapState createState() => _MyGoogleMapState();
}

class _MyGoogleMapState extends State<MyGoogleMap> {
  double currentZoom = 11.0;
  double? endLat;
  double? endLong;
  bool isSwitched = false;
  var markers = <Marker>[];
  List points = [];
  String setAsDefaultRoadMap = '';
  String setAsDefaultSatellite = '';
  String setAsDefaultTerrain = '';
  double? startLat;
  double? startLong;

  MapController _mapController = MapController();
  final _preferenceService = PrefService();

  @override
  void initState() {
    // TODO: implement initState
    getAllSavedData();
    getRoutes = DioClient().getRoute();
    _mapController = MapController();
    super.initState();
  }

  late Future<Routes> getRoutes;
  // Future getRoutes() async {
  //   // var helper = Provider.of<AuthenticationHelper>(context, listen: false);
  //   final routes = await DioClient().getRoute();
  //   // final user = await DioClient().getUser();

  //   setState(() {
  //     startLat = routes.startPointLat;
  //     startLong = routes.startPointLong;
  //     endLat = routes.stopPointLat;
  //     endLong = routes.stopPointLong;
  //     points.add([startLat!, startLong]);
  //     points.add([endLat!, endLong!]);
  //   });
  //   // setState(() {});
  // }

  Future getAllSavedData() async {
    final value = await _preferenceService.getMapType();

    setState(() {
      setAsDefaultRoadMap = value.roadMapString!;
      setAsDefaultTerrain = value.terrainString!;
      setAsDefaultSatellite = value.satelliteString!;
    });

    setState(() {});
  }

  List<LatLng> getPointsApi(int index) {
    return points[index].map((e) => LatLng(e[1], e(0))).toList();
  }

  void _zoomAdd(LatLng currentCenter) {
    currentZoom = currentZoom + 1;
    _mapController.move(currentCenter, currentZoom);
  }

  void _zoomMinus(LatLng currentCenter) {
    currentZoom = currentZoom - 1;
    _mapController.move(currentCenter, currentZoom);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            Flexible(
              child: FutureBuilder<Routes>(
                  future: getRoutes,
                  builder: (context, AsyncSnapshot<Routes> snapshot) {
                    LatLng currentCenter = LatLng(
                        snapshot.data?.startPointLat ?? 0.0,
                        snapshot.data?.startPointLong ?? 0.0);
                    LatLng endCenter = LatLng(
                        snapshot.data?.stopPointLat ?? 0.0,
                        snapshot.data?.stopPointLong ?? 0.0);
                    markers = [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: endCenter,
                        builder: (ctx) => const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: currentCenter,
                        builder: (ctx) => const Icon(
                          Icons.location_on,
                          color: Colors.blue,
                          size: 40,
                        ),
                      ),
                    ];
                    if (snapshot.hasData) {
                      return Stack(children: [
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
                            interactiveFlags: InteractiveFlag.pinchZoom |
                                InteractiveFlag.drag,
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
                                  // TaggedPolyline(
                                  //   tag: '1st Polyline',
                                  //   // An optional tag to distinguish polylines in callback
                                  //   points: getPointsApi(1),
                                  //   color: Colors.red,
                                  //   strokeWidth: 9.0,
                                  // ),
                                  // TaggedPolyline(
                                  //   tag: '2nd Polyline',
                                  //   // An optional tag to distinguish polylines in callback
                                  //   points: getPointsApi(1),
                                  //   color: Colors.black,
                                  //   strokeWidth: 3.0,
                                  // ),
                                  // TaggedPolyline(
                                  //   tag: '3rd Polyline',
                                  //   // An optional tag to distinguish polylines in callback
                                  //   points: getPoints(0),
                                  //   color: Colors.blue,
                                  //   strokeWidth: 3.0,
                                  // ),
                                ],
                                onTap: (polylines, tapPosition) => print(
                                    'Tapped: ' +
                                        polylines
                                            .map((polyline) => polyline.tag)
                                            .join(',') +
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
                                          builder: (context) =>
                                              const MapOverlay()));
                                },
                              ),
                            )),
                        Positioned(
                            top: 100,
                            right: 45,
                            child: InkWell(
                              onTap: () => _zoomAdd(currentCenter),
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Color(0xffC4C4C4)),
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
                              onTap: () => _zoomMinus(currentCenter),
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Color(0xffC4C4C4)),
                                child: const Icon(
                                  Icons.remove,
                                  color: Colors.black,
                                ),
                              ),
                            )),
                      ]);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    // Positioned(
                    //     top: 40,
                    //     left: 40,
                    //     child: Switch(
                    //       value: isSwitched,
                    //       onChanged: (value) {
                    //         setState(() {
                    //           isSwitched = value;
                    //         });
                    //       },
                    //       activeTrackColor: kprimaryOrange,
                    //       activeColor: Colors.white,
                    //     )),
                  }),
            ),
          ],
        ));
  }
}
