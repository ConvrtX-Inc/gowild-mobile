import 'package:flutter/material.dart';
import 'package:gowild_mobile/constants/image_constants.dart';

class GrassThemedButton extends StatelessWidget {
  const GrassThemedButton({Key? key, required this.title}) : super(key: key);

  final String title;

  final String grassButtonBg =
      '${ImageAssetPath.imagePathPng}${ImageAssetName.grassButtonBg}';
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12.5),
          image: DecorationImage(
            image: AssetImage(grassButtonBg),
            fit: BoxFit.fill,
          )),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }
}
