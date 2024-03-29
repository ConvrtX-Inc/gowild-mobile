import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:gowild_mobile/views/auth/reset_password.dart';
import 'package:gowild_mobile/widgets/auth_widgets.dart';

import '../../constants/colors.dart';

class VerifyPhoneScreen extends StatefulWidget {
  String phoneNumber;
  VerifyPhoneScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<VerifyPhoneScreen> createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  Row buildResendOtpText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () {},
            child: const Text(
              'Resend OTP',
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: primaryYellow,
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            )),
      ],
    );
  }

  Row buildDidNotRecieveCode() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          'Didn\'t recieve code? ',
          style: TextStyle(
              color: secondaryWhite, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  buildVerificationCodeInput() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: VerificationCode(
          underlineUnfocusedColor: primaryRed,
          autofocus: true,
          underlineWidth: 6,
          textStyle: const TextStyle(fontSize: 30.0, color: primaryRed),
          keyboardType: TextInputType.number,
          underlineColor: const Color(0xff6B6968),
          length: 4,
          cursorColor: primaryRed,
          itemSize: 80,
          digitsOnly: true,
          onCompleted: (String value) {},
          onEditing: (bool value) {},
        ),
      ),
    );
  }

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
            padding: EdgeInsets.only(left: 30, top: 176, bottom: 10),
            child: Text(
              'VERIFY PHONE',
              style: TextStyle(
                  color: primaryYellow,
                  fontSize: 50,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'TheForegenRegular.ttf'),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 35, bottom: 5),
            child: Text(
              'Verification code sent to',
              style: const TextStyle(
                  color: secondaryWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 35),
            child: Text(
              '+123-456-789',
              style: const TextStyle(
                  color: secondaryWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          buildVerificationCodeInput(),
          const SizedBox(
            height: 50,
          ),
          buildDidNotRecieveCode(),
          buildResendOtpText(),
          const SizedBox(
            height: 180,
          ),
          mainAuthButton(context, 'Verify account', () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => const ResetPasswordScreen())));
          }),
        ],
      ),
    );
  }
}
