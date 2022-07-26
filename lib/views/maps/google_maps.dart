import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:gowild_mobile/views/maps/map_overlay_setting.dart';
import 'package:provider/provider.dart';
import 'dart:math' show cos, sqrt, asin;

import '../../models/route.dart';
import '../../services/prefs_service.dart';
import '../../utils/getx/controllers/map_type_controller.dart';

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

  // var markers = <Marker>[];
  List points = [];
  String setAsDefaultRoadMap = '';
  String setAsDefaultSatellite = '';
  String setAsDefaultTerrain = '';
  double? startLat;
  double? startLong;
  late LatLng currentPostion = LatLng(0, 0);

  // MapController _mapController = MapController();
  final _preferenceService = PrefService();

  bool isLocationLoaded = false;
  final MapTypeController _mapTypeController = Get.put(MapTypeController());

  List<Marker> markers = [];

  GoogleMapController? _mapController;

  double zoomLevel = 17;

  @override
  void initState() {
    // TODO: implement initState
    getAllSavedData();
    // getRoutes = DioClient().getRoute();
    _getUserLocation();
    // _mapController = MapController();
    super.initState();
  }

  LatLng? _center;
  Position? currentLocation;

  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    var position = await GeolocatorPlatform.instance.getCurrentPosition();
    print("LOCATION => ${position.toJson()}");
    if (mounted) {
      setState(() {
        currentPostion = LatLng(position.latitude, position.longitude);
      });
      // _mapController.move(currentPostion, currentZoom);
      //
      // markers.add( Marker(
      //   width: 80.0,
      //   height: 80.0,
      //
      //   point: currentPostion,
      //   builder: (ctx) => const Icon(
      //     Icons.location_on,
      //     color: Colors.blue,
      //     size: 40,
      //   ),
      // ));

      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: currentPostion,
            zoom: 17,
          ),
        ),
      );
    }

    print("LOCATION LAT => ${currentPostion.longitude}");
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    _mapController = _cntlr;
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
    if (value.roadMapString != null) {
      setState(() {
        setAsDefaultRoadMap = value.roadMapString!;
        setAsDefaultTerrain = value.terrainString!;
        setAsDefaultSatellite = value.satelliteString!;
      });

      setState(() {});
    }
  }

  List<LatLng> getPointsApi(int index) {
    return points[index].map((e) => LatLng(e[1], e(0))).toList();
  }

/*  void _zoomAdd(LatLng currentCenter) {
    currentZoom = currentZoom + 1;
    _mapController.move(currentCenter, currentZoom);
  }

  void _zoomMinus(LatLng currentCenter) {
    currentZoom = currentZoom - 1;
    _mapController.move(currentCenter, currentZoom);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        GetBuilder<MapTypeController>(builder: (_controller) {
          debugPrint('maptype ${_controller.mapType}');
          return GoogleMap(
              onMapCreated: _onMapCreated,
              zoomControlsEnabled: false,
              zoomGesturesEnabled: true,
              tiltGesturesEnabled: true,
              mapType: _controller.mapType,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              initialCameraPosition: const CameraPosition(
                target: LatLng(0, 0),
                zoom: 4,
              ));
        })
        /*                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    plugins: [
                      TappablePolylineMapPlugin(),
                    ],

                    center: currentPostion,
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
                          subdomains: ['mt0', 'mt1', 'mt2', 'mt3']),
                    if (setAsDefaultSatellite.isNotEmpty)
                    //satellite
                      TileLayerOptions(
                          urlTemplate:
                          'http://{s}.google.com/vt/lyrs=s&x={x}&y={y}&z={z}',
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
                ),*/
        ,
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
                  /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const MapOverlay()));*/

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const MapOverlaySettingScreen()));
                },
              ),
            )),
        Positioned(
            top: 100,
            right: 45,
            child: InkWell(
              onTap: () => zoomLevel < 21 ? zoomIn() : null,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color:
                        zoomLevel < 21 ? Color(0xffC4C4C4) : Color(0xffD3D3D3)),
                child: Icon(
                  Icons.add,
                  color: zoomLevel < 21 ? Colors.black : Colors.grey,
                ),
              ),
            )),
        Positioned(
            top: 150,
            right: 45,
            child: InkWell(
              onTap: () =>zoomLevel >= 1 ? zoomOut() :null,
              child: Container(
                width: 30,
                height: 30,
                decoration:   BoxDecoration(
                    shape: BoxShape.rectangle, color:  zoomLevel >= 1 ? Color(0xffC4C4C4) : Color(0xffD3D3D3)),
                child:   Icon(
                  Icons.remove,
                  color:  zoomLevel >= 1 ? Colors.black : Colors.grey
                ),
              ),
            )),
      ]),
      /*child: FutureBuilder<Routes>(ture: getRoutes,
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

                            center: currentPostion,
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
                                  subdomains: ['mt0', 'mt1', 'mt2', 'mt3']),
                            if (setAsDefaultSatellite.isNotEmpty)
                            //satellite
                              TileLayerOptions(
                                  urlTemplate:
                                  'http://{s}.google.com/vt/lyrs=s&x={x}&y={y}&z={z}',
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
                  }),*/
    );
  }

  Future<void> zoomIn() async {
    var currentZoomLevel = await _mapController!.getZoomLevel();

    debugPrint('current zoom level $currentZoomLevel');

    currentZoomLevel += 2;

    _mapController?.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: currentPostion,
        zoom: currentZoomLevel,
      ),
    ));

    setState(() {
      zoomLevel = currentZoomLevel;
    });
  }

  Future<void> zoomOut() async {


   var currentZoomLevel = zoomLevel - 2;

   debugPrint('zoom level $zoomLevel');



    _mapController?.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: currentPostion,
        zoom: currentZoomLevel,
      ),
    ));

    setState(() {
      zoomLevel = currentZoomLevel;
    });
  }
}
