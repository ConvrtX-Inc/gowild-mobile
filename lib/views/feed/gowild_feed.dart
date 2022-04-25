import 'package:flutter/material.dart';

class GoWildFeed extends StatefulWidget {
  const GoWildFeed({Key? key}) : super(key: key);

  @override
  _GoWildFeedState createState() => _GoWildFeedState();
}

class _GoWildFeedState extends State<GoWildFeed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      child: Center(
          child: Text(
        'data',
        style: TextStyle(fontSize: 24, color: Colors.white),
      )),
    );
  }
}
