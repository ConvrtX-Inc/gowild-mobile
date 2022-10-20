import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gowild/constants/colors.dart' as app_color_constants;
import 'package:gowild/navigation.dart';
import 'package:gowild/providers/init.dart';
import 'package:gowild/ui/screens/app/app-error.screen.dart';
import 'package:gowild/ui/screens/app/spash.screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        // GlobalMaterialLocalizations.delegate,
        // GlobalWidgetsLocalizations.delegate,
        FormBuilderLocalizations.delegate,
      ],
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(fontFamily: 'TheForegenRegular'),
        ),
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: app_color_constants.scaffoldColor,
        textTheme: GoogleFonts.sourceSansProTextTheme(),
      ),
      routeInformationParser: BeamerParser(),
      routerDelegate: routerDelegate,
      builder: (context, child) => Root(widget: child ?? const SplashScreen()),
      backButtonDispatcher: BeamerBackButtonDispatcher(
        delegate: routerDelegate,
      ),
    );
  }
}

class Root extends HookConsumerWidget {
  final Widget widget;

  const Root({super.key, required this.widget});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final init$ = ref.watch(initProvider);

    return init$.when(
      data: (data) => ResponsiveWrapper.builder(
        widget,
        maxWidth: 1200,
        minWidth: 480,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(480, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(800, name: TABLET),
          const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
        ],
      ),
      error: (error, stackTrace) => AppErrorScreen(
        error: error,
      ),
      loading: () => const SplashScreen(),
    );
  }
}
