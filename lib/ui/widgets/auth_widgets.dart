import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gowild/constants/colors.dart';
import 'package:gowild/constants/social.dart';

class TitleTextWithAssetWidget extends StatelessWidget {
  final String text;
  final String assetFileName;

  const TitleTextWithAssetWidget({
    super.key,
    required this.text,
    required this.assetFileName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, top: 176),
          child: Text(
            text,
            style: const TextStyle(
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
}

class SocialContainerWidget extends StatelessWidget {
  final Color color;
  final String assetLogo;
  final String title;
  final VoidCallback onTap;
  final SocialType type;

  const SocialContainerWidget({
    super.key,
    required this.color,
    required this.assetLogo,
    required this.title,
    required this.onTap,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(16.0),
        ),
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
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.0),
                  ),
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
                  ),
                ),
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
          ),
        ),
      ),
    );
  }
}

class OrTextWidget extends StatelessWidget {
  const OrTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'OR',
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class AuthTextField extends HookWidget {
  final String titleText;
  final String name;
  final TextEditingController? controller;
  final String hintText;
  final bool obscureText;
  final FormFieldValidator<String> validator;
  final ValueChanged<String?>? onChanged;

  const AuthTextField({
    super.key,
    required this.titleText,
    required this.name,
    required this.validator,
    this.hintText = '',
    this.obscureText = false,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
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
          borderRadius: const BorderRadius.all(
            Radius.circular(16.0),
          ),
          child: Container(
            height: 90,
            width: size.width * 0.9,
            padding: const EdgeInsets.all(8.0),
            child: FormBuilderTextField(
              onChanged: onChanged,
              name: name,
              validator: validator,
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
                      const BorderSide(color: Color(0xff6B6968), width: 2.0),
                ),
                contentPadding: // Text Field height
                    const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 20.0,
                ),
                hintText: hintText,
                hintStyle: const TextStyle(
                  // height: 3,
                  color: Color(0xff6B6968),
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ForgotPasswordButtonWidget extends StatelessWidget {
  const ForgotPasswordButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        'Forgot Password?',
        style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18),
      ),
    );
  }
}

class MainAuthButtonWidget extends HookWidget {
  final String text;
  final VoidCallback onTap;

  const MainAuthButtonWidget({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        child: InkWell(
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
}
