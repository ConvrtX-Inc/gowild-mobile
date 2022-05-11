import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

// import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gowild_mobile/constants/secret.dart';
import 'package:gowild_mobile/constants/size.dart';
import 'package:gowild_mobile/models/directions.dart';
import 'package:gowild_mobile/views/main_screen.dart';
import 'package:gowild_mobile/views/maps/google_maps.dart';
import 'package:gowild_mobile/widgets/auth_widgets.dart';
import 'package:location/location.dart';
// import 'package:location/location.dart';

import '../../constants/colors.dart';
import '../../models/route.dart';
import '../../services/dio_client.dart';
import '../../widgets/bottom_flat_button.dart';
import '../../widgets/bottom_nav_bar.dart';
import 'directions_repository.dart';

class TryRoutes extends StatefulWidget {
  TryRoutes(
      {Key? key,
      this.isProximity,
      this.endLat,
      this.endLong,
      this.routeText,
      this.startLat,
      this.startLong})
      : super(key: key);

  double? endLat;
  double? endLong;
  bool? isProximity;
  String? routeText;
  double? startLat;
  double? startLong;

  @override
  _TryRoutesState createState() => _TryRoutesState();
}

class _TryRoutesState extends State<TryRoutes> {
  bool atEndPoint = true;
  bool atFinishLine = false;
  double? endLat;
  late LatLng endLocation = LatLng(endLat!, endLong!);
  double? endLong;
  bool? isProximity;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  bool pressedStartProximity = false;
  String? routeText;
  double? startLat;
  late LatLng startLocation = LatLng(startLat!, startLong!);
  double? startLong;
  bool state = false;

  GoogleMapController? _controller;
  MapType _currentMapType = MapType.normal;
  Marker? _destination;
  Directions? _info;
  Location _location = Location();
  Marker? _origin;
  final Set<Polyline> _polyline = {};

  // Set<Marker> markers = Set();
  @override
  void initState() {
    super.initState();
    // TODO: implement initState

    // getDirections();
    startLat = widget.startLat;
    startLong = widget.startLong;
    endLat = widget.endLat;
    endLong = widget.endLong;
    routeText = widget.routeText;
    isProximity = widget.isProximity;
  }

  // Future<void> getDirections(LatLng pos) async {
  //   final directions = await DirectionsRepository()
  //       .getDirections(origin: _origin!.position, destination: pos);
  //   setState(() => _info = directions);
  //   print(_info);
  // }

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

  // GoogleMapController? _googleMapController;

  // @override
  // void dispose() {
  //   _googleMapController!.dispose();
  //   super.dispose();
  // }

  void _onMapCreated(GoogleMapController _cntlr) async {
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

    final marker = [
      Marker(
        markerId: MarkerId('endpoint'),
        position: LatLng(endLat!, endLong!),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: InfoWindow(
          title: ' end here',
          snippet: '',
        ),
      ),
      Marker(
        markerId: MarkerId('startpoint'),
        position: LatLng(startLat!, startLong!),
        // icon: BitmapDescriptor.,
        infoWindow: InfoWindow(
          title: 'start here',
          snippet: 'address',
        ),
      ),
    ];

    setState(() {
      markers[const MarkerId('startpoint')] = marker.last;
      markers[const MarkerId('endpoint')] = marker.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _initialCameraPosition = CameraPosition(
      target: LatLng(startLat!, startLong!),
      zoom: 11.5,
    );

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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            // WidgetsBinding.instance?.addPostFrameCallback((_) {

            // });
          },
          icon: Icon(Icons.arrow_back_ios),
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
            child: Column(
          children: [
            pressedStartProximity ? showToast() : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // sizedBox(0, 1),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    routeText ?? '',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                // sizedBox(0, 180),

                Padding(
                  padding: const EdgeInsets.only(right: 30),
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
              ],
            ),
            Stack(children: [
              Column(
                children: [
                  sizedBox(30, 0),
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
                  sizedBox(30, 0),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child:
                          // atEndPoint
                          //     ? Container(
                          //         height: 600,
                          //         width: double.infinity,
                          //         decoration: BoxDecoration(
                          //           image: DecorationImage(
                          //             image: AssetImage('assets/autumn.png'),
                          //             fit: BoxFit.fill,
                          //           ),
                          //         ))
                          // :
                          SizedBox(
                              height: 600,
                              width: double.infinity,
                              child: isProximity!
                                  ? GoogleMap(
                                      myLocationButtonEnabled: true,
                                      zoomControlsEnabled: true,
                                      zoomGesturesEnabled: true,
                                      tiltGesturesEnabled: false,
                                      initialCameraPosition:
                                          _initialCameraPosition,
                                      onMapCreated: _onMapCreated,
                                      // polylines:
                                      //     Set<Polyline>.of(polylines.values),
                                      markers: {
                                        // if (_origin != null) _origin!,
                                        // if (_destination != null)
                                        //   _destination!
                                        // else
                                        markers.values.toSet().first,
                                      },

                                      polylines: {
                                        if (_info != null)
                                          Polyline(
                                            polylineId: const PolylineId(
                                                'overview_polyline'),
                                            color: Colors.red,
                                            width: 5,
                                            points: _info!.polylinePoints
                                                .map((e) => LatLng(
                                                    e.latitude, e.longitude))
                                                .toList(),
                                          ),
                                      },
                                      // onLongPress: _addMarker,
                                      // initialCameraPosition:
                                      //     CameraPosition(target: startLocation),
                                      mapType: MapType.normal,

                                      // onMapCreated: _onMapCreated,
                                      myLocationEnabled: true,

                                      // markers: markers.values.toSet(),
                                    )
                                  : const MyGoogleMap())),
                  // : Stack(children: [
                  //     Container(
                  //       alignment: Alignment.center,
                  //       child: Image.asset(
                  //         'assets/scroll.png',
                  //         // height: ,
                  //         width: double.infinity,
                  //         fit: BoxFit.cover,
                  //       ),
                  //     ),
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
                  sizedBox(50, 0),
                  // Container(
                  //     padding: const EdgeInsets.only(left: 80, right: 80),
                  //     child: mainAuthButton(context, 'Got It', () {
                  //       setState(() {
                  //         atFinishLine = true;
                  //       });
                  //     })),

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
                      // _addMarker(endLocation);
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

  void _addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      // Origin is not set OR Origin/Destination are both set
      // Set origin
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
        // Reset destination
        _destination = null;

        // Reset info
        _info = null;
      });
    } else {
      // Origin is already set
      // Set destination
      setState(() {
        _destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );
      });

      // Get directions
      final directions = await DirectionsRepository()
          .getDirections(origin: _origin!.position, destination: pos);
      setState(() => _info = directions);
    }
  }
}
