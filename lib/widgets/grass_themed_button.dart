import 'package:flutter/material.dart';
import 'package:gowild_mobile/constants/image_constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:gowild_mobile/constants/colors.dart' as AppColorsConstants;

class GrassThemedButton extends StatelessWidget {
  const GrassThemedButton(
      {Key? key, required this.title, this.onTap, this.loading = false})
      : super(key: key);

  final String title;
  final VoidCallback? onTap;
  final bool loading;
  final String grassButtonBg =
      '${ImageAssetPath.imagePathPng}${ImageAssetName.grassButtonBg}';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
        child: loading
            ? LoadingAnimationWidget.discreteCircle(
                color: Colors.white,
                size: 35,
                secondRingColor: AppColorsConstants.primaryRed,
                thirdRingColor: AppColorsConstants.primaryYellow)
            : Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
      ),
    );
  }
}
