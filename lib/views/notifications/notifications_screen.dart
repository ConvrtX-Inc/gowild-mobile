import 'package:flutter/material.dart';
import 'package:gowild_mobile/models/notifications.dart' as notifs;
import 'package:gowild_mobile/services/database.dart';
import 'package:gowild_mobile/widgets/custom_appbar.dart';
import 'package:gowild_mobile/constants/colors.dart' as AppColorConstants;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<notifs.Notifications> getNotifications;

  @override
  void initState() {
    super.initState();
    getNotifications = Database.getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'Notifications',
        onLeadingTap: () => Navigator.pop(context),
      ),
      body: FutureBuilder<notifs.Notifications>(
          future: getNotifications,
          builder: (BuildContext context,
              AsyncSnapshot<notifs.Notifications> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              case ConnectionState.none:
                // TODO: Handle this case.
                break;
              case ConnectionState.active:
                // TODO: Handle this case.
                break;
              case ConnectionState.done:
                if (snapshot.data!.notifications.isNotEmpty) {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.notifications.length,
                    itemBuilder: (BuildContext context, int index) {
                      bool isLastNotif = 3 == index + 1;
                      final notifs.Notification notification =
                          snapshot.data!.notifications[index];
                      return _notificationCard(notification,
                          isLastNotif: isLastNotif);
                    },
                  );
                } else {
                  return const Center(
                    child: Text(
                      'No notifications found',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                          color: Colors.white70),
                    ),
                  );
                }
            }
            return Container();
          }),
    );
  }

  Widget _notificationCard(notifs.Notification notification,
          {bool isLastNotif = false}) =>
      Container(
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
