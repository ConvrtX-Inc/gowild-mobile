import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gowild_mobile/constants/secret.dart';
import 'package:gowild_mobile/views/feed/gowild_feed.dart';
import 'package:gowild_mobile/views/maps/google_maps.dart';
import 'package:gowild_mobile/widgets/panel_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'expandable_container.dart';
import 'sample_avatar.dart';
import 'star_rating.dart';
import 'package:flutter/material.dart';

class ExpandableListView extends StatefulWidget {
  const ExpandableListView({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _ExpandableListViewState createState() => _ExpandableListViewState();
}

class _ExpandableListViewState extends State<ExpandableListView> {
  bool expandFlag = false;
  var rating = 3.0;
  final PanelController _suggestedRoutesPanelCtrl = PanelController();

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

  Widget buildSlidingPanel() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: SizedBox(
        // width: 418,
        child: SlidingUpPanel(
          minHeight: 80,
          isDraggable: false,
          controller: _suggestedRoutesPanelCtrl,
          panelBuilder: (sc) => Container(),
          collapsed: Container(
              // padding: EdgeInsets.all(14),
              decoration: BoxDecoration(color: Colors.white),
              child: GestureDetector(
                  onTap: () {
                    // _suggestedRoutesPanelCtrl.open();
                    _modalBottomSheetMenu();
                  },
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.keyboard_arrow_up),
                          SizedBox(
                            width: 30,
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Suggested Routes',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(
                            width: 12,
                          )
                        ],
                      )
                    ],
                  ))),

          // isDraggable: false,
          // panelSnapping: false,
          // minHeight: 50,
          /*  panelBuilder: (sc) => ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.white),
            child: const Text('suggested route',style: TextStyle(color: Colors.black),),
            onPressed: () {
              _modalBottomSheetMenu();
            },
          ),*/

          /*     header: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 150,
              ),
              const Text(
                'Suggested Routes',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                width: 150,
              )
            ],
          ),*/
          // header:  const Text(
          //   'Suggested Routes',
          //
          //   style: TextStyle(
          //     fontSize: 16,
          //     fontWeight: FontWeight.w700,
          //   ),
          // ),

          //! added listview
          /* body: ListView(
              // physics: const NeverScrollableScrollPhysics(),
              children: [
                Container(
                    height: MediaQuery.of(context).size.height / 1.85,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                    ),
                    child: const SizedBox(width: 200, child: MyGoogleMap())),
              ]),*/
          body: const SizedBox(width: 200, child: MyGoogleMap()),
          maxHeight: MediaQuery.of(context).size.height / 3,
          backdropEnabled: true,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
          parallaxEnabled: false,
          parallaxOffset: 0.0,

          color: Colors.white,
        ),
      ),
    );
  }

  buildMap() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        // height: MediaQuery.of(context).size.height / 2,

        width: 420,
        decoration: const BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        child: buildSlidingPanel()
       /* child: Stack(
          children: [
            MyGoogleMap(),
            Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: GestureDetector(
                    onTap: () {
                      // _suggestedRoutesPanelCtrl.open();
                      _modalBottomSheetMenu();
                    },
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(color: Colors.white),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Column(
                        children: [
                          Icon(Icons.keyboard_arrow_up),
                          Text(
                            'Suggested Routes',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )
                        ],
                      ),
                    )))
          ],
        ),*/
      ),
    );
    // return Container(
    //   padding: const EdgeInsets.all(8.0),
    //   height: 122,
    //   child: Row(
    //     children: [
    //
    //     ],
    //   ),
    // );
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: MediaQuery.of(context).size.height / 2,
            color: Colors.transparent, //could change this to Color(0xFF737373),

            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0))),
                child: const PanelWidget()),
          );
        });
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
                              ? Icons.keyboard_arrow_right
                              : Icons.keyboard_arrow_down,
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
            expandedHeight: MediaQuery.of(context).size.height / 1.65,
            child: SizedBox(
              child: buildMap(),
            ),
            /*   child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  // return widget.title == 'ROUTES'
                  //     ?
                  return Container(
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                      child: );
                  // : widget.title == 'NEARBY ADVENTURES'
                  //     ? Container(
                  //         decoration: const BoxDecoration(
                  //             color: Colors.transparent),
                  //         child: buildAdventureCard(context))
                  //     : Container();
                },
                itemCount: 1,
              ),
            ),*/
          )
        ],
      ),
    );
  }
}
