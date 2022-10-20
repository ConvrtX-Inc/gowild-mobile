import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gowild/constants/colors.dart';
import 'package:gowild/ui/widgets/auth_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ResetPasswordScreen extends HookConsumerWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();

    final navigateAfter = useCallback(() {
      Beamer.of(context).beamToNamed('/auth/reset-password/create-new-password');
    }, []);

    final onVerifyAccount = useCallback(() async {
      navigateAfter();
    }, []);

    return Scaffold(
      backgroundColor: primaryBlack,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: primaryYellow),
        elevation: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 30, top: 176, bottom: 50),
            child: Text(
              'RESET PASSWORD',
              style: TextStyle(
                  color: primaryYellow,
                  fontSize: 50,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'TheForegenRegular',
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30, bottom: 5),
            child: Text(
              'Enter your email ID or phone number',
              style: TextStyle(
                  color: secondaryWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              'associated with your account and we\'ll send',
              style: TextStyle(
                  color: secondaryWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30, bottom: 5),
            child: Text(
              'a verification code to reset your password',
              style: TextStyle(
                  color: secondaryWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          AuthTextField(
            padding: const EdgeInsets.only(left: 18, bottom: 5),
            name: 'email',
            controller: emailController,
            hintText: 'myemail@gowild.com',
            obscureText: false,
            titleText: 'Email',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.email(),
            ]),
          ),
          MainAuthButtonWidget(
            text: 'Verify account',
            onTap: onVerifyAccount,
          ),
        ],
      ),
    );
  }
}
