import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'expandable_container.dart';
import 'sample_avatar.dart';
import 'star_rating.dart';

class ExpandableListView extends StatefulWidget {
  final String title;

  const ExpandableListView({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _ExpandableListViewState createState() => _ExpandableListViewState();
}

class _ExpandableListViewState extends State<ExpandableListView> {
  bool expandFlag = false;
  var rating = 3.0;
  Widget buildAdventureCard(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Container(
              height: 550,
              width: 300,
              // padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    height: 200,
                    width: 300,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYXY4S9RadUIoLeALlV19A3ov3f9FDj7sfDw&usqp=CAU'),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: Text('THRILL SEEKERS ATTRACTIONS IN HOUSTON',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff18243C),
                            )),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StarRating(
                              rating: rating,
                              color: const Color(0xffF6B100),
                              onRatingChanged: (rating) =>
                                  setState(() => this.rating = rating),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  'Visit',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Container(
                                  width: 30,
                                  decoration: const BoxDecoration(
                                    color: Color(0xff55755D),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2)),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '75k',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: Text('100,000 miles',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600)),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: Text(
                            'Bacon ipsum dolor amet turducken chicken meatball, kielbasa fatback ham ball tip corned beef hamburger drumstick pork belly alcatra meatloaf.',
                            style: TextStyle(
                                color: Color(0xff18243C),
                                fontSize: 14,
                                fontWeight: FontWeight.w500)),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                top: 10, left: 20, right: 20),
                            height: 90,
                            width: 250,
                            child: ListView.separated(
                              itemCount: 4,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  width: 10,
                                );
                              },
                              itemBuilder: (_, i) => const SampleAvatar(),
                              scrollDirection: Axis.horizontal,
                              physics: const NeverScrollableScrollPhysics(),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(42.637310, -77.596007);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Set<Marker> _createMarker() {
    return {
      Marker(
          markerId: const MarkerId("marker_1"),
          position: _center,
          infoWindow: const InfoWindow(title: 'Marker 1'),
          rotation: 70),
      const Marker(
        // icon:Bita,
        markerId: MarkerId("marker_2"),
        position: LatLng(42.637321, -77.5960179),
      ),
    };
  }

  final scaffoldState = GlobalKey<ScaffoldState>();
  final double _initFabHeight = 120.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 95.0;

  PanelController _pc1 = new PanelController();
  PanelController _pc2 = new PanelController();
  bool _visible = true;

  Widget buildRoutesCard(context) {
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );

    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 550,
      width: 300,
      child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Container(
                height: 550,
                width: 300,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  mapType: MapType.satellite,
                  markers: _createMarker(),
                  trafficEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 11.0,
                  ),
                ),
              ),
            ),
          ]),
    );
  }

  buildMap() {
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        height: 550,
        width: 300,
        child: Stack(
            // controller: ,
            children: [
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Container(
                        height: 400,
                        width: 300,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                        ),
                        child: GoogleMap(
                          mapToolbarEnabled: false,
                          onMapCreated: _onMapCreated,
                          mapType: MapType.terrain,
                          markers: _createMarker(),
                          trafficEnabled: true,
                          initialCameraPosition: CameraPosition(
                            target: _center,
                            zoom: 11.0,
                          ),
                        ),
                      ),
                      SlidingUpPanel(
                          panel: Column(
                        children: [
                          SizedBox(
                            height: 80,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white),
                                onPressed: () {},
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          child: Image.asset('assets/map.png'),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                          ),
                                          height: 50,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text('Route Text Goes Here',
                                            style: TextStyle(
                                                color: Color(0xff18243C),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          color: Colors.grey,
                                        ),
                                        Text('1.7 Miles',
                                            style: TextStyle(
                                                color: Color(0xff18243C),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500)),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.timer,
                                              color: Colors.grey,
                                            ),
                                            Text('1 hr 30 mins',
                                                style: TextStyle(
                                                    color: Color(0xff18243C),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500))
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 80,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white),
                                onPressed: () {},
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          child: Image.asset('assets/map.png'),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                          ),
                                          height: 50,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text('Route Text Goes Here',
                                            style: TextStyle(
                                                color: Color(0xff18243C),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          color: Colors.grey,
                                        ),
                                        Text('1.7 Miles',
                                            style: TextStyle(
                                                color: Color(0xff18243C),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500)),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.timer,
                                              color: Colors.grey,
                                            ),
                                            Text('1 hr 30 mins',
                                                style: TextStyle(
                                                    color: Color(0xff18243C),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500))
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                )),
                          ),
                        ],
                      ))
                    ]),
              ),
            ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontSize: 14),
                ),
                IconButton(
                    icon: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          expandFlag
                              ? Icons.keyboard_arrow_down
                              : Icons.keyboard_arrow_right,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        expandFlag = !expandFlag;
                      });
                    }),
              ],
            ),
          ),
          ExpandableContainer(
            expanded: expandFlag,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return widget.title == 'ROUTES'
                    ? Container(
                        // height: 80,
                        decoration:
                            const BoxDecoration(color: Colors.transparent),
                        child: buildMap())
                    : Container(
                        // height: 80,
                        decoration:
                            const BoxDecoration(color: Colors.transparent),
                        child: buildAdventureCard(context));
              },
              itemCount: 5,
            ),
          )
        ],
      ),
    );
  }
}
