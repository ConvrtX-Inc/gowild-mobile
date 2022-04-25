import 'package:flutter/material.dart';
import 'package:gowild_mobile/views/auth/login.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            SizedBox(
                width: size.width,
                height: size.height,
                child: Image.asset(
                  'assets/Adventure.png',
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                )),
            Positioned(
              top: 130,
              child: Center(
                  child: SizedBox(
                width: size.width,
                height: size.height * 0.5 / 2,
                child: Image.asset(
                  'assets/Frame-2.png',
                  // height: size.height / 2,
                  fit: BoxFit.fitHeight,
                  height: size.height,
                  width: double.infinity,
                  alignment: Alignment.center,
                ),
              )),
            ),
            Positioned(
                top: 50,
                left: 40,
                right: 40,
                child: SizedBox(
                    child: Image.asset(
                  'assets/prepare.png',
                  fit: BoxFit.contain,
                  height: size.height,
                  width: double.infinity,
                  alignment: Alignment.center,
                ))),
            Positioned(
              // top: 140,
              bottom: 100,
              left: 40,
              right: 40,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => const LoginScreen()));
                },
                child: Container(
                  height: 71,
                  width: 71,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                      border: Border.all(width: 2, color: Colors.white)),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            )
          ],
        )
      ],
    ));
  }
}
