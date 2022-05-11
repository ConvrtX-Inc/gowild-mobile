import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gowild_mobile/constants/colors.dart' as AppColorConstants;
import 'package:gowild_mobile/constants/image_constants.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader(
      {Key? key,
      this.imageAsset,
      this.forChangingPhoto = false,
      this.changePhotoButtonTap})
      : super(key: key);
  final String? imageAsset;
  final bool forChangingPhoto;
  final VoidCallback? changePhotoButtonTap;

  final String leafBg =
      '${ImageAssetPath.imagePathPng}${ImageAssetName.leafBg}';
  final String profilePlaceholder =
      '${ImageAssetPath.imagePathPng}${ImageAssetName.profilePlaceHolder}';
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
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: CircleAvatar(
                  radius: 90,
                  backgroundImage: imageAsset == null || imageAsset == ''
                      ? AssetImage(profilePlaceholder)
                      : CachedNetworkImageProvider(imageAsset!)
                          as ImageProvider,
                ),
              ),
              if (forChangingPhoto)
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.black54.withOpacity(0.3),
                      shape: BoxShape.circle),
                  child: IconButton(
                    onPressed: changePhotoButtonTap,
                    icon: Icon(Icons.photo_rounded),
                    iconSize: 40,
                  ),
                )
            ],
          ),
        )
      ],
    );
  }
}
