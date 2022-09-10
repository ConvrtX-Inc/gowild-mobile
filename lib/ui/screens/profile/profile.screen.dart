import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gowild/providers/current_user.dart';
import 'package:gowild/ui/widgets/custom_app_bar.dart';
import 'package:gowild/ui/widgets/user_profile_header.dart';
import 'package:gowild_api/gowild_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: const CustomAppBar(titleText: 'PROFILE'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Builder(
          builder: (context) {
            if (user != null) {
              return _UserProfileContent(user: user);
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class _UserProfileContent extends HookWidget {
  final SimpleUser user;

  const _UserProfileContent({required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ProfileHeader(imageAsset: user.picture),
        const SizedBox(
          height: 65,
        ),
        Text(
          '${user.fullName}, 23',
          style: const TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'About Me',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        )
      ],
    );
  }
}
