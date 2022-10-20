import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gowild/constants/colors.dart';
import 'package:gowild/ui/widgets/custom_app_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotificationScreen extends HookConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'Notifications',
        onLeadingTap: () => Navigator.pop(context),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          bool isLastNotif = 3 == index + 1;
          return _NotificationCard(isLastNotif: isLastNotif);
        },
      ),
    );
  }
}

class _NotificationCard extends HookWidget {
  final bool isLastNotif;

  const _NotificationCard({
    this.isLastNotif = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: isLastNotif
            ? null
            : const Border(
                bottom: BorderSide(
                  width: .2,
                  color: primaryYellow,
                ),
              ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 22),
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 20,
          ),
          const SizedBox(
            width: 20,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Benjamin Poole',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                      Text(
                        'Nov 2nd',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.white),
                      )
                    ],
                  ),
                ),
                const Text(
                  'Hi @johnsmith, when you have time please take a look at the new location we have shared.',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: secondaryGray,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
