import 'package:flutter/material.dart';
import 'package:gowild_mobile/views/auth/login.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    'Phone number',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  child: Container(
                      height: 90,
                      width: size.width * 0.9,
                      padding: const EdgeInsets.all(8.0),
                      child: IntlPhoneField(
                        cursorColor: const Color(0xff6B6968),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xff6B6968), width: 2.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Color(0xff6B6968), width: 2.0)),
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
            ),
            buildTextField(context, 'Address Line 1', addressLine1Controller,
                '123 Street Name, City', false),
            buildTextField(context, 'Address Line 2', addressLine2Controller,
                'State, Country, Postal Code', false),
            mainAuthButton(context, 'Register'),
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
