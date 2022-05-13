import 'package:flutter/material.dart';
import 'package:gowild_mobile/constants/size.dart';
import 'package:gowild_mobile/views/maps/try_routes.dart';
import 'package:gowild_mobile/widgets/sample_avatar.dart';

import '../models/route.dart';
import '../services/dio_client.dart';

class PanelWidget extends StatefulWidget {
  const PanelWidget({Key? key, required this.sc}) : super(key: key);

  final ScrollController sc;

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
  @override
  void initState() {
    // TODO: implement initState

    getRoutes = DioClient().getRoutes();
    super.initState();
  }

  late Future<RouteList> getRoutes;
  String? routeImage;
  String? routeText;
  double? startLat;
  double? startLong;
  double? endLat;
  double? endLong;

  Widget buildContainer(Routes route) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 120),
            child: Text(route.routeName!,
                style: const TextStyle(
                    color: Color(0xff18243C),
                    fontSize: 14,
                    fontWeight: FontWeight.w500)),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: Colors.grey,
              ),
              const Text('1.7 Miles',
                  style: TextStyle(
                      color: Color(0xff18243C),
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
              const SizedBox(
                width: 10,
              ),
              Row(
                children: const [
                  Icon(
                    Icons.timer,
                    color: Colors.grey,
                  ),
                  Text('1 hr 30 mins',
                      style: TextStyle(
                          color: Color(0xff18243C),
                          fontSize: 14,
                          fontWeight: FontWeight.w500))
                ],
              ),
              sizedBox(0, 8),
              Row(
                children: const [
                  Text('500m',
                      style: TextStyle(
                          color: Color(0xff18243C),
                          fontSize: 14,
                          fontWeight: FontWeight.w500))
                ],
              )
            ],
          )
        ],
      );

  buildRanking(String text, bool isSelected) => Container(
        width: 90,
        margin: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12.0)), // S
            border: Border.all(color: Colors.transparent),
            color: isSelected ? const Color(0xffEE7835) : Colors.transparent),
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 2),
        child: Row(
          children: [
            const SampleAvatar(),
            sizedBox(0, 5),
            Text(
              text,
              style: TextStyle(color: isSelected ? Colors.white : Colors.black),
            )
          ],
        ),
      );

  Widget buildAvatar() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildRanking('1st', false),
          buildRanking('2nd', false),
          buildRanking('3rd', false),
          buildRanking('8th', true),
        ],
      );

  Widget buildMapRow(bool isFirstContainer, Routes route) => Container(
        margin: EdgeInsets.only(left: 5, right: isFirstContainer ? 50 : 65),
        // padding: const EdgeInsets.only(left: 10, right: 30),
        width: isFirstContainer ? 190 : 300,
        // height: isFirstContainer ? 300 : 10,
        decoration: BoxDecoration(
          color: isFirstContainer ? Colors.orange : Colors.transparent,
          borderRadius: const BorderRadius.all(
            Radius.circular(12.0),
          ),
          border: Border.all(
            color: const Color(0xffDFDFDF),
            width: 1,
          ),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          const SizedBox(
            height: 5,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            child: buildSmallMap(isFirstContainer ? 320 : 90, route),
            height: 90,
          ),
          buildContainer(route),
        ]),
      );

  buildSmallMap(double height, Routes route) =>
      SizedBox(height: height, child: Image.network(route.imgUrl!));

  build1stContainer(BuildContext context, Routes route) => SizedBox(
        width: 320,
        height: 135,
        child: Container(
          margin: const EdgeInsets.only(left: 5, right: 8),
          // padding: const EdgeInsets.only(left: 10, right: 30),
          decoration: BoxDecoration(
            color: const Color(0xffFFF5F2),
            borderRadius: const BorderRadius.all(
              Radius.circular(12.0),
            ),
            border: Border.all(
              color: const Color(0xffEC6537),
              width: 1,
            ),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(route.imgUrl!),
            ),
            Column(
              children: [
                sizedBox(20, 0),
                Padding(
                  padding: const EdgeInsets.only(right: 90),
                  child: Text(route.routeName!,
                      style: const TextStyle(
                          color: Color(0xff18243C),
                          fontSize: 11,
                          fontWeight: FontWeight.w700)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.grey,
                        size: 11,
                      ),
                      const Text('1.7 Miles',
                          style: TextStyle(
                              color: Color(0xff18243C),
                              fontSize: 11,
                              fontWeight: FontWeight.w500)),
                      Row(
                        children: const [
                          Icon(
                            Icons.timer,
                            color: Colors.grey,
                            size: 11,
                          ),
                          Text('1 hr 30 mins',
                              style: TextStyle(
                                  color: Color(0xff18243C),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500))
                        ],
                      ),
                      sizedBox(0, 5),
                      Row(
                        children: const [
                          Text('500m',
                              style: TextStyle(
                                  color: Color(0xff18243C),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500))
                        ],
                      )
                    ],
                  ),
                ),
                sizedBox(20, 0),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        WidgetsBinding.instance?.addPostFrameCallback((_) {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => TryRoutes(
                          //               isProximity: true,
                          //               endLat: endLat,
                          //               endLong: endLong,
                          //               startLat: startLat,
                          //               startLong: startLong,
                          //               routeText: routeText,
                          //             )));
                        });
                      },
                      child: Container(
                        // margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: const Color(0xffEC6537),
                              width: 1.0), // Set border width
                          borderRadius: const BorderRadius.all(Radius.circular(
                              10.0)), // Set rounded corner radius
                        ),
                        child: const Text(
                          " Try Route ",
                          style: TextStyle(
                            color: Color(0xffEC6537),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(3),
                      padding: const EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: const Color(0xffEC6537),
                            width: 1.0), // Set border width
                        borderRadius: const BorderRadius.all(
                            Radius.circular(10.0)), // Set rounded corner radius
                      ),
                      child: const Text(
                        " Save ",
                        style: TextStyle(
                          color: Color(0xffEC6537),
                        ),
                      ),
                    ),
                    Container(
                      // margin: const EdgeInsets.all(5),
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
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
          ]),
        ),
      );

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 40),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(Icons.arrow_upward_rounded),
                    Text('Suggested Routes'),
                  ]),
            ),
            FutureBuilder<RouteList>(
              future: getRoutes,
              builder: (context, AsyncSnapshot<RouteList> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.routeList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final Routes route = snapshot.data!.routeList[index];
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TryRoutes(
                                          isProximity: true,
                                          route: route,
                                        )));
                          },
                          child: buildMapRow(index == 1, route));

                      // return Column(
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.only(right: 40),
                      //       child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: const <Widget>[
                      //             Icon(Icons.arrow_upward_rounded),
                      //             Text('Suggested Routes'),
                      //           ]),
                      //     ),
                      //     sizedBox(46, 0),
                      //     Row(
                      //       children: [
                      //         buildAvatar(),
                      //         build1stContainer(context, route)
                      //       ],
                      //     ),
                      //     sizedBox(24, 0),

                      //     buildMapRow(index == 1, route),
                      //     sizedBox(10, 0),
                      //     buildMapRow(false, route),
                      //   ],
                      // );
                    },
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    controller: widget.sc,
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      );
}
