import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:gowild/constants/colors.dart';
import 'package:gowild/ui/widgets/auth_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VerifyPhoneScreen extends HookConsumerWidget {
  const VerifyPhoneScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                fontFamily: 'TheForegenRegular',
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 35, bottom: 5),
            child: Text(
              'Verification code sent to',
              style: TextStyle(
                color: secondaryWhite,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 35),
            child: Text(
              '+123-456-789',
              style: TextStyle(
                color: secondaryWhite,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const _VerificationCodeInput(),
          const SizedBox(
            height: 50,
          ),
          const _DidNotReceiveCode(),
          const _ResendOtpText(),
          const SizedBox(
            height: 180,
          ),
          MainAuthButtonWidget(
            text: 'Verify account',
            onTap: () {
              Beamer.of(context).beamToNamed('/auth/reset-password');
            },
          ),
        ],
      ),
    );
  }
}

class _ResendOtpText extends StatelessWidget {
  const _ResendOtpText();

  @override
  Widget build(BuildContext context) {
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
          ),
        ),
      ],
    );
  }
}

class _DidNotReceiveCode extends StatelessWidget {
  const _DidNotReceiveCode();

  @override
  Widget build(BuildContext context) {
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
}

class _VerificationCodeInput extends StatelessWidget {
  const _VerificationCodeInput();

  @override
  Widget build(BuildContext context) {
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
}
