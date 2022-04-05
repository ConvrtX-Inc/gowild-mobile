import 'package:flutter/material.dart';
import 'package:gowild_mobile/views/auth/e_waiver.dart';

import '../../constants/colors.dart';
import '../../widgets/auth_widgets.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({Key? key}) : super(key: key);

  @override
  _CreateNewPasswordState createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlack,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: primaryYellow),
        elevation: 0.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
              top: 176,
            ),
            child: Text(
              'Create New',
              style: TextStyle(
                  color: primaryYellow,
                  fontSize: 50,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'TheForegenRegular.ttf'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              'Password',
              style: TextStyle(
                  color: primaryYellow,
                  fontSize: 50,
                  fontWeight: FontWeight.w400),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              'Your password must be different from',
              style: TextStyle(
                  color: secondaryWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              'previous used passwords',
              style: TextStyle(
                  color: secondaryWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, bottom: 5),
            child: buildTextField(context, 'Enter new password',
                newPasswordController, '********', true),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, bottom: 5),
            child: buildTextField(context, 'Confirm new password',
                confirmPasswordController, '********', true),
          ),
          const SizedBox(
            height: 80,
          ),
          mainAuthButton(context, 'Reset Password', () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => const EwaiverScreen())));
          })
        ],
      ),
    );
  }
}
