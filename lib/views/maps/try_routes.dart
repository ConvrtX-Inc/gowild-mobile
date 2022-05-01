import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animarker/core/ripple_marker.dart';
import 'package:flutter_animarker/flutter_map_marker_animation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gowild_mobile/constants/size.dart';
import 'package:gowild_mobile/views/maps/google_maps.dart';
import 'package:gowild_mobile/widgets/auth_widgets.dart';
import 'package:location/location.dart';
// import 'package:location/location.dart';

import '../../constants/colors.dart';
import '../../widgets/bottom_flat_button.dart';
import '../../widgets/bottom_nav_bar.dart';

//Setting dummies values
const kStartPosition = LatLng(18.488213, -69.959186);
const kSantoDomingo = CameraPosition(target: kStartPosition, zoom: 15);
const kMarkerId = MarkerId('MarkerId1');
const kDuration = Duration(seconds: 2);
const kLocations = [
  kStartPosition,
  LatLng(18.488101, -69.957995),
  LatLng(18.489210, -69.952459),
  LatLng(18.487307, -69.952759)
];

class TryRoutes extends StatefulWidget {
  bool? isProximity;
  TryRoutes({Key? key, this.isProximity}) : super(key: key);

  @override
  _TryRoutesState createState() => _TryRoutesState();
}

class _TryRoutesState extends State<TryRoutes> {
  final markers = <MarkerId, Marker>{};
  final gController = Completer<GoogleMapController>();
  final stream = Stream.periodic(kDuration, (count) => kLocations[count])
      .take(kLocations.length);
  bool state = false;
  FToast? fToast;
  bool? isProximity;
  late GoogleMapController controller;
  // Completer<GoogleMapController>? controller1;
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
  //static LatLng _center = LatLng(-15.4630239974464, 28.363397732282127);
  LatLng _initialPosition = const LatLng(14.5547, 121.0244);

  @override
  void initState() {
    super.initState();
    latlngSegment1.add(_lat1);
    latlngSegment1.add(_lat2);
    latlngSegment1.add(_lat3);
    latlngSegment1.add(_lat4);

    //line segment 2
    latlngSegment2.add(_lat4);
    latlngSegment2.add(_lat5);
    latlngSegment2.add(_lat6);
    latlngSegment2.add(_lat1);

    fToast = FToast();
    isProximity = widget.isProximity;
    // _getUserLocation();
  }

  void newLocationUpdate(LatLng latLng) {
    var marker = RippleMarker(
      markerId: kMarkerId,
      position: latLng,
      ripple: true,
    );
    setState(() => markers[kMarkerId] = marker);
  }

  void _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);

      print('${placemark[0].name}');
    });
    if (_initialPosition == _lastMapPosition) {
      setState(() {
        isProximity = true;
      });
    } else {
      setState(() {
        isProximity = false;
      });
      print('false prox');
    }
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
        children: [
          const Text("Go Wild"),
          const SizedBox(
            width: 12.0,
          ),
          const Text(
              "You are not in the proximity of the starting point of this route."),
        ],
      ),
    );
  }

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      controller = controllerParam;
      // controller1.animateCamera(CameraUpdate.newCameraPosition(
      //   CameraPosition(
      //     bearing: 50.0,
      //     target: _lastMapPosition,
      //     tilt: 10.0,
      //     zoom: 8.0,
      //   ),
      // ));

      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        //_lastMapPosition is any coordinate which should be your default
        //position when map opens up
        draggable: true,
        onDragEnd: ((newPosition) {
          print(newPosition.latitude);
          print(newPosition.longitude);
        }),
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
        draggable: true,
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

  _onCameraMove(CameraPosition position) {
    // _initialPosition = position.target;
    // (position) {
    //   setState(() {
    //     _markers.add(Marker(markerId: '', position: position.target));
    //   });
    // };
  }

  _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId(_lastMapPosition.toString()),
          position: _lastMapPosition,
          infoWindow: InfoWindow(
              title: "test", snippet: "This is a snippet", onTap: () {}),
          onTap: () {},
          icon: BitmapDescriptor.defaultMarker));
    });
  }

  Widget mapButton(Function function, Icon icon, Color color) {
    return RawMaterialButton(
      onPressed: (() => function),
      child: icon,
      shape: const CircleBorder(),
      elevation: 2.0,
      fillColor: color,
      padding: const EdgeInsets.all(7.0),
    );
  }

  bool atFinishLine = false;
  bool pressedStartProximity = false;
  bool atEndPoint = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlack,
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: true,
      floatingActionButton: const BottomFlatButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomNavBar(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: primaryYellow, size: 28),
        centerTitle: false,
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.30,
            child: CupertinoSwitch(
              value: state,
              activeColor: primaryOrange,
              onChanged: (value) {
                state = value;
                setState(() {});
              },
            ),
          ),
        ],
        title: Text(
          'TRY ROUTE',
          style: TextStyle(
              color: primaryYellow, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            pressedStartProximity ? showToast() : Container(),
            Row(
              children: [
                sizedBox(0, 30),
                const Text(
                  'ROUTE TEXT GOES HERE',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                ),
                sizedBox(0, 180),
                Container(
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
              ],
            ),
            Stack(children: [
              Column(
                children: [
                  sizedBox(30, 0),
                  atFinishLine
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Congratulations!',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Text(
                              'You Completed This Route.',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )
                          ],
                        )
                      : Container(),
                  sizedBox(30, 0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: atFinishLine
                        ? Container(
                            height: 600,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/autumn.png'),
                                fit: BoxFit.fill,
                              ),
                            ))
                        : SizedBox(
                            height: 600,
                            width: double.infinity,
                            child: atEndPoint
                                ? Animarker(
                                    curve: Curves.ease,
                                    mapId: gController.future.then<int>(
                                        (value) =>
                                            value.mapId), //Grab Google Map Id
                                    markers: markers.values.toSet(),
                                    child: GoogleMap(
                                      onCameraMove: _onCameraMove,
                                      // myLocationEnabled: true,
                                      compassEnabled: true,
                                      // myLocationButtonEnabled: isProximity! ? true : false,
                                      polylines: _polyline,
                                      markers: _markers,
                                      onMapCreated: isProximity!
                                          ? (controller) {
                                              stream.forEach((value) =>
                                                  newLocationUpdate(value));
                                              gController.complete(controller);
                                              //Complete the future GoogleMapController
                                            }
                                          : _onMapCreated,

                                      initialCameraPosition: isProximity!
                                          ? kSantoDomingo
                                          : CameraPosition(
                                              target: _lastMapPosition,
                                              zoom: 13),
                                      mapType: _currentMapType,
                                    ),
                                  )
                                : Stack(children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                        'assets/scroll.png',
                                        // height: ,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                        padding: const EdgeInsets.only(top: 40),
                                        alignment: Alignment.center,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              const Text(
                                                'Did You Know?',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 22.0),
                                              ),
                                              sizedBox(20, 0),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 80, right: 80),
                                                child: Text(
                                                  'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14.0),
                                                ),
                                              ),
                                              sizedBox(20, 0),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 80, right: 80),
                                                child: Text(
                                                  'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14.0),
                                                ),
                                              ),
                                              sizedBox(50, 0),
                                              Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 80, right: 80),
                                                  child: mainAuthButton(
                                                      context, 'Got It', () {
                                                    setState(() {
                                                      atFinishLine = true;
                                                    });
                                                  }))
                                            ],
                                          ),
                                        )),
                                  ])),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: FloatingActionButton(
                      heroTag: 'mapType',
                      onPressed: _onMapTypeButtonPressed,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.green,
                      child: const Icon(Icons.map, size: 12.0),
                    ),
                  ),
                  sizedBox(20, 0),
                  mainAuthButton(
                      context, atFinishLine ? 'Show My Results' : 'Start', () {
                    if (isProximity == false) {
                      setState(() {
                        pressedStartProximity = true;
                      });
                      Future.delayed(const Duration(seconds: 2), () {
                        setState(() {
                          pressedStartProximity = false;
                        });
                      });
                    } else {
                      setState(() {
                        atEndPoint = false;
                      });
                    }
                  })
                ],
              ),
            ])
          ],
        )),
      ),
    );
  }
}
