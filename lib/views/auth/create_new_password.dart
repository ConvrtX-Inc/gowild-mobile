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
        iconTheme: const IconThemeData(color: primaryYellow),
        elevation: 0.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
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
          const Padding(
            padding: EdgeInsets.only(left: 30),
            child: const Text(
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
          const Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              'Your password must be different from',
              style: const TextStyle(
                  color: secondaryWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              'previous used passwords',
              style: const TextStyle(
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
                newPasswordController, '********', true, (String? value) {
              return value!;
            }),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, bottom: 5),
            child: buildTextField(context, 'Confirm new password',
                confirmPasswordController, '********', true, (String? value) {
              return value!;
            }),
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
