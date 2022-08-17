import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:gowild_mobile/constants/colors.dart';
import 'package:gowild_mobile/services/geolocation_service.dart';
import 'package:gowild_mobile/utils/ui/historical_dialogs.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../../models/historical_event.dart';
import '../../models/route.dart';
import '../../services/dio_client.dart';
import 'package:geofence_service/geofence_service.dart' as GS;

import '../../services/notifications_service.dart';
import '../../utils/map_bounds.dart';
import '../../widgets/auth_widgets.dart';

///Sample MapBox
class MapBox extends StatefulWidget {
  const MapBox({required this.route, Key? key}) : super(key: key);

  final Routes route;

  @override
  _MapBoxState createState() => _MapBoxState();
}

class _MapBoxState extends State<MapBox> {
  late MapboxMapController _mapController;

  late LatLng currentPosition;

  Location _location = Location();

  List myRoutes = [];

  late StreamSubscription<LocationData> locationSubscription;

  List<HistoricalEventModel> historicalEvents = [];

  List subRoutes = [];

  late LatLng startingPoint;

  late LatLng finishPoint;

  List<GS.Geofence> _geofenceList = <GS.Geofence>[];

  bool hasStarted = false;

  bool isStartPointInProximity = false;

  double startLat = 0, startLng = 0, endLat = 0, endLng = 0;

  String startRadiusId = 'radius_start_5m',
      endRadiusId = 'radius_finish_2m',
      historicalRadiusId = 'historical_radius_5m';

  double startProximityRadius = 3,
      finishProximityRadius = 2,
      historicalProximityRadius = 5;

  String routeName = '';

  // Create a [GeofenceService] instance and set options.
  final _geofenceService = GS.GeofenceService.instance.setup(
      interval: 5000,
      accuracy: 100,
      loiteringDelayMs: 60000,
      statusChangeDelayMs: 20000,
      useActivityRecognition: true,
      allowMockLocations: false,
      printDevLog: true,
      geofenceRadiusSortType: GS.GeofenceRadiusSortType.DESC);

  final _activityStreamController = StreamController<GS.Activity>();
  final _geofenceStreamController = StreamController<GS.Geofence>();

  bool isFinishPointInProximity = false;

  bool showNotif = false;

  double initialZoom = 17;

  String _routes = '';

  List<String> routeDirections =[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    startingPoint =
        LatLng(widget.route.startPointLat!, widget.route.startPointLong!);
    finishPoint =
        LatLng(widget.route.stopPointLat!, widget.route.stopPointLong!);

    startLat = widget.route.startPointLat!;
    startLng = widget.route.startPointLong!;

    endLat = widget.route.stopPointLat!;
    endLng = widget.route.stopPointLong!;
    routeName = widget.route.routeName!;

    _routes = '${widget.route.startPointLong},${widget.route.startPointLat};';

    routeDirections.add('${widget.route.startPointLong},${widget.route.startPointLat};');
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _geofenceService.addGeofenceStatusChangeListener(_onStatsChanged);
      _geofenceService.addLocationChangeListener(_onLocationUpdated);
      _geofenceService.addLocationServicesStatusChangeListener(
          _onLocationServicesStatusChanged);
      _geofenceService.addActivityChangeListener(_onActivityChanged);
      _geofenceService.addStreamErrorListener(_onError);

      debugPrint(
          'End Lat $endLat End long $endLng'); // Create geofence for Start and Finish Point
      setState(() {
        _geofenceList = [
          GS.Geofence(
            id: 'start_point',
            latitude: startLat,
            longitude: startLng,
            radius: [
              GS.GeofenceRadius(
                  id: startRadiusId, length: startProximityRadius),
            ],
          ),
          GS.Geofence(
            id: 'finish_point',
            latitude: endLat,
            longitude: endLng,
            radius: [
              GS.GeofenceRadius(
                  id: startRadiusId, length: startProximityRadius),
            ],
          ),
        ];
      });

      debugPrint(
          'Geofence lisrt ${_geofenceList[1].latitude} ${_geofenceList[1].longitude} $endLat End long $endLat $endLng'); //
      showLoadingIndicator();
      getHistoricalEvents();
    });
  }

  @override
  void dispose() {
    locationSubscription.cancel();
    _geofenceService.clearAllListeners();
    _geofenceService.stop();
    super.dispose();
  }

  // ---- START GEOFENCE SERVICE FUNCTIONS
  /*
  *  This function is to be called when the geofence status is changed.
  *  This will determine if the user Enters / Exits
  * */
  Future<void> _onStatsChanged(
      GS.Geofence geofence,
      GS.GeofenceRadius geofenceRadius,
      GS.GeofenceStatus geofenceStatus,
      GS.Location location) async {
    debugPrint('geofence: ${geofence.toJson()}');
    debugPrint('geofenceRadius: ${geofenceRadius.toJson()}');
    debugPrint('geofenceStatus: ${geofenceStatus.toString()}');

    if (geofence.id == 'start_point') {
      // Listen on Start Point Geofence
      if (geofenceStatus == GS.GeofenceStatus.ENTER) {
        setState(() {
          isStartPointInProximity = true;
        });
      }
    } else if (geofence.id == 'finish_point') {
      //Listen on  Finish Point Geofence
      if (hasStarted) {
        if (geofenceStatus == GS.GeofenceStatus.ENTER) {
          setState(() {
            isFinishPointInProximity = true;
          });
          NotificationService().showAndroidNotification(
              1, 'Congratulations!', 'You completed $routeName.');

          locationSubscription.cancel();
        }
      }
    } else {
      if (geofenceStatus == GS.GeofenceStatus.ENTER) {
        // Listen on Historical Event Geofence
        if (hasStarted) {
          showHistoricalEvent(geofence.id);
        }
      }
    }

    _geofenceStreamController.sink.add(geofence);
  }

  // This function is to be called when the activity has changed.
  void _onActivityChanged(GS.Activity prevActivity, GS.Activity currActivity) {
    print('prevActivity: ${prevActivity.toJson()}');
    print('currActivity: ${currActivity.toJson()}');
    _activityStreamController.sink.add(currActivity);
  }

  // This function is to be called when the location has changed.
  void _onLocationUpdated(GS.Location location) {
    print('location: ${location}');

    setState(() {
      currentPosition = LatLng(location.latitude, location.longitude);
      /* markers[const MarkerId('myLocation')] = Marker(
          markerId: const MarkerId('myLocation'),
          position: LatLng(location.latitude, location.longitude),
          icon: currentLocationIcon,

          // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
          infoWindow: InfoWindow(title: 'My Current Location'));*/
    });
  }

  // This function is to be called when a location services status change occurs
  // since the service was started.
  void _onLocationServicesStatusChanged(bool status) {
    print('isLocationServicesEnabled: $status');
  }

  // This function is used to handle errors that occur in the service.
  void _onError(error) {
    final errorCode = GS.getErrorCodesFromError(error);
    if (errorCode == null) {
      print('Undefined error: $error');
      return;
    }

    print('ErrorCode: $errorCode');
  }

  // --- END GEOFENCE SERVICE FUNCTION

  _onMapCreated(MapboxMapController controller) async {
    setState(() {
      _mapController = controller;
    });

    debugPrint(
      'Start Point: $startLng $startLat',
    );

    // moveCamera(initialZoom, startingPoint);

    locationSubscription = _location.onLocationChanged.listen((l) {
      debugPrint('current Location ${l.latitude}');
      setState(() {
        currentPosition = LatLng(l.latitude!, l.longitude!);
        myRoutes.add([l.longitude, l.latitude]);
      });

      drawOwnRoutePath();
    });


  }

  Future<void> getUserLocation() async {
    final Position currentLocation =
        await GeoLocationServices().getCoordinates();

    setState(() {
      currentPosition =
          LatLng(currentLocation.latitude, currentLocation.longitude);
    });


    subRoutes.add([widget.route.startPointLong, widget.route.startPointLat!]);

  }


  Future<void> onStyleLoadedCallback(List<dynamic> routes) async {
    debugPrint('Subroutes: ${routes.length}');
    var geometry = {"coordinates": routes, "type": "LineString"};

    final _fills = {
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "id": 0,
          "properties": <String, dynamic>{},
          "geometry": geometry,
        },
      ],
    };

    // Add new source and lineLayer
    await _mapController.addSource(
        "fills", GeojsonSourceProperties(data: _fills));
    await _mapController.addLineLayer(
      "fills",
      "lines",
      const LineLayerProperties(
        lineColor: '#03AA46',
        lineCap: "round",
        lineJoin: "round",
        lineWidth: 8,
        lineOpacity: 0.8
      ),
    );

    // Add start point and finish point circle Markers
    addCircles(routes[0],routes[routes.length - 1]);

  }


  /// Adds an asset image to the currently displayed style
  Future<void> addImageFromAsset(String name, String assetName) async {
    final bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return _mapController.addImage(name, list);
  }



  void addCircles(List<dynamic> startPoints, List<dynamic>finishPoints){


    var geometryStart = {"coordinates":  startPoints, "type": "Point"};
    var geometryEnd = {"coordinates": finishPoints, "type": "Point"};

    final _startFills = {
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "id": 1,
          "properties": <String, dynamic>{},
          "geometry": geometryStart,
        },

      ],
    };

    // Add new source and lineLayer
     _mapController.addGeoJsonSource(
        "start_circle_fills",  _startFills);

    _mapController.addCircleLayer(
      "start_circle_fills",
      "start_circles",
      CircleLayerProperties(
        circleRadius: 8,
        circleStrokeWidth: 2,
        circleStrokeColor: Colors.white.toHexStringRGB(),

        circleColor: Colors.black.toHexStringRGB(),
      ),
    );


    final _endFills = {
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "id": 3,
          "properties": <String, dynamic>{},
          "geometry": geometryEnd,
        },

      ],
    };

    // Add new source and lineLayer
    _mapController.addGeoJsonSource(
        "end_circle_fills",  _endFills);

    _mapController.addCircleLayer(
      "end_circle_fills",
      "end_circles",
      CircleLayerProperties(
        circleRadius: 8,
        circleStrokeWidth: 3,
        circleStrokeColor: Colors.white.toHexStringRGB(),

        circleColor: Colors.red.toHexStringRGB(),
      ),
    );


  }

  // original
  Future<void> _onStyleLoadedCallback() async {
    debugPrint('Subroutes: ${subRoutes.length}');
    var geometry = {"coordinates": subRoutes, "type": "LineString"};

    final _fills = {
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "id": 0,
          "properties": <String, dynamic>{},
          "geometry": geometry,
        },
      ],
    };

    // Add new source and lineLayer
    await _mapController.addSource(
        "fills", GeojsonSourceProperties(data: _fills));
    await _mapController.addLineLayer(
      "fills",
      "lines",
      LineLayerProperties(
          lineColor: '#03AA46',
          lineCap: "round",
          lineJoin: "round",
          lineWidth: 8,
          lineOpacity: 0.8
      ),


     /* LineLayerProperties(
        lineColor: Colors.indigo.toHexStringRGB(),
        lineCap: "round",
        lineJoin: "round",
        lineWidth: 3,
      ),*/
    );

    addCircles([startLng,startLat],[endLng,endLat]);

  }

  Future<void> drawOwnRoutePath() async {
    var geometry = {"coordinates": myRoutes, "type": "LineString"};

    final _fills = {
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "id": 1,
          "properties": <String, dynamic>{},
          "geometry": geometry,
        },
      ],
    };

    if (myRoutes.isNotEmpty) {
      await _mapController.removeLayer("my_lines");
      await _mapController.removeSource("my_fills");
    }

    // Add new source and lineLayer
    await _mapController.addSource(
        "my_fills", GeojsonSourceProperties(data: _fills));

    await _mapController.addLineLayer(
      "my_fills",
      "my_lines",
      LineLayerProperties(
        lineColor: Colors.red.toHexStringRGB(),
        lineCap: "round",
        lineJoin: "round",
        lineWidth: 3,
      ),
    );
  }

  // This will get historical events from api and create sub routes ( temporary fix)
  Future<void> _getHistoricalEvents() async {
    final HistoricalEventModelList res =
        await DioClient().getHistoricalEvents(widget.route.id);

    debugPrint("Historical ${res.historicalEventList.length}");

    if (res.historicalEventList.isNotEmpty) {
      subRoutes.add([
        widget.route.startPointLong,
        widget.route.startPointLat,
      ]);
      for (HistoricalEventModel event in res.historicalEventList) {
        if (event.eventTitle!.toLowerCase() != 'point') {
          _mapController.addSymbol(
            SymbolOptions(
                geometry: LatLng(event.eventLat!, event.eventLong!),
                iconSize: 2,
                iconImage: "assets/images/pngs/historical_event_point.png",
                zIndex: 0),
          );

          final geofence = GS.Geofence(
            id: event.id!,
            latitude: event.eventLat!,
            longitude: event.eventLong!,
            radius: [
              GS.GeofenceRadius(
                  id: historicalRadiusId, length: historicalProximityRadius),
            ],
          );

          _geofenceList.add(geofence);

          historicalEvents.add(event);
        }

        subRoutes.add([
          event.eventLong!,
          event.eventLat!,
        ]);
      }

      subRoutes.add([widget.route.stopPointLong, widget.route.stopPointLat]);
    }

    _onStyleLoadedCallback();

    _mapController.moveCamera(
      CameraUpdate.newLatLngBounds(
        MapUtils().boundsFromLatLngList([startingPoint, finishPoint]),
        left: 100,
        right: 100,
        top: 100,
        bottom: 100,
      ),
    );



    // Start geofencing services
    _geofenceService.start(_geofenceList).catchError(_onError);

    Navigator.of(context).pop();
  }

  Future<void> getHistoricalEvents() async {
    final HistoricalEventModelList res =
        await DioClient().getHistoricalEvents(widget.route.id);

    debugPrint("Historical ${res.historicalEventList.length}");

    // String routes = '${widget.route.startPointLong},${widget.route.startPointLat};';

    if (res.historicalEventList.isNotEmpty) {
      subRoutes.add([
        widget.route.startPointLong,
        widget.route.startPointLat,
      ]);

      for (HistoricalEventModel event in res.historicalEventList) {
        if (event.eventTitle!.toLowerCase() != 'point') {


          _mapController.addSymbol(
            SymbolOptions(
                geometry: LatLng(event.eventLat!, event.eventLong!),
                iconSize: 2,
                iconImage: "assets/images/pngs/historical_event_point.png",
                zIndex: 0),
          );

          final geofence = GS.Geofence(
            id: event.id!,
            latitude: event.eventLat!,
            longitude: event.eventLong!,
            radius: [
              GS.GeofenceRadius(
                  id: historicalRadiusId, length: historicalProximityRadius),
            ],
          );

          _geofenceList.add(geofence);

          historicalEvents.add(event);
        }

        subRoutes.add([
          event.eventLong!,
          event.eventLat!,
        ]);
        setState(() {
          // _routes = '${event.eventLong!},${event.eventLat!};';
          routeDirections.add('${event.eventLong!},${event.eventLat!};');
        });

      }

      subRoutes.add([widget.route.stopPointLong, widget.route.stopPointLat]);
    }

    setState(() {
      routeDirections.add('${widget.route.stopPointLong},${widget.route.stopPointLat}');
    });




    _mapController.moveCamera(
      CameraUpdate.newLatLngBounds(
        MapUtils().boundsFromLatLngList([startingPoint, finishPoint]),
        left: 100,
        right: 100,
        top: 100,
        bottom: 100,
      ),
    );


    // Start geofencing services
    _geofenceService.start(_geofenceList).catchError(_onError);

    // final String routes = getDirectionRoute();

    setState(() {
      _routes = routeDirections.join();
    });


    debugPrint('routeDATA ${routeDirections.length} $_routes');

    final directions =  await DioClient().getMapDirections(_routes);

    debugPrint('directions $directions');

    if(directions != ''){
      onStyleLoadedCallback(directions);
    }else{
      _onStyleLoadedCallback();
    }



    Navigator.of(context).pop();
  }

  String getDirectionRoute() {
    String routes = '';

    return routes;
  }

  // Show Historical Event Dialog
  void showHistoricalEvent(String id) {
    HistoricalEventModel event = historicalEvents.firstWhere(
        (element) => element.id == id,
        orElse: () => HistoricalEventModel());

    if (event.id!.isNotEmpty) {
      HistoricalDialogs().showPlainText(context, event.description!);
    }
  }

  void addStyles() {
    _mapController.addSource(
        "dem",
        RasterDemSourceProperties(
            url: "mapbox://mapbox.mapbox-terrain-dem-v1"));

    _mapController.addLayer(
      "dem",
      "hillshade",
      HillshadeLayerProperties(
          hillshadeExaggeration: 1,
          hillshadeShadowColor: Colors.blue.toHexStringRGB()),
    );
  }


  _showSnackBar(String type, String id) {
    final snackBar = SnackBar(
        content: Text('Tapped $type $id',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).primaryColor);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Try Route'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            _geofenceService.stop();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: primaryYellow,
          iconSize: 28,
        ),
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.30,
            child: CupertinoSwitch(
              value: showNotif,
              activeColor: kprimaryOrange,
              onChanged: (value) {
                showNotif = value;
                setState(() {});
              },
            ),
          ),
        ],
      ),
      body: buildMapUI(),

    );
  }

  void moveCamera(double zoom, LatLng target) {
    _mapController.moveCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: target,
        zoom: zoom,
      ),
    ));
  }

  Widget buildMapUI() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(children: [
          // pressedStartProximity ? showToast() : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  routeName,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 30),
                child: GestureDetector(
                  onTap: () async {
                    // showLoadingIndicator();
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    height: 40,
                    width: 75,
                    padding: const EdgeInsets.all(5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xffEC6537),
                      border: Border.all(
                          color: const Color(0xffEC6537),
                          width: 1.0), // Set border width
                      borderRadius: const BorderRadius.all(
                          Radius.circular(10.0)), // Set rounded corner radius
                    ),
                    child: const Text(
                      " Details ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(child:

            buildMapbox()
          ),


          SizedBox(height: 25),
          if (!hasStarted)
            mainAuthButton(context,
                isFinishPointInProximity ? 'Show My Results' : 'Start Route',
                () async {
              if (!isStartPointInProximity) {
                await NotificationService().showAndroidNotification(
                    1,
                    'Go Wild',
                    'You are not in the proximity of the starting point of this route.');
              } else {
                setState(() {
                  hasStarted = true;
                });

                // _addMarker();
              }
              moveCamera(17, currentPosition);
            }),
        ]));
  }

  Widget buildMapbox() => Stack(
        children: <Widget>[
          SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 1.55 ,
                  width: MediaQuery.of(context).size.width,
                  child: MapboxMap(
                    tiltGesturesEnabled: true,
                    compassEnabled: true,
                    zoomGesturesEnabled: true,

                    // styleString: MapboxStyles.OUTDOORS,
                    accessToken:
                        "sk.eyJ1IjoiZWRuYW1hZWciLCJhIjoiY2w2N2ZicGUyMDh4ODNjbzF2OHFxaDBoZCJ9.Rbc3CvVizlE0HRMP8oPSDg",
                    initialCameraPosition:
                        CameraPosition(target: LatLng(0, 0), zoom: 10),
                    myLocationEnabled: true,
                    myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
                    onMapCreated: _onMapCreated,
                    onStyleLoadedCallback: addStyles,
                  ),
                )),
          ),
          Positioned(
            right: 0,
            child: IconButton(
                onPressed: () => moveCamera(17, currentPosition),
                icon: Icon(Icons.my_location, color: Colors.blueGrey)),
          ),
        ],
      );

  void showLoadingIndicator() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            CircularProgressIndicator(color: const Color(0xffEC6537)),
            SizedBox(
              height: 12,
            ),
            Text('Loading Route. Please wait...')
          ],
        ));
      },
    );
  }
}
