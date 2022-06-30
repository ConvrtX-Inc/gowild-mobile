import 'package:flutter/material.dart';
import 'package:gowild_mobile/helper/authentication_helper.dart';
// import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:gowild_mobile/root.dart';
import 'package:gowild_mobile/services/dio_client.dart';
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
  final _formKey = GlobalKey<FormState>();
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
          _returnString = await AuthenticationHelper().loginUserWithGoogle();
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
                      builder: (context) => const MainNavigation()),
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
                      builder: (context) => const MainNavigation()),
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              titleTextWithAsset("LOGIN", 'assets/leaf.png'),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () async {
                  // final res = await fb.logIn(permissions: [
                  //   FacebookPermission.publicProfile,
                  //   FacebookPermission.email,
                  // ]);

                  // switch (res.status) {
                  //   case FacebookLoginStatus.success:
                  //     final accessToken = res.accessToken;

                  //     final profile = await fb.getUserProfile();
                  //     print(
                  //         'Hello, ${profile!.name}! You ID: ${profile.userId}');

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
                onTap: () async {
                  await AuthenticationHelper().loginUserWithGoogle();
                },
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
              buildTextField(context, 'Email', emailController,
                  'myemail@gowild.com', false, (value) {
                if (value == null ||
                    value.isEmpty ||
                    !value.contains('@') ||
                    !value.contains('.') ||
                    !value.endsWith('.com')) {
                  return 'Invalid Email';
                }
                return value;
              }),
              buildTextField(
                  context, 'Password', passwordController, '***********', true,
                  (value) {
                return value!;
                // RegExp regex = RegExp(
                //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                // if (value!.isEmpty) {
                //   return 'Please enter password';
                // } else {
                //   if (!regex.hasMatch(value)) {
                //     return 'Enter valid password';
                //   } else {
                //     return value;
                //   }
                // }
              }),
              forgotPassword(),
              const SizedBox(height: 10),
              mainAuthButton(context, "Login", () async {
                try {
                  final res = await DioClient()
                      .loginUser(emailController.text, passwordController.text);

                  if (res.toJson().isNotEmpty) {
                    isFirstTime().then((isFirstTime) {
                      // final storage =
                      //     SecureStorage.saveSharedPrefsValueInString(
                      //         SecureStorage.userTokenKey,
                      //         isFirstTime.toString());
                      // print(storage);
                      isFirstTime
                          ? Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainNavigation()),
                              (route) => false)
                          : Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainNavigation()),
                              (route) => false);
                    });
                  }
                } catch (e) {
                  var snackBar = SnackBar(content: Text(e.toString()));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                    context, "Dont't have an account? ", "Register"),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
