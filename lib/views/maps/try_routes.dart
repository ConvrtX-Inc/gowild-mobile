import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

class TryRoutes extends StatefulWidget {
  bool? isProximity;
  TryRoutes({Key? key, this.isProximity}) : super(key: key);

  @override
  _TryRoutesState createState() => _TryRoutesState();
}

class _TryRoutesState extends State<TryRoutes> {
  LatLng _initialcameraposition = const LatLng(20.5937, 78.9629);
  GoogleMapController? _controller;
  Location _location = Location();
  bool state = false;
  bool? isProximity;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    isProximity = widget.isProximity;
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
        ),
      );
    });
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

  MapType _currentMapType = MapType.normal;

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
        iconTheme: const IconThemeData(color: primaryYellow, size: 28),
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
                          children: const [
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
                                      initialCameraPosition: CameraPosition(
                                          target: _initialcameraposition),
                                      mapType: MapType.normal,
                                      onMapCreated: _onMapCreated,
                                      myLocationEnabled: true,
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
