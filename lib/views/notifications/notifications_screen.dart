import 'package:flutter/material.dart';
import 'package:gowild_mobile/widgets/custom_appbar.dart';
import 'package:gowild_mobile/constants/colors.dart' as AppColorConstants;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
  }
class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
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
          return _notificationCard(isLastNotif: isLastNotif);
        },
      ),
    );
  }

  Widget _notificationCard({bool isLastNotif = false}) => Container(
        decoration: BoxDecoration(
            border: isLastNotif
                ? null
                : Border(
                    bottom: BorderSide(
                        width: .2, color: AppColorConstants.primaryYellow))),
        margin: EdgeInsets.symmetric(horizontal: 22),
        padding: EdgeInsets.symmetric(vertical: 25),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
