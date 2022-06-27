import 'dart:async';import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gowild_mobile/constants/size.dart';
import 'package:gowild_mobile/models/directions.dart';
import 'package:gowild_mobile/models/historical_event.dart';
import 'package:gowild_mobile/models/route.dart';
import 'package:gowild_mobile/services/notifications_service.dart';
import 'package:gowild_mobile/utils/ui/historical_dialogs.dart';
import 'package:gowild_mobile/widgets/auth_widgets.dart';
import 'package:location/location.dart';
import 'package:gowild_mobile/constants/colors.dart';
import 'package:gowild_mobile/services/dio_client.dart';
import 'directions_repository.dart';
import 'package:geofence_service/geofence_service.dart' as GS;

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
  Directions? directionsInfo;
  Location _location = Location();

  String geofenceStatus = '';

  double radiusInMeters = 10;

  bool isStartPointInProximity = false;
  bool isFinishPointInProximity = false;

  String routeId = '';
  bool hasStarted = false;

  bool isLoadingResources = true;

  String radiusId = 'radius_10m';

  List<Circle> _circles =[];

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

  // Create a [Geofence] list . Save (start point , end point and historical events)
  List<GS.Geofence> _geofenceList = <GS.Geofence>[];

  List<HistoricalEventModel> historicalEvents = [];

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

      // Create geofence for Start and Finish Point
      setState(() {
        _geofenceList = [
          GS.Geofence(
            id: 'start_point',
            latitude: startLat!,
            longitude: startLong!,
            radius: [
              GS.GeofenceRadius(id: radiusId, length: radiusInMeters),
            ],
          ),
          GS.Geofence(
            id: 'finish_point',
            latitude: endLat!,
            longitude: endLong!,
            radius: [
              GS.GeofenceRadius(id: radiusId, length: radiusInMeters),
            ],
          ),
        ];
      });

      //LOAD MAP RESOURCES
      loadMapResources();
    });

    startLat = widget.route.startPointLat!;
    startLong = widget.route.startPointLong!;
    endLat = widget.route.stopPointLat!;
    endLong = widget.route.stopPointLong!;
    routeText = widget.route.routeName!;
    isProximity = widget.isProximity!;
    routeId = widget.route.id;
  }

  ///GEOFENCE SERVICES
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
              1, 'Congratulations!', 'You completed $routeText.');
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
    _geofenceService.stop();
    super.dispose();
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }

  //MAP CREATED LISTENER
  void _onMapCreated(GoogleMapController _cntlr) async {
     _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      if (hasStarted) {
        _controller!.animateCamera(
         /* directionsInfo != null
              ? CameraUpdate.newLatLngBounds(directionsInfo!.bounds, 100.0)
              :
          */
          CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: LatLng(l.latitude!, l.longitude!), zoom: 18),
                ),
        );
      }
    });
  }

  // Load all of resources needed for map/routes
  void loadMapResources() {
    //show loading indicator
    showLoadingIndicator();

    // add Start and End Point Markers
    addStartAndFinishPointMarkers();

    // create start and finish point circles
    createStartAndFinishPointCircles();

    // get Directions
    getDirections();

    // get Historical Events
    getHistoricalEvents();
  }

  // This will get historical events from api
  Future<void> getHistoricalEvents() async {
    final HistoricalEventModelList res =
    await DioClient().getHistoricalEvents(routeId);

    if (res.historicalEventList.isNotEmpty) {
      for (HistoricalEventModel event in res.historicalEventList) {
        final geofence = GS.Geofence(
          id: event.id!,
          latitude: event.eventLat!,
          longitude: event.eventLong!,
          radius: [
            GS.GeofenceRadius(id: radiusId, length: radiusInMeters),
          ],
        );

        _geofenceList.add(geofence);
      }

      setState(() {
        historicalEvents = res.historicalEventList;
      });
    }

    // Add Historical Event Markers and Circles
    addHistoricalEventMarkersAndCircles();

    // Start geofencing services
    _geofenceService.start(_geofenceList).catchError(_onError);

    // Hide Loading Indicator Dialog
    setState(() {
      isLoadingResources = false;
    });

    Navigator.of(context).pop();
  }

  // Get Directions Details from start and finish point
  Future<void> getDirections() async {
    if (directionsInfo == null) {
      final directions = await DirectionsRepository().getDirections(
          origin: LatLng(startLat!, startLong!), destination: endLocation);
      setState(() => directionsInfo = directions);

      if (directionsInfo != null) {
        _controller!.animateCamera(
            CameraUpdate.newLatLngBounds(directionsInfo!.bounds, 100.0));
      }
    }
  }

  // Add Start And Finish Point Markers
  void addStartAndFinishPointMarkers() {
    final marker = [
      Marker(
        markerId: const MarkerId('startpoint'),
        position: LatLng(startLat!, startLong!),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        infoWindow: const InfoWindow(
          title: 'Start Point',
          snippet: '',
        ),
      ),
      Marker(
        markerId: const MarkerId('finishpoint'),
        position: LatLng(endLat!, endLong!),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: const InfoWindow(
          title: 'Finish Point',
          snippet: '',
        ),
      ),
    ];

    //START AND FINISH POINT MARKERS
    setState(() {
      markers[const MarkerId('startpoint')] = marker.last;
      markers[const MarkerId('endpoint')] = marker.first;
    });
  }

  // Add Markers for Historical Events
  addHistoricalEventMarkersAndCircles() async {
    for (HistoricalEventModel event in historicalEvents) {
      final marker = Marker(
        markerId: MarkerId(event.id!),
        position: LatLng(event.eventLat!, event.eventLong!),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      );

      final circle =  Circle( circleId: CircleId(event.id!),
        center: LatLng(event.eventLat!, event.eventLong!),
        radius: radiusInMeters,
        fillColor: Colors.yellow.shade100.withOpacity(0.5),
        strokeColor:  Colors.yellow.shade100.withOpacity(0.1),
      );

      _circles.add(circle);

      setState(() {
        markers[MarkerId(event.id!)] = marker;
      });
    }
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

  //create start and Finish point circles
  void createStartAndFinishPointCircles (){
    setState(() {
      _circles = [
        Circle( circleId: CircleId('startPointCircle'),
          center: LatLng(startLat!,startLong!),
          radius: radiusInMeters,
          fillColor: Colors.orange.shade100.withOpacity(0.5),
          strokeColor:  Colors.orange.shade100.withOpacity(0.1),
        ),
        Circle( circleId: CircleId('finshPointCircle'),
          center: LatLng(endLat!,endLong!),
          radius: radiusInMeters,
          fillColor: Colors.red.shade100.withOpacity(0.5),
          strokeColor:  Colors.red.shade100.withOpacity(0.1),
        ),
      ];
    });
  }


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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            _geofenceService.stop();
            Navigator.pop(context);
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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              // pressedStartProximity ? showToast() : Container(),
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
              if (directionsInfo != null &&
                  !isFinishPointInProximity &&
                  hasStarted)
                Text(
                  removeAllHtmlTags(directionsInfo!.steps[0]),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),

              if (isFinishPointInProximity && hasStarted)
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
                          circles: Set.from(_circles),
                          polylines: {
                            if (directionsInfo != null)
                              Polyline(
                                polylineId:
                                    const PolylineId('overview_polyline'),
                                color: Colors.red,
                                width: 5,
                                points: directionsInfo!.polylinePoints
                                    .map((e) => LatLng(e.latitude, e.longitude))
                                    .toList(),
                              ),
                          },
                          mapType: MapType.normal,
                          myLocationEnabled: true,
                        ),
                      ))),

              SizedBox(height: 25),
              if (!hasStarted)
                mainAuthButton(
                    context,
                    isFinishPointInProximity
                        ? 'Show My Results'
                        : 'Start Route', () async {
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
                }),

              sizedBox(20, 0),
            ],
          ),
        )),
      ),
    );
  }

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
