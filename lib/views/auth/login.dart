import 'package:flutter/material.dart';
import 'package:gowild_mobile/helper/authentication_helper.dart';
import 'package:gowild_mobile/models/user_model.dart';
import 'package:gowild_mobile/root.dart';
import 'package:gowild_mobile/services/dio_client.dart';
import 'package:gowild_mobile/views/auth/e_waiver.dart';
import 'package:gowild_mobile/views/home.dart';
import 'package:gowild_mobile/views/main_screen.dart';
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
  // final fb = FacebookLogin();
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _loginUser({
    @required LoginType? type,
    String? email,
    String? password,
    required BuildContext context,
  }) async {
    // final prefs = await SharedPreferences.getInstance();
    try {
      dynamic _returnString;
      _returnString = await DioClient().loginUser(email!, password!);
      switch (type) {
        case LoginType.email:
          _returnString = await DioClient().loginUser(email, password);

          // _returnString = await AuthenticationHelper()
          //     .loginUser(emailController.text, passwordController.text);
          final Map<String, dynamic> emailAndPass = {
            'email': emailController.text,
            'password': passwordController.text
          };
          await AuthenticationHelper().emailLogin(emailAndPass, context);

          break;
        case LoginType.google:
          _returnString = await DioClient().postGoogleLogin();
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
      } else if (_returnString != null) {
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

  Future<void> googleLogin() async {
    try {
      var _returnString = await DioClient().postGoogleLogin();
      if (_returnString != null) {
        // final Map<String, dynamic> userDetails = {
        //   'email': emailController.text,
        //   'password': passwordController.text,
        // };
        // String _returnString =
        //     await DioClient().
        // await AuthenticationHelper().saveUserDetails(userDetails);
        // if (_returnString == "success") {
        //   print('success');
        // }
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
            InkWell(
              onTap: () async {
                // final res = await fb.logIn(permissions: [
                //   // FacebookPermission.publicProfile,
                //   // FacebookPermission.email,
                // ]);

                // switch (res.status) {
                //   // case FacebookLoginStatus.success:
                //     final accessToken = res.accessToken;

                //     final profile = await fb.getUserProfile();
                //     print('Hello, ${profile!.name}! You ID: ${profile.userId}');

                //     final email = await fb.getUserEmail();

                //     if (email != null) print('And your email is $email');

                //     break;
                //   case FacebookLoginStatus.cancel:
                //     break;
                //   case FacebookLoginStatus.error:
                //     print('Error while log in: ${res.error}');
                //     break;
                // }
              },
              child: socialContainer(context, facebookColor,
                  'assets/facebook_logo.png', 'Log in with Facebook'),
            ),
            InkWell(
              onTap: () => _loginUser(type: LoginType.google, context: context),
              child: socialContainer(context, googleColor,
                  'assets/google_logo.png', 'Log in with Google'),
            ),
            const SizedBox(
              height: 20,
            ),
            orText(),
            const SizedBox(
              height: 20,
            ),
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
            forgotPassword(),
            const SizedBox(height: 10),
            mainAuthButton(context, "Login", () async {
              try {
                final res = await DioClient()
                    .loginUser(emailController.text, passwordController.text);
                if (res.toJson().isNotEmpty) {
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
                            MaterialPageRoute(
                                builder: (context) => const MainNavigation()),
                            (route) => false);
                  });
                }
              } catch (e) {
                print(e.toString());
              }
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
