import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gowild/constants/colors.dart';
import 'package:gowild/constants/image_constants.dart';

const String leafBg = '${ImageAssetPath.imagePathPng}${ImageAssetName.leafBg}';
const String profilePlaceholder =
    '${ImageAssetPath.imagePathPng}${ImageAssetName.profilePlaceHolder}';

class ProfileHeader extends HookWidget {
  const ProfileHeader({super.key, this.imageAsset});

  final String? imageAsset;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            image: const DecorationImage(
              image: AssetImage(leafBg),
              fit: BoxFit.fitWidth,
            ),
            color: primaryRed,
          ),
        ),
        Positioned(
          bottom: -50,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle),
            child: CircleAvatar(
              radius: 90,
              backgroundImage: imageAsset == null || imageAsset == ''
                  ? const AssetImage(profilePlaceholder)
                  : NetworkImage(imageAsset!) as ImageProvider,
            ),
          ),
        )
      ],
    );
  }
}
