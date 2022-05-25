import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gowild_mobile/helper/authentication_helper.dart';
import 'package:gowild_mobile/helper/map_helper.dart';
import 'package:gowild_mobile/root.dart';
import 'package:gowild_mobile/views/main_screen.dart';

import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:gowild_mobile/constants/colors.dart' as AppColorConstants;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationHelper>(
            create: (_) => AuthenticationHelper()),
        ChangeNotifierProvider<MapHelper>(create: (_) => MapHelper()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          builder: (context, widget) => ResponsiveWrapper.builder(
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
          home: const Root(),
          title: 'Flutter Demo',
          theme: ThemeData(
              appBarTheme: AppBarTheme(
                  titleTextStyle: TextStyle(fontFamily: 'TheForegenRegular')),
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: AppColorConstants.scaffoldColor,
              textTheme: GoogleFonts.sourceSansProTextTheme())),
    );
  }
}
