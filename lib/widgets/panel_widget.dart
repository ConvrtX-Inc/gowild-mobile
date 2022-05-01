import 'package:flutter/material.dart';
import 'package:gowild_mobile/constants/size.dart';
import 'package:gowild_mobile/views/maps/try_routes.dart';
import 'package:gowild_mobile/widgets/sample_avatar.dart';

class PanelWidget extends StatelessWidget {
  const PanelWidget({Key? key, required this.sc}) : super(key: key);

  final ScrollController sc;

  Widget buildContainer() => Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 120),
            child: Text('Route Text Goes Here',
                style: TextStyle(
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

  Widget buildMapRow(bool isFirstContainer) => Container(
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
            child: buildSmallMap(isFirstContainer ? 320 : 90),
            height: 90,
          ),
          buildContainer(),
        ]),
      );

  buildSmallMap(double height) =>
      SizedBox(height: height, child: Image.asset('assets/map.png'));
  build1stContainer(BuildContext context) => SizedBox(
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
              child: Image.asset('assets/bigMap.png'),
            ),
            Column(
              children: [
                sizedBox(20, 0),
                const Padding(
                  padding: EdgeInsets.only(right: 90),
                  child: Text('Route Text Goes Here',
                      style: TextStyle(
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TryRoutes(isProximity: true)));
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
  Widget build(BuildContext context) => ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        controller: sc,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(Icons.arrow_upward_rounded),
                  Text('Suggested Routes'),
                ]),
          ),
          sizedBox(46, 0),
          Row(
            children: [buildAvatar(), build1stContainer(context)],
          ),
          sizedBox(24, 0),
          buildMapRow(false),
          sizedBox(10, 0),
          buildMapRow(false),
        ],
      );
}
