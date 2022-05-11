import 'package:flutter/material.dart';
import 'package:gowild_mobile/views/auth/create_new_password.dart';
import 'package:gowild_mobile/widgets/auth_widgets.dart';

import '../../constants/colors.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 176, bottom: 50),
            child: Text(
              'RESET PASSWORD',
              style: TextStyle(
                  color: primaryYellow,
                  fontSize: 50,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'TheForegenRegular.ttf'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, bottom: 5),
            child: Text(
              'Enter your email ID or phone number',
              style: TextStyle(
                  color: secondaryWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              'associated with your account and we\'ll send',
              style: TextStyle(
                  color: secondaryWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, bottom: 5),
            child: Text(
              'a verification code to reset your password',
              style: TextStyle(
                  color: secondaryWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, bottom: 5),
            child: buildTextField(
                context, 'Email', emailController, 'myemail@gowild.com', false,
                (String? value) {
              return value!;
            }),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, bottom: 5),
            child: buildPhoneNumberTextField(
              context,
            ),
          ),
          mainAuthButton(context, 'Verify account', () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => const CreateNewPassword())));
          })
        ],
      ),
    );
  }
}
