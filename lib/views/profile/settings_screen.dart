import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gowild_mobile/constants/api_path_constants.dart';
import 'package:gowild_mobile/constants/image_constants.dart';
import 'package:gowild_mobile/models/user_model.dart';
import 'package:gowild_mobile/services/api_services.dart';
import 'package:gowild_mobile/services/secure_storage.dart';
import 'package:gowild_mobile/views/auth/login.dart';
import 'package:gowild_mobile/views/notifications/notifications_screen.dart';

import 'package:gowild_mobile/constants/colors.dart' as AppColorConstants;
import 'package:gowild_mobile/views/profile/faqs_screen.dart';
import 'package:gowild_mobile/views/support/tickets_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final String profilePlaceholder =
      '${ImageAssetPath.imagePathPng}${ImageAssetName.profilePlaceHolder}';

  final String gearIcon =
      '${ImageAssetPath.imagePathSvg}${ImageAssetName.gear}';

  final String chatIcon =
      '${ImageAssetPath.imagePathSvg}${ImageAssetName.chat}';

  final String usersIcon =
      '${ImageAssetPath.imagePathSvg}${ImageAssetName.users}';

  final String headphoneIcon =
      '${ImageAssetPath.imagePathSvg}${ImageAssetName.headphone}';

  final String userIcon =
      '${ImageAssetPath.imagePathSvg}${ImageAssetName.user}';

  final String creditCardIcon =
      '${ImageAssetPath.imagePathSvg}${ImageAssetName.creditCard}';

  final String notificationIcon =
      '${ImageAssetPath.imagePathSvg}${ImageAssetName.notification}';

  final String logoutIcon =
      '${ImageAssetPath.imagePathSvg}${ImageAssetName.logout}';

  late Future<UserModel> userProfile;
  @override
  void initState() {
    super.initState();
    userProfile = getUserProfile();
  }

  Future<UserModel> getUserProfile() async {
    final String? userId =
        await SecureStorage.readValue(key: SecureStorage.userIdKey);
    final dynamic response = await ApiServices().request(
        '${ApiPathConstants.usersUrl}$userId', RequestType.GET,
        needAccessToken: true);
    UserModel user = UserModel();
    print(response);
    if (response is Map<String, dynamic>) {
      if (!response.containsKey('statusCode')) {
        user = UserModel.fromJson(response);
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: _header(),
                ),
                _menuButton(gearIcon, 'General',
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FaqsScreen()))),
                // _menuButton(chatIcon, 'Messages'),
                // _menuButton(usersIcon, 'My Races'),
                _menuButton(headphoneIcon, 'Support',
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TicketsScreen()))),
                // _menuButton(userIcon, 'My Achievements'),
                // _menuButton(creditCardIcon, 'Payment'),
                _menuButton(notificationIcon, 'Notifications',
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationScreen()))),
                _menuButton(logoutIcon, 'Logout', onTap: () async {
                  await SecureStorage.deleteKeys();
                  await Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (Route<dynamic> route) => false);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return FutureBuilder<UserModel>(
        future: userProfile,
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.hasData) {
            final UserModel user = snapshot.data!;
            return Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColorConstants.primaryRed,
                      borderRadius: BorderRadius.circular(30)),
                  alignment: Alignment.center,
                  child: Text(
                    user.fullName!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white),
                  ),
                ),
                Positioned(
                  top: -25,
                  child: CircleAvatar(
                    radius: 22,
                    backgroundImage:
                        user.profileImg == null || user.profileImg == ''
                            ? AssetImage(profilePlaceholder)
                            : NetworkImage(user.profileImg!)
                                as ImageProvider,
                  ),
                )
              ],
            );
          }

          return Container();
        });
  }

  Widget _menuButton(String iconAsset, String menuName,
          {VoidCallback? onTap}) =>
      GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
          child: Row(
            children: [
              SvgPicture.asset(iconAsset),
              SizedBox(width: 15),
              Text(
                menuName,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 18),
              )
            ],
          ),
        ),
      );
}
