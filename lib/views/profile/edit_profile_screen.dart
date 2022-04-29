import 'package:flutter/material.dart';
import 'package:gowild_mobile/constants/image_constants.dart';
import 'package:gowild_mobile/views/profile/widgets/profile_header.dart';
import 'package:gowild_mobile/widgets/custom_appbar.dart';
import 'package:gowild_mobile/widgets/grass_themed_button.dart';
import 'package:gowild_mobile/widgets/outlined_textfield.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'EDIT PROFILE'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(children: [
          ProfileHeader(),
          SizedBox(
            height: 65,
          ),
          OutlinedTextField(
            title: 'First name',
          ),
          OutlinedTextField(
            title: 'Last name',
          ),
          OutlinedTextField(
            title: 'Username',
          ),
          OutlinedTextField(
            title: 'Email',
          ),
          Spacer(),
          GrassThemedButton(
            title: 'Save',
          ),
          SizedBox(
            height: 20,
          )
        ]),
      ),
    );
  }
}
