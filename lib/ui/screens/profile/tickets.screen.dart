import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gowild/constants/colors.dart';
import 'package:gowild/ui/widgets/custom_app_bar.dart';
import 'package:gowild/ui/widgets/grass_themed_button.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TicketsScreen extends HookConsumerWidget {
  const TicketsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'SUPPORT',
        onLeadingTap: () => Navigator.pop(context),
      ),
      body: ListView.builder(
        itemCount: 4,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return const _TicketCardWidget();
        },
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
        child: GrassThemedButton(title: 'Send New Ticket'),
      ),
    );
  }
}

class _TicketCardWidget extends HookWidget {
  const _TicketCardWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(18),
        border: Border.all(width: .2, color: primaryYellow),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '1235CA432',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          // color: AppColorConstants.ticketBadgePendingColor,
                          borderRadius: BorderRadius.circular(18),
                          shape: BoxShape.rectangle),
                      child: const Text(
                        'Pending',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 12),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'April 28, 2022 | 10:22',
                  style: TextStyle(color: primaryYellow, fontSize: 12),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'Hi @johnsmith, when you have time please take a look at the new location we have shared.',
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: secondaryGray),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
