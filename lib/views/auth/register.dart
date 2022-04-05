import 'package:flutter/material.dart';
import 'package:gowild_mobile/helper/authentication_helper.dart';
import 'package:gowild_mobile/models/user_model.dart';
import 'package:gowild_mobile/views/auth/verify_phone_screen.dart';
import 'login.dart';

import '../../constants/colors.dart';
import '../../widgets/auth_widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();

  void _signUpUser(String email, String password, BuildContext context) async {
    try {
      String _returnString =
          await AuthenticationHelper().signUpUser(email, password);
      if (_returnString == "success") {
        print('success');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const VerifyPhoneScreen()),
            (route) => false);
      }
    } catch (e) {
      print(e);
    }
  }

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            titleTextWithAsset("REGISTER", 'assets/register_leaf.png'),
            const SizedBox(
              height: 20,
            ),
            buildTextField(context, 'Full name', fullNameController,
                'Jennylyn Aretcona', false),
            buildTextField(
                context, 'Email', emailController, 'myemail@gowild.com', false),
            buildTextField(
                context, 'Password', passwordController, '***********', true),
            buildPhoneNumberTextField(context),
            buildTextField(context, 'Address Line 1', addressLine1Controller,
                '123 Street Name, City', false),
            buildTextField(context, 'Address Line 2', addressLine2Controller,
                'State, Country, Postal Code', false),
            mainAuthButton(
              context,
              'Register',
              () {
                _signUpUser(
                    emailController.text, passwordController.text, context);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const LoginScreen())));
                },
                child: dontHaveAnAccount(
                    context, 'Already have an account? ', 'Login')),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
