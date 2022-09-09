import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gowild/constants/colors.dart';
import 'package:gowild/constants/social.dart';
import 'package:gowild/providers/new_in_app_provider.dart';
import 'package:gowild/providers/login.service.dart';
import 'package:gowild/services/logging.dart';
import 'package:gowild/ui/widgets/auth_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginService = ref.watch(loginProvider);
    final newInAppService = ref.watch(isNewInAppProvider);

    final params = useState(SimpleLogin());
    final formKey = useMemoized(
      () => GlobalKey<FormBuilderState>(),
    );

    final navigateAfter = useCallback((bool isNew) {
      if (isNew) {
        context.beamToNamed('/auth/e-waiver');
      } else {
        context.beamToNamed('/main');
      }
    }, []);

    final onLogin = useCallback(() async {
      try {
        if (!formKey.currentState!.validate()) {
          return;
        }

        await loginService.simpleLogin(params.value);
        navigateAfter(newInAppService.isNewInApp);
      } catch (e) {
        logger.e(e);
        const snackBar = SnackBar(content: Text('Error by Login'));
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
                assetFileName: 'assets/leaf.png',
                text: 'LOGIN',
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
                title: 'Log in with Google',
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
              const ForgotPasswordButtonWidget(),
              const SizedBox(height: 10),
              MainAuthButtonWidget(
                text: 'Login',
                onTap: onLogin,
              ),
              const SizedBox(
                height: 30,
              ),
              const RegisterButtonWidget(),
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

class RegisterButtonWidget extends StatelessWidget {
  const RegisterButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Beamer.of(context).beamToNamed('/auth/register');
      },
      child: RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(children: <TextSpan>[
          TextSpan(
            text: "Dont't have an account? ",
            style: TextStyle(color: Color(0xff6B6968), fontSize: 14),
          ),
          TextSpan(
            text: "Register",
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
