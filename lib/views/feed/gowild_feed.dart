import 'package:flutter/material.dart';
import 'package:gowild_mobile/constants/size.dart';

class GoWildFeed extends StatefulWidget {
  const GoWildFeed({Key? key}) : super(key: key);

  @override
  _GoWildFeedState createState() => _GoWildFeedState();
}

class _GoWildFeedState extends State<GoWildFeed>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Container(
              height: 100,
              width: 100,
              color: Colors.blue,
            ),
            Container(
              color: Colors.black,
              height: 100,
              width: double.infinity,
              child: TabBar(
                  indicator: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8.0)),
                  tabs: const [
                    Tab(
                      text: 'My Profile',
                    ),
                    Tab(
                      text: 'My Friends',
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
