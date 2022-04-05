import 'package:flutter/material.dart';
import 'package:gowild_mobile/helper/authentication_helper.dart';
import 'package:gowild_mobile/root.dart';
import '../../widgets/auth_widgets.dart';
import '../../constants/colors.dart';
import 'register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

enum LoginType { email, google }

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void _loginUser({
    @required LoginType? type,
    String? email,
    String? password,
    required BuildContext context,
  }) async {
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
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => Root()), (route) => false);
      } else {
        print('$_returnString');
        // Scaffold.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text(_returnString),
        //     duration: Duration(seconds: 2),
        //   ),
        // );
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
