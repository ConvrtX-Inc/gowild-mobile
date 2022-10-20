import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gowild/constants/colors.dart';
import 'package:gowild/providers/login.service.dart';
import 'package:gowild/ui/widgets/auth_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateNewPasswordScreen extends HookConsumerWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginService = ref.watch(loginProvider);
    final params = useState(CreateNewPassword());
    final formKey = useMemoized(
      () => GlobalKey<FormBuilderState>(),
    );

    final navigateAfter = useCallback(() {
      Beamer.of(context).beamToNamed('/auth/e-waiver');
    }, []);

    final onLogin = useCallback(() async {
      // TODO
      navigateAfter();

      if (!formKey.currentState!.validate()) {
        return;
      }

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
      body: FormBuilder(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                left: 30,
                top: 176,
              ),
              child: Text(
                'Create New',
                style: TextStyle(
                    color: primaryYellow,
                    fontSize: 50,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'TheForegenRegular'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                'Password',
                style: TextStyle(
                    color: primaryYellow,
                    fontSize: 50,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                'Your password must be different from',
                style: TextStyle(
                    color: secondaryWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                'Previous used passwords',
                style: TextStyle(
                    color: secondaryWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, bottom: 5),
              child: AuthTextField(
                name: 'password',
                onChanged: (value) => params.value.password = value ?? '',
                hintText: '***********',
                obscureText: true,
                titleText: 'Password',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, bottom: 5),
              child: AuthTextField(
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
            ),
            const SizedBox(
              height: 80,
            ),
            MainAuthButtonWidget(
              text: 'Reset Password',
              onTap: onLogin,
            )
          ],
        ),
      ),
    );
  }
}
