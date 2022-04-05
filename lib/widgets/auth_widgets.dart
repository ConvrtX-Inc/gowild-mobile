import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../constants/colors.dart';

//used in login.dart and register.dart
RichText dontHaveAnAccount(BuildContext context, String text1, String text2) {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(children: <TextSpan>[
      TextSpan(
          text: text1,
          style: const TextStyle(color: Color(0xff6B6968), fontSize: 14)),
      TextSpan(
          text: text2,
          style: const TextStyle(
              decoration: TextDecoration.underline,
              color: Color(0xffE4572E),
              fontSize: 14,
              fontWeight: FontWeight.bold)),
    ]),
  );
}

//reusable button with asset image
//used in login.dart and register.dart
Padding mainAuthButton(BuildContext context, String text, Function() onTap) {
  Size size = MediaQuery.of(context).size;
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 80,
          width: size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            color: const Color(0xff1C7355).withOpacity(0.6),
            image: const DecorationImage(
                image: AssetImage("assets/button_design.png"),
                fit: BoxFit.cover),
          ),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  letterSpacing: 1,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    ),
  );
}

Row titleTextWithAsset(String text, String assetFileName) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 30, top: 176),
        child: Text(
          text,
          style: TextStyle(
              color: primaryYellow,
              fontSize: 50,
              fontWeight: FontWeight.w400,
              fontFamily: 'assets/TheForegenRegular.ttf'),
        ),
      ),
      Image.asset(
        assetFileName,
      ),
    ],
  );
}

//reusable textfield for login.dart and register.dart
Column buildTextField(BuildContext context, String titleText,
    TextEditingController controller, String hintText, bool obscureText) {
  Size size = MediaQuery.of(context).size;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Text(
          titleText,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        child: Container(
            height: 90,
            width: size.width * 0.9,
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: obscureText,
              controller: controller,
              cursorColor: const Color(0xff6B6968),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff6B6968), width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Color(0xff6B6968), width: 2.0)),
                contentPadding: // Text Field height
                    const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 20.0),
                hintText: hintText,
                hintStyle: const TextStyle(
                    // height: 3,
                    color: Color(0xff6B6968),
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
            )),
      ),
    ],
  );
}

// used for login.dart
TextButton forgotPassword() {
  return TextButton(
      onPressed: () {},
      child: const Text(
        'Forgot Password?',
        style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18),
      ));
}

// used for login.dart
Text orText() {
  return const Text(
    'OR',
    style: TextStyle(
        color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
  );
}

// used for login.dart
//facebook and google social logins
Padding socialContainer(
    BuildContext context, Color color, String assetLogo, String title) {
  Size size = MediaQuery.of(context).size;
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      child: Container(
          height: 80,
          width: size.width * 0.9,
          decoration: BoxDecoration(
            color: color,
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 5,
              ),
              Container(
                height: 70,
                width: size.width / 7,
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
                child: SizedBox(
                    width: size.width,
                    height: size.height,
                    child: Image.asset(
                      assetLogo,
                      fit: BoxFit.fitHeight,
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center,
                    )),
              ),
              const SizedBox(
                width: 90,
              ),
              Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ],
          )),
    ),
  );
}

//used in register.dart
//intl phone number package used
Column buildPhoneNumberTextField(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.only(left: 16),
        child: Text(
          'Phone number',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        child: Container(
            height: 90,
            width: size.width * 0.9,
            padding: const EdgeInsets.all(8.0),
            child: IntlPhoneField(
              flagsButtonMargin: const EdgeInsets.all(16),
              dropdownIconPosition: IconPosition.trailing,
              dropdownIcon: Icon(
                Icons.arrow_drop_down,
                color: secondaryGray,
              ),
              cursorColor: const Color(0xff6B6968),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff6B6968), width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Color(0xff6B6968), width: 2.0)),
                contentPadding: // Text Field height
                    const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                hintText: '123-456-789',
                hintStyle: const TextStyle(
                    // height: 3,
                    color: Color(0xff6B6968),
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
              initialCountryCode: 'US',
              onChanged: (phone) {},
            )),
      ),
    ],
  );
}
