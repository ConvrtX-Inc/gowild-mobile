import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:gowild_mobile/helper/authentication_helper.dart';
import 'package:gowild_mobile/models/user_model.dart';
import 'package:gowild_mobile/services/dio_client.dart';
import 'package:gowild_mobile/services/prefs_service.dart';
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
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final fb = FacebookLogin();
  final _preferenceService = PrefService();
  void saveUser() {
    final user = UserModel(
        email: emailController.text,
        password: passwordController.text,
        // uid: userFromFirebase?.uid,
        accountCreated: DateTime.now());

    print(user);
  }

  Future<void> _signUpUser(
      String email,
      String password,
      String fullName,
      String address1,
      String address2,
      String phoneNumber,
      BuildContext context) async {
    try {
      var _returnString = await DioClient().registerUser(
          email, password, fullName, address1, address2, phoneNumber);

      if (_returnString != null) {
        final Map<String, dynamic> userDetails = {
          'email': emailController.text,
          'password': passwordController.text,
          'full_name': fullNameController.text,
          'phone_no': phoneNumberController.text,
          'addressline1': addressLine1Controller.text,
          'addressline2': addressLine2Controller.text
        };
        String _returnString =
            await AuthenticationHelper().signUpUser(email, password);
        await AuthenticationHelper().saveUserDetails(userDetails);
        if (_returnString == "success") {
          print('success');

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => VerifyPhoneScreen(
                        phoneNumber: phoneNumber,
                      )),
              (route) => false);
        }
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
            InkWell(
              onTap: () async {
                await AuthenticationHelper().loginUserWithGoogle();
              },
              child: socialContainer(context, kgoogleColor,
                  'assets/google_logo.png', 'Sign in with Google'),
            ),
            InkWell(
              onTap: () async {
                final res = await fb.logIn(permissions: [
                  FacebookPermission.publicProfile,
                  FacebookPermission.email,
                ]);

                switch (res.status) {
                  case FacebookLoginStatus.success:
                    final accessToken = res.accessToken;

                    final profile = await fb.getUserProfile();
                    print('Hello, ${profile!.name}! You ID: ${profile.userId}');

                    final email = await fb.getUserEmail();

                    if (email != null) print('And your email is $email');

                    break;
                  case FacebookLoginStatus.cancel:
                    break;
                  case FacebookLoginStatus.error:
                    print('Error while log in: ${res.error}');
                    break;
                }
              },
              child: socialContainer(context, kfacebookColor,
                  'assets/facebook_logo.png', 'Sign in with Facebook'),
            ),
            buildTextField(context, 'Full name', fullNameController,
                'Jennylyn Aretcona', false, (String? value) {
              return value!;
            }),
            buildTextField(
                context, 'Email', emailController, 'myemail@gowild.com', false,
                (String? value) {
              return value!;
            }),
            buildTextField(
                context, 'Password', passwordController, '***********', true,
                (String? value) {
              return value!;
            }),
            buildTextField(
                context,
                'Confirm Password',
                confirmPasswordController,
                '***********',
                true, (String? value) {
              return value!;
            }),
            buildPhoneNumberTextField(context,
                controller: phoneNumberController),
            buildTextField(context, 'Address Line 1', addressLine1Controller,
                '123 Street Name, City', false, (String? value) {
              return value!;
            }),
            buildTextField(context, 'Address Line 2', addressLine2Controller,
                'State, Country, Postal Code', false, (String? value) {
              return value!;
            }),
            mainAuthButton(
                context,
                'Register',
                () async => await _signUpUser(
                    emailController.text,
                    passwordController.text,
                    fullNameController.text,
                    addressLine1Controller.text,
                    addressLine2Controller.text,
                    phoneNumberController.text,
                    context)),
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
