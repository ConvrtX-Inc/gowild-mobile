import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';

import '../../constants/colors.dart';
import '../../widgets/auth_widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  bool? _success;
  String? _userEmail;
  void _register() async {
    final User? user = (await auth.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    ))
        .user;
    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
      });
    } else {
      setState(() {
        _success = true;
      });
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
                _register();
                // AuthenticationHelper()
                //     .signUp(
                //         email: emailController.text,
                //         password: passwordController.text)
                //     .then((result) {
                //   if (result == null) {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: ((context) => const VerifyPhoneScreen())));
                //   } else {
                //     print('denied');
                //   }
                // });
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
