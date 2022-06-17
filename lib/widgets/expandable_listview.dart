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
        width: 418,
        child: SlidingUpPanel(
          minHeight: MediaQuery.of(context).size.height * 0.05,
          panelBuilder: (sc) => PanelWidget(
            sc: sc,
          ),
          body: Container(
              height: 550,
              // width: 200,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
              child: Container(width: 200, child: const MyGoogleMap())),
          maxHeight: MediaQuery.of(context).size.height / 2,
          backdropEnabled: true,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
          parallaxEnabled: true,
          parallaxOffset: .5,
          color: Colors.white,
          // collapsed:
        ),
      ),
    );
  }

  buildMap() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Container(
                height: 650,
                width: 420,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                child: buildSlidingPanel()),
          ),
        ],
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
                        decoration:
                            const BoxDecoration(color: Colors.transparent),
                        child: buildMap())
                    : widget.title == 'NEARBY ADVENTURES'
                        ? Container(
                            decoration:
                                const BoxDecoration(color: Colors.transparent),
                            child: buildAdventureCard(context))
                        : const GoWildFeed();
              },
              itemCount: 1,
            ),
          )
        ],
      ),
    );
  }
}
