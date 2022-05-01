import 'package:flutter/material.dart';
import 'package:gowild_mobile/views/profile/widgets/profile_header.dart';
import 'package:gowild_mobile/widgets/custom_appbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'PROFILE'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            ProfileHeader(),
            SizedBox(
              height: 65,
            ),
            Text(
              'Jennilyn Artecona, 23',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'About Me',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.normal),
            )
          ],
        ),
      ),
    );
  }
}
