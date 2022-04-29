import 'package:flutter/material.dart';
import 'package:gowild_mobile/widgets/custom_appbar.dart';
import 'package:gowild_mobile/widgets/grass_themed_button.dart';

import 'package:gowild_mobile/constants/colors.dart' as AppColorConstants;

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({Key? key}) : super(key: key);

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'SUPPORT'),
      body: ListView.builder(
          itemCount: 4,
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return _ticketCard();
          }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
        child: GrassThemedButton(title: 'Send New Ticket'),
      ),
    );
  }

  Widget _ticketCard() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(18),
          border:
              Border.all(width: .2, color: AppColorConstants.primaryYellow)),
      margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
          ),
          SizedBox(
            width: 20,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '1235CA432',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: AppColorConstants.ticketBadgePendingColor,
                          borderRadius: BorderRadius.circular(18),
                          shape: BoxShape.rectangle),
                      child: Text(
                        'Pending',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 12),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'April 28, 2022 | 10:22',
                  style: TextStyle(
                      color: AppColorConstants.primaryYellow, fontSize: 12),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Hi @johnsmith, when you have time please take a look at the new location we have shared.',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColorConstants.secondaryGray),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
