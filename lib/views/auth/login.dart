import 'package:flutter/material.dart';
import '../../widgets/auth_widgets.dart';
import '../../constants/colors.dart';
import 'register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
            mainAuthButton(context, "Login", () {}),
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
