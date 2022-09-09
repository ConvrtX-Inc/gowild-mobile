import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gowild/constants/colors.dart';
import 'package:gowild/constants/social.dart';
import 'package:gowild/providers/login.service.dart';
import 'package:gowild/services/logging.dart';
import 'package:gowild/ui/widgets/auth_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterScreen extends HookConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginService = ref.watch(loginProvider);
    final params = useState(SimpleRegister());
    final formKey = useMemoized(
      () => GlobalKey<FormBuilderState>(),
    );

    final goVerifyPhoneNumber = useCallback(() {
      context.beamToNamed('/auth/register/verify-phone-number');
    }, []);

    final onRegister = useCallback(() async {
      try {
        if (!formKey.currentState!.validate()) {
          return;
        }

        await loginService.register(params.value);
        await loginService.simpleLogin(SimpleLogin.from(params.value));

        goVerifyPhoneNumber();
      } catch (e) {
        logger.e(e);
        const snackBar = SnackBar(content: Text('Error by registration'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }, []);

    return Scaffold(
      backgroundColor: primaryBlack,
      body: SingleChildScrollView(
        child: FormBuilder(
          key: formKey,
          child: Column(
            children: [
              const TitleTextWithAssetWidget(
                assetFileName: 'assets/register_leaf.png',
                text: 'REGISTER',
              ),
              const SizedBox(
                height: 30,
              ),
              SocialContainerWidget(
                color: facebookColor,
                assetLogo: 'assets/facebook_logo.png',
                title: 'Log in with Facebook',
                onTap: () {
                  logger.i('Should login with Facebook');
                },
                type: SocialType.facebook,
              ),
              SocialContainerWidget(
                color: googleColor,
                assetLogo: 'assets/google_logo.png',
                title: 'Login in with Google',
                onTap: () {
                  logger.i('Should login with Google');
                },
                type: SocialType.google,
              ),
              const SizedBox(
                height: 20,
              ),
              const OrTextWidget(),
              const SizedBox(
                height: 20,
              ),
              AuthTextField(
                name: 'firstName',
                onChanged: (value) => params.value.firstName = value ?? '',
                hintText: 'John',
                obscureText: false,
                titleText: 'First name',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              AuthTextField(
                name: 'lastName',
                onChanged: (value) => params.value.lastName = value ?? '',
                hintText: 'Doe',
                obscureText: false,
                titleText: 'Last name',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              AuthTextField(
                name: 'email',
                onChanged: (value) => params.value.email = value ?? '',
                hintText: 'myemail@gowild.com',
                obscureText: false,
                titleText: 'Email',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
              ),
              AuthTextField(
                name: 'password',
                onChanged: (value) => params.value.password = value ?? '',
                hintText: '***********',
                obscureText: true,
                titleText: 'Password',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              AuthTextField(
                name: 'confirmPassword',
                onChanged: (value) =>
                    params.value.confirmPassword = value ?? '',
                hintText: '***********',
                obscureText: true,
                titleText: 'Confirm Password',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  (String? value) {
                    if (value != null &&
                        value.isNotEmpty &&
                        value != params.value.password) {
                      return 'Password should be identical';
                    }
                    return null;
                  }
                ]),
              ),
              MainAuthButtonWidget(
                text: 'Register',
                onTap: onRegister,
              ),
              const SizedBox(
                height: 30,
              ),
              const _LoginButtonWidget(),
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

class _LoginButtonWidget extends StatelessWidget {
  const _LoginButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Beamer.of(context).popToNamed('/auth');
      },
      child: RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(children: <TextSpan>[
          TextSpan(
            text: "Already have an account? ",
            style: TextStyle(color: Color(0xff6B6968), fontSize: 14),
          ),
          TextSpan(
            text: "Login",
            style: TextStyle(
                decoration: TextDecoration.underline,
                color: kprimaryRed,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
        ]),
      ),
    );
  }
}
