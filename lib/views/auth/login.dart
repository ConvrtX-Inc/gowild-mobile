import 'package:flutter/material.dart';
import 'package:gowild_mobile/helper/authentication_helper.dart';
import 'package:gowild_mobile/root.dart';
import 'package:gowild_mobile/views/auth/e_waiver.dart';
import '../../widgets/auth_widgets.dart';
import '../../constants/colors.dart';
import 'register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

enum LoginType { email, google }

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<bool> isFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    var isFirstTime = prefs.getBool('first_time');
    if (isFirstTime != null && !isFirstTime) {
      prefs.setBool('first_time', true);
      print('firest time');
      return true;
    } else {
      prefs.setBool('first_time', false);
      print('not first time');

      return false;
    }
  }

  void _loginUser({
    @required LoginType? type,
    // String? email,
    // String? password,
    required BuildContext context,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      String _returnString;
      _returnString = await AuthenticationHelper()
          .loginUser(emailController.text, passwordController.text);
      switch (type) {
        case LoginType.email:
          _returnString = await AuthenticationHelper()
              .loginUser(emailController.text, passwordController.text);
          break;
        case LoginType.google:
          // _returnString = await Auth().loginUserWithGoogle();
          break;
        default:
      }

      if (_returnString == "success") {
        isFirstTime().then((isFirstTime) {
          print(isFirstTime);
          isFirstTime
              ? Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EwaiverScreen()),
                  (route) => false)
              : Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Root()),
                  (route) => false);
        });
      } else {
        print('$_returnString returnString');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlack,
      body: SingleChildScrollView(
        child: Column(
          children: [
            titleTextWithAsset("LOGIN", 'assets/leaf.png'),
            const SizedBox(
              height: 30,
            ),
            socialContainer(context, facebookColor, 'assets/facebook_logo.png',
                'Log in with Facebook'),
            socialContainer(context, googleColor, 'assets/google_logo.png',
                'Log in with Google'),
            const SizedBox(
              height: 20,
            ),
            orText(),
            const SizedBox(
              height: 20,
            ),
            buildTextField(
                context, 'Email', emailController, 'myemail@gowild.com', false),
            buildTextField(
                context, 'Password', passwordController, '***********', true),
            forgotPassword(),
            const SizedBox(height: 10),
            mainAuthButton(context, "Login", () {
              _loginUser(type: LoginType.email, context: context);
            }),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const RegisterScreen())));
                },
                child: dontHaveAnAccount(
                    context, "Dont't have an account? ", "Register"))
          ],
        ),
      ),
    );
  }
}
