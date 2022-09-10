import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gowild/constants/colors.dart';
import 'package:gowild/constants/image_constants.dart';
import 'package:gowild/providers/current_user.dart';
import 'package:gowild/providers/login.service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const String profilePlaceholder =
    '${ImageAssetPath.imagePathPng}${ImageAssetName.profilePlaceHolder}';
const String gearIcon = '${ImageAssetPath.imagePathSvg}${ImageAssetName.gear}';
const String chatIcon = '${ImageAssetPath.imagePathSvg}${ImageAssetName.chat}';
const String usersIcon =
    '${ImageAssetPath.imagePathSvg}${ImageAssetName.users}';
const String headphoneIcon =
    '${ImageAssetPath.imagePathSvg}${ImageAssetName.headphone}';
const String userIcon = '${ImageAssetPath.imagePathSvg}${ImageAssetName.user}';
const String creditCardIcon =
    '${ImageAssetPath.imagePathSvg}${ImageAssetName.creditCard}';
const String notificationIcon =
    '${ImageAssetPath.imagePathSvg}${ImageAssetName.notification}';
const String logoutIcon =
    '${ImageAssetPath.imagePathSvg}${ImageAssetName.logout}';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: SafeArea(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: _SettingsHeader(),
                ),
                const _SettingsMenu(
                  icon: gearIcon,
                  title: 'General',
                  path: '/main/faqs',
                ),
                const _SettingsMenu(
                  icon: headphoneIcon,
                  title: 'Support',
                  path: '/main/tickets',
                ),
                const _SettingsMenu(
                  icon: notificationIcon,
                  title: 'Notifications',
                  path: '/main/notifications',
                ),
                _SettingsMenu(
                  icon: logoutIcon,
                  title: 'Logout',
                  onTap: () async {
                    await ref.read(loginProvider).logout();
                    context.beamToNamed('/');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SettingsMenu extends HookConsumerWidget {
  final String icon;
  final String title;
  final String? path;
  final VoidCallback? onTap;

  const _SettingsMenu({
    required this.icon,
    required this.title,
    this.onTap,
    this.path,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final handleTap = useMemoized(
        () => path != null ? () => context.beamToNamed(path!) : onTap, []);
    return GestureDetector(
      onTap: handleTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
        child: Row(
          children: [
            SvgPicture.asset(icon),
            const SizedBox(width: 15),
            Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsHeader extends HookConsumerWidget {
  const _SettingsHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    if (user == null) return Container();

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
              color: primaryRed, borderRadius: BorderRadius.circular(30)),
          alignment: Alignment.center,
          child: Text(
            user.fullName!,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
          ),
        ),
        Positioned(
          top: -25,
          child: CircleAvatar(
            radius: 22,
            backgroundImage: user.picture == null || user.picture == ''
                ? const AssetImage(profilePlaceholder)
                : Image.network(user.picture!) as ImageProvider,
          ),
        )
      ],
    );
  }
}
