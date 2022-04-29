import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gowild_mobile/constants/colors.dart' as AppColorConstants;
import 'package:gowild_mobile/constants/image_constants.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key, this.imageAsset}) : super(key: key);
  final String? imageAsset;

  final String leafBg =
      '${ImageAssetPath.imagePathPng}${ImageAssetName.leafBg}';
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
            image: DecorationImage(
                image: AssetImage(leafBg), fit: BoxFit.fitWidth),
            color: AppColorConstants.primaryRed,
          ),
        ),
        Positioned(
          bottom: -50,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: CircleAvatar(
              radius: 90,
              backgroundImage: NetworkImage(
                  'https://images.pexels.com/photos/11831940/pexels-photo-11831940.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'),
            ),
          ),
        )
      ],
    );
  }
}
