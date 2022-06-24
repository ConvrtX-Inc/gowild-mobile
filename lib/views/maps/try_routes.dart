import 'dart:async';

// import 'package:easy_geofencing/enums/geofence_status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
//     as bg;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gowild_mobile/constants/image_constants.dart';
import 'package:gowild_mobile/constants/size.dart';
import 'package:gowild_mobile/models/directions.dart';
import 'package:gowild_mobile/models/historical_event.dart';
import 'package:gowild_mobile/services/notifications_service.dart';
import 'package:gowild_mobile/utils/ui/historical_dialogs.dart';
import 'package:gowild_mobile/views/maps/google_maps.dart';
import 'package:gowild_mobile/widgets/auth_widgets.dart';
import 'package:location/location.dart';
import 'package:easy_geofencing/easy_geofencing.dart';
import '../../constants/colors.dart';
import '../../models/route.dart';
import '../../services/dio_client.dart';
import '../../widgets/bottom_flat_button.dart';
import '../../widgets/bottom_nav_bar.dart';
import 'directions_repository.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:convert';

import 'package:geofence_service/geofence_service.dart' as GS;

JsonEncoder encoder = new JsonEncoder.withIndent("     ");

class TryRoutes extends StatefulWidget {
  TryRoutes({Key? key, this.isProximity, required this.route})
      : super(key: key);

  double? endLat;
  double? endLong;
  bool? isProximity;
  final Routes route;
  String? routeText;
  double? startLat;
  double? startLong;

  @override
  _TryRoutesState createState() => _TryRoutesState();
}

class _TryRoutesState extends State<TryRoutes> {
  // late StreamController<bool> isOpenStreamController;

  StreamController<GS.GeofenceStatus>? geofenceStatusStreamController =
      StreamController<GS.GeofenceStatus>.broadcast();
  bool atEndPoint = true;
  bool atFinishLine = false;
  LatLng? currentPostion;
  double? endLat;
  late LatLng endLocation = LatLng(endLat!, endLong!);
  double? endLong;
  late Future<RouteList> getRoutes;
  bool? isProximity;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  bool pressedStartProximity = false;
  String? routeText;
  double? startLat;
  late LatLng startLocation = LatLng(startLat!, startLong!);
  double? startLong;
  bool state = false;
  StreamSubscription<GS.GeofenceStatus>? geofenceStatusStream;
  GoogleMapController? _controller;
  Directions? _info;
  Location _location = Location();
  bool? _isMoving;
  bool? _enabled;
  String? _motionActivity;
  String? _odometer;
  String? _content;

  // StreamSubscription<GeofenceStatus>? geofenceStatusStream;
  String geofenceStatus = '';

  double radiusInMeters = 50;

  bool isStartPointInProximity = false;
  bool isFinishPointInProximity = false;

  ///GEOFENCE_SERVICE
  final _activityStreamController = StreamController<GS.Activity>();
  final _geofenceStreamController = StreamController<GS.Geofence>();

  // Create a [GeofenceService] instance and set options.
  final _geofenceService = GS.GeofenceService.instance.setup(
      interval: 5000,
      accuracy: 100,
      loiteringDelayMs: 60000,
      statusChangeDelayMs: 10000,
      useActivityRecognition: true,
      allowMockLocations: false,
      printDevLog: false,
      geofenceRadiusSortType: GS.GeofenceRadiusSortType.DESC);

  // Create a [Geofence] list.
  List<GS.Geofence> _geofenceList = <GS.Geofence>[];

  //Static data
  List<HistoricalEventModel> historicalEvents = [
    HistoricalEventModel(
        id: '111',
        eventLat: 15.1783,
        eventLong: 120.5189,
        eventTitle: 'Did you know? 1',
        description: 'This is a Test Description 1'),
    HistoricalEventModel(
        id: '222',
        eventLat: 15.1761,
        eventLong: 120.5208,
        eventTitle: 'Did you know? 2',
        description: 'This is a Test Description 2'),
    HistoricalEventModel(
        id: '333',
        eventLat: 15.1766,
        eventLong: 120.5277,
        eventTitle: 'Did you know? 3',
        description: 'This is a Test Description 3')
  ];

  final notWithinStartPointNotification = SnackBar(
    content: const Text(
        'You are not in the proximity of the starting point of this route.'),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _geofenceService.addGeofenceStatusChangeListener(_onStatsChanged);
      _geofenceService.addLocationChangeListener(_onLocationUpdated);
      _geofenceService.addLocationServicesStatusChangeListener(
          _onLocationServicesStatusChanged);
      _geofenceService.addActivityChangeListener(_onActivityChanged);
      _geofenceService.addStreamErrorListener(_onError);

      setState(() {
        _geofenceList = [
          GS.Geofence(
            id: 'start_point',
            latitude: startLat!,
            longitude: startLong!,
            radius: [
              GS.GeofenceRadius(id: 'radius_50m', length: radiusInMeters),
            ],
          ),
          GS.Geofence(
            id: 'finish_point',
            latitude: endLat!,
            longitude: endLong!,
            radius: [
              GS.GeofenceRadius(id: 'radius_50m', length: radiusInMeters),
            ],
          ),
        ];
      });

      addHistoricalEventsGeofence();
      _geofenceService.start(_geofenceList).catchError(_onError);
    });
    // TODO: implement initState
    // getRoutes = DioClient().getRoutes();
    // _getUserLocation();

    startLat = widget.route.startPointLat!;
    startLong = widget.route.startPointLong!;
    endLat = widget.route.stopPointLat!;
    endLong = widget.route.stopPointLong!;
    routeText = widget.route.routeName!;
    isProximity = widget.isProximity!;

    _isMoving = false;
    _enabled = false;
    _content = '';
    _motionActivity = 'UNKNOWN';
    _odometer = '0';

    // createStartingPointRegion();

    // 1.  Listen to events (See docs for all 12 available events).
    // bg.BackgroundGeolocation.onLocation(_onLocation);
    // bg.BackgroundGeolocation.onMotionChange(_onMotionChange);
    // bg.BackgroundGeolocation.onActivityChange(_onActivityChange);
    // bg.BackgroundGeolocation.onProviderChange(_onProviderChange);
    // bg.BackgroundGeolocation.onConnectivityChange(_onConnectivityChange);
    // // 2.  Configure the plugin
    // bg.BackgroundGeolocation.ready(bg.Config(
    //         desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
    //         distanceFilter: 10.0,
    //         stopOnTerminate: false,
    //         startOnBoot: true,
    //         debug: true,
    //         logLevel: bg.Config.LOG_LEVEL_VERBOSE,
    //         reset: true))
    //     .then((bg.State state) {
    //   setState(() {
    //     _enabled = state.enabled;
    //     _isMoving = state.isMoving;
    //   });
    // });
  }

/*  void _onClickEnable(enabled) {
    if (enabled) {
      bg.BackgroundGeolocation.start().then((bg.State state) {
        print('[start] success $state');
        setState(() {
          _enabled = state.enabled;
          _isMoving = state.isMoving;
        });
      });
    } else {
      bg.BackgroundGeolocation.stop().then((bg.State state) {
        print('[stop] success: $state');
        // Reset odometer.
        bg.BackgroundGeolocation.setOdometer(0.0);

        setState(() {
          _odometer = '0.0';
          _enabled = state.enabled;
          _isMoving = state.isMoving;
        });
      });
    }
  }

  // Manually toggle the tracking state:  moving vs stationary
  void _onClickChangePace() {
    setState(() {
      _isMoving = !_isMoving!;
    });
    print("[onClickChangePace] -> $_isMoving");

    bg.BackgroundGeolocation.changePace(_isMoving!).then((bool isMoving) {
      print('[changePace] success $isMoving');
    }).catchError((e) {
      print('[changePace] ERROR: ' + e.code.toString());
    });
  }

  // Manually fetch the current position.
  void _onClickGetCurrentPosition() {
    bg.BackgroundGeolocation.getCurrentPosition(
            persist: false, // <-- do not persist this location
            desiredAccuracy: 0, // <-- desire best possible accuracy
            timeout: 30000, // <-- wait 30s before giving up.
            samples: 3 // <-- sample 3 location before selecting best.
            )
        .then((bg.Location location) {
      setState(() {
        currentPostion = location.coords as LatLng;
      });
      _addMarker();
      print('[getCurrentPosition] - $location');
    }).catchError((error) {
      print('[getCurrentPosition] ERROR: $error');
    });
  }
  // Event handlers
  //

  void _onLocation(bg.Location location) {
    print('[location] - $location');

    String odometerKM = (location.odometer / 1000.0).toStringAsFixed(1);

    setState(() {
      _content = encoder.convert(location.toMap());
      _odometer = odometerKM;
    });
  }

  void _onMotionChange(bg.Location location) {
    print('[motionchange] - $location');
  }

  void _onActivityChange(bg.ActivityChangeEvent event) {
    print('[activitychange] - $event');
    setState(() {
      _motionActivity = event.activity;
    });
  }

  void _onProviderChange(bg.ProviderChangeEvent event) {
    print('$event');

    setState(() {
      _content = encoder.convert(event.toMap());
    });
  }

  void _onConnectivityChange(bg.ConnectivityChangeEvent event) {
    print('$event');
  }*/

  ///GEOFENCE SERVICES

  // This function is to be called when the geofence status is changed.
  Future<void> _onStatsChanged(
      GS.Geofence geofence,
      GS.GeofenceRadius geofenceRadius,
      GS.GeofenceStatus geofenceStatus,
      GS.Location location) async {
    debugPrint('geofence: ${geofence.toJson()}');
    debugPrint('geofenceRadius: ${geofenceRadius.toJson()}');
    debugPrint('geofenceStatus: ${geofenceStatus.toString()}');

    if (geofence.id == 'start_point') {
      setState(() {
        isStartPointInProximity = true;
      });
    } else if (geofence.id == 'finish_point') {
      setState(() {
        isFinishPointInProximity = true;
      });
    } else {
      if(geofenceStatus == GS.GeofenceStatus.ENTER){
        debugPrint('SHOW HISTORICAL EVENT');
        HistoricalDialogs().showPlainText(context, geofence.id);
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

  @override
  void dispose() {
    geofenceStatusStream?.cancel();
    EasyGeofencing.stopGeofenceService();
    super.dispose();
  }

  showToast() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 50.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Go Wild"),
          SizedBox(
            width: 12.0,
          ),
          Text(
              "You are not in the proximity of the starting point of this route."),
        ],
      ),
    );
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  bool isReady = false;

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

    setState(() {
      currentPostion = LatLng(position.latitude, position.longitude);
    });
    // _addGeofence();
  }

  bool geoFenceSuccess = false;

  // void _addGeofence() {
  //   bg.BackgroundGeolocation.addGeofence(bg.Geofence(
  //     identifier: 'HOME',
  //     radius: 150,
  //     latitude: startLat!,
  //     longitude: startLong!,
  //     notifyOnEntry: true, // only notify on entry
  //     notifyOnExit: false,
  //     notifyOnDwell: false,
  //     loiteringDelay: 30000, // 30 seconds
  //   )).then((bool success) {
  //     print(success);
  //     if (success == true) {
  //       setState(() {
  //         geoFenceSuccess = success;
  //       });
  //     } else {
  //       setState(() {
  //         geoFenceSuccess = success;
  //       });
  //     }

  //     print(
  //         '[addGeofence] success with $startLat and ${currentPostion!.longitude}');
  //   }).catchError((error) {
  //     print('[addGeofence] FAILURE: $error');
  //   });
  // }

  void _onMapCreated(GoogleMapController _cntlr) async {
    debugPrint('Map created');
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller!.animateCamera(
        _info != null
            ? CameraUpdate.newLatLngBounds(_info!.bounds, 100.0)
            : CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(l.latitude!, l.longitude!), zoom: 15),
              ),
      );
    });

    /* final marker = [
      Marker(
        markerId: const MarkerId('finishpoint'),
        position: LatLng(endLat!, endLong!),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: const InfoWindow(
          title: ' end here',
          snippet: '',
        ),
      ),
      Marker(
        markerId: const MarkerId('startpoint'),

        position: LatLng(startLat!, startLong!),
        // icon: BitmapDescriptor.,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),

        infoWindow: const InfoWindow(
          title: 'start here..',
          snippet: '',
        ),
      ),
    ];

    setState(() {
      markers[const MarkerId('startpoint')] = marker.last;
      markers[const MarkerId('endpoint')] = marker.first;
    });*/
  }

  void _addMarker() async {
    debugPrint('add Marker...');
    if (_info == null) {
      final directions = await DirectionsRepository().getDirections(
          origin: LatLng(startLat!, startLong!), destination: endLocation);
      setState(() => _info = directions);

      if (_info != null) {
        final marker = [
          Marker(
            markerId: const MarkerId('finishpoint'),
            position: LatLng(endLat!, endLong!),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            infoWindow: const InfoWindow(
              title: ' end here',
              snippet: '',
            ),
          ),
          Marker(
            markerId: const MarkerId('startpoint'),

            position: LatLng(startLat!, startLong!),
            // icon: BitmapDescriptor.,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueOrange),

            infoWindow: const InfoWindow(
              title: 'start here..',
              snippet: '',
            ),
          ),
        ];

        setState(() {
          markers[const MarkerId('startpoint')] = marker.last;
          markers[const MarkerId('endpoint')] = marker.first;
        });

        addHistoricalEventMarkers();
      }
    }
  }

  addHistoricalEventsGeofence() {
    for (HistoricalEventModel event in historicalEvents) {
      final geofence = GS.Geofence(
        id: event.id!,
        latitude: event.eventLat!,
        longitude: event.eventLong!,
        radius: [
          GS.GeofenceRadius(id: 'radius_50m', length: radiusInMeters),
        ],
      );

      _geofenceList.add(geofence);
    }
  }

  addHistoricalEventMarkers() async {
    for (HistoricalEventModel event in historicalEvents) {
      final marker = Marker(
        markerId: MarkerId(event.id!),
        position: LatLng(event.eventLat!, event.eventLong!),
        // icon: BitmapDescriptor.,

        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),

        // icon: await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(200, 200)), '${ImageAssetPath.imagePathPng}historical_event_icon.png')
      );

      setState(() {
        markers[MarkerId(event.id!)] = marker;
      });
    }
  }

  bool geoFenceFound = false;

  @override
  Widget build(BuildContext context) {
    var _initialCameraPosition = CameraPosition(
      target: currentPostion ?? startLocation,
      zoom: 12,
    );

    return Scaffold(
      backgroundColor: primaryBlack,
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: true,
      // floatingActionButton: const BottomFlatButton(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: const BottomNavBar(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            // EasyGeofencing.stopGeofenceService();
            // geofenceStatusStream!.cancel();

            Navigator.pop(context);

            // WidgetsBinding.instance?.addPostFrameCallback((_) {

            // });
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: primaryYellow,
          iconSize: 28,
        ),
        // iconTheme: const IconThemeData(color: primaryYellow, size: 28),
        centerTitle: false,
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.30,
            child: CupertinoSwitch(
              value: state,
              activeColor: kprimaryOrange,
              onChanged: (value) {
                state = value;
                setState(() {});
              },
            ),
          ),
        ],
        title: const Text(
          'TRY ROUTE',
          style: TextStyle(
              color: primaryYellow, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            // physics: const NeverScrollableScrollPhysics(),
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              pressedStartProximity ? showToast() : Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      routeText ?? '',
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
                        // await  NotificationService().showAndroidNotification();
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
                          borderRadius: const BorderRadius.all(Radius.circular(
                              10.0)), // Set rounded corner radius
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

              sizedBox(20, 0),
              if (_info != null && !isFinishPointInProximity)
                Text(
                  removeAllHtmlTags(_info!.steps[0]),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),

              if (isFinishPointInProximity)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      'Congratulations!',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      'You Completed This Route.',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                ),
              sizedBox(20, 0),
              // atFinishLine
              //     ? Column(
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: const [
              //           Text(
              //             'Congratulations!',
              //             style: TextStyle(
              //                 color: Colors.white, fontSize: 18),
              //           ),
              //           Text(
              //             'You Completed This Route.',
              //             style: TextStyle(
              //                 color: Colors.white, fontSize: 18),
              //           )
              //         ],
              //       )
              //     : Container(),

              // FutureBuilder<RouteList>(
              //     future: getRoutes,
              //     builder: (context, AsyncSnapshot<RouteList> snapshot) {
              //       if (snapshot.hasData) {
              //         return ClipRRect(
              //             borderRadius: BorderRadius.circular(30.0),
              //             child:
              //                 // atEndPoint
              //                 //     ? Container(
              //                 //         height: 600,
              //                 //         width: double.infinity,
              //                 //         decoration: BoxDecoration(
              //                 //           image: DecorationImage(
              //                 //             image: AssetImage('assets/autumn.png'),
              //                 //             fit: BoxFit.fill,
              //                 //           ),
              //                 //         ))
              //                 // :
              //                 SizedBox(
              //                     height: 600,
              //                     width: double.infinity,
              //                     child: isProximity!
              //                         ? GoogleMap(
              //                             myLocationButtonEnabled: true,
              //                             zoomControlsEnabled: true,
              //                             zoomGesturesEnabled: true,
              //                             tiltGesturesEnabled: false,
              //                             initialCameraPosition:
              //                                 _initialCameraPosition,
              //                             onMapCreated: _onMapCreated,
              //                             // polylines:
              //                             //     Set<Polyline>.of(polylines.values),
              //                             markers: markers.values.toSet(),

              //                             polylines: {
              //                               if (_info != null)
              //                                 Polyline(
              //                                   polylineId: const PolylineId(
              //                                       'overview_polyline'),
              //                                   color: Colors.red,
              //                                   width: 5,
              //                                   points: _info!.polylinePoints
              //                                       .map((e) => LatLng(
              //                                           e.latitude,
              //                                           e.longitude))
              //                                       .toList(),
              //                                 ),
              //                             },
              //                             // onLongPress: _addMarker,
              //                             // initialCameraPosition:
              //                             //     CameraPosition(target: startLocation),
              //                             mapType: MapType.normal,

              //                             // onMapCreated: _onMapCreated,
              //                             myLocationEnabled: true,

              //                             // markers: markers.values.toSet(),
              //                           )
              //                         : const MyGoogleMap()));

              //         // : Stack(children:
              //         //     Container(
              //         //       alignment: Alignment.center,
              //         //       child: Image.asset(
              //         //         'assets/scroll.png',
              //         //         // height: ,
              //         //         width: double.infinity,
              //         //         fit: BoxFit.cover,
              //         //       ),
              //         //     )

              //       } else {
              //         return Center(child: CircularProgressIndicator());
              //       }
              //     }

              //     Container(
              //         padding: const EdgeInsets.only(top: 40),
              //         alignment: Alignment.center,
              //         child: SingleChildScrollView(
              //           child: Column(
              //             children: [
              //               const Text(
              //                 'Did You Know?',
              //                 style: TextStyle(
              //                     color: Colors.black,
              //                     fontWeight: FontWeight.bold,
              //                     fontSize: 22.0),
              //               ),
              //               sizedBox(20, 0),
              //               const Padding(
              //                 padding: EdgeInsets.only(
              //                     left: 80, right: 80),
              //                 child: Text(
              //                   'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
              //                   style: TextStyle(
              //                       color: Colors.black,
              //                       fontWeight:
              //                           FontWeight.bold,
              //                       fontSize: 14.0),
              //                 ),
              //               ),
              //               sizedBox(20, 0),
              //               const Padding(
              //                 padding: EdgeInsets.only(
              //                     left: 80, right: 80),
              //                 child: Text(
              //                   'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
              //                   style: TextStyle(
              //                       color: Colors.black,
              //                       fontWeight:
              //                           FontWeight.bold,
              //                       fontSize: 14.0),
              //                 ),
              //               ),

              SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        width: double.infinity,
                        child: GoogleMap(
                          myLocationButtonEnabled: true,
                          zoomControlsEnabled: true,
                          zoomGesturesEnabled: true,
                          tiltGesturesEnabled: true,
                          initialCameraPosition: _initialCameraPosition,
                          onMapCreated: _onMapCreated,
                          markers: markers.values.toSet(),
                          polylines: {
                            if (_info != null)
                              Polyline(
                                polylineId:
                                    const PolylineId('overview_polyline'),
                                color: Colors.red,
                                width: 5,
                                points: _info!.polylinePoints
                                    .map((e) => LatLng(e.latitude, e.longitude))
                                    .toList(),
                              ),
                          },
                          mapType: MapType.normal,
                          myLocationEnabled: true,
                        ),
                      ))),

              SizedBox(height: 25),
              if (!isFinishPointInProximity)
                mainAuthButton(
                    context, atFinishLine ? 'Show My Results' : 'Start Route',
                    // _onClickGetCurrentPosition
                    () {
                  /*    if (currentPostion != startLocation) {
                  _addMarker();
                  print(geoFenceSuccess);
                  setState(() {
                    pressedStartProximity = true;
                  });
                  Future.delayed(const Duration(seconds: 2), () {
                    setState(() {
                      pressedStartProximity = false;
                    });
                  });
                } else {
                  debugPrint('Add Marker..');
                  _addMarker();
                }*/

                  // _addMarker();

                  // listenOnStartPointGeofence();

                  if (!isStartPointInProximity) {
                    setState(() {
                      pressedStartProximity = true;
                    });
                    Future.delayed(const Duration(seconds: 2), () {
                      setState(() {
                        pressedStartProximity = false;
                      });
                    });
                  } else {
                    _addMarker();
                  }
                }),
              /*   Column(

                        children: [

                    ]),*/

              // Container(
              //     padding: const EdgeInsets.only(left: 80, right: 80),
              //     child: mainAuthButton(context, 'Got It', () {
              //       setState(() {
              //         atFinishLine = true;
              //       });
              //     })),

              sizedBox(20, 0),
            ],
          ),
        )),
      ),
    );
  }

  void createStartingPointRegion() {
    EasyGeofencing.startGeofenceService(
        pointedLatitude: startLat.toString(),
        pointedLongitude: startLong.toString(),
        radiusMeter: radiusInMeters.toString(),
        eventPeriodInSeconds: 5);
  }

  void createEndpointRegion() {
    debugPrint('Create End point region');
    EasyGeofencing.startGeofenceService(
        pointedLatitude: endLat.toString(),
        pointedLongitude: endLong.toString(),
        radiusMeter: radiusInMeters.toString(),
        eventPeriodInSeconds: 5);
  }

/* void listenOnStartPointGeofence() {


    geofenceStatusStream ??=
        EasyGeofencing.getGeofenceStream()!.listen((GeofenceStatus status) {
      print('GEOFENCE STATUS: ${geofenceStatus} ${status.name}');
      setState(() {
        geofenceStatus = status.toString();
      });

      if (status != GeofenceStatus.init) {
        if (status.name == GeofenceStatus.enter.name) {
          _addMarker();


          geofenceStatusStream!.cancel();
          EasyGeofencing.stopGeofenceService();

          // Create End point Geofence
          createEndpointRegion();
          listenOnFinishPointGeofence();
        } else {
          pressedStartProximity = true;
          Future.delayed(const Duration(seconds: 2), () {
            setState(() {
              pressedStartProximity = false;
            });
          });
          // EasyGeofencing.stopGeofenceService();
          geofenceStatusStream!.cancel();
        }
      }
    });
  }

  void listenOnFinishPointGeofence() {

    debugPrint('Listen on Endpoint Geofence...');
    geofenceStatusStream ??=
        EasyGeofencing.getGeofenceStream()!.listen((GeofenceStatus status) {
          print('GEOFENCE STATUS::: ${geofenceStatus} ${status.name}');
          setState(() {
            geofenceStatus = status.toString();
          });

          if (status != GeofenceStatus.init) {
            if (status.name == GeofenceStatus.enter.name) {
               debugPrint('Completed Finish Line!');

            } else {
              debugPrint('Not yet on Finish Line!');
            }
          }
        });
  }*/
}
