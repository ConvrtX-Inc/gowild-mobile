import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gowild_mobile/root.dart';

import 'landing_page.dart';

class SpashScreen extends StatefulWidget {
  const SpashScreen({Key? key}) : super(key: key);

  @override
  State<SpashScreen> createState() => _SpashScreenState();
}

class _SpashScreenState extends State<SpashScreen> {
  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (mounted) {
      Timer(
          const Duration(seconds: 1),
          () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => const LandingPage())));
    }
    return Scaffold(
        body: Column(
      children: [Expanded(child: Image.asset('assets/Walkthrough.png'))],
    ));
  }
}
