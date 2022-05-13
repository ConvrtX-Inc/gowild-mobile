import 'package:flutter/material.dart';

import 'package:gowild_mobile/views/main_screen.dart';

import 'helper/authentication_helper.dart';
import 'package:provider/provider.dart';

import 'views/splash_screen.dart';

enum AuthStatus { notLoggedIn, loggedIn }

class Root extends StatefulWidget {
  const Root({
    Key? key,
  }) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  AuthStatus _authStatus = AuthStatus.notLoggedIn;

  Widget screen = const Scaffold(
      body: Center(
    child: CircularProgressIndicator(),
  ));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNextScreen();
  }

  getNextScreen() async {
    bool isAuthenticated = await AuthenticationHelper().authenticateToken();

    if (isAuthenticated) {
      setState(() {
        screen = MainNavigation();
      });
    } else {
      setState(() {
        screen = SpashScreen();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return screen;
  }
}
