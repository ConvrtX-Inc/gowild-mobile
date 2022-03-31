import 'dart:async';

import 'package:flutter/material.dart';

import 'landing_page.dart';

class SpashScreen extends StatelessWidget {
  const SpashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(
        const Duration(seconds: 1),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const LandingPage())));
    return Scaffold(
        body: Column(
      children: [Expanded(child: Image.asset('assets/Walkthrough.png'))],
    ));
  }
}
