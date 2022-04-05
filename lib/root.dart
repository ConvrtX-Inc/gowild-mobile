import 'package:flutter/material.dart';
import 'package:gowild_mobile/views/home.dart';
import 'helper/authentication_helper.dart';
import 'views/auth/e_waiver.dart';
import 'package:provider/provider.dart';

import 'views/splash_screen.dart';

enum AuthStatus { notLoggedIn, loggedIn }

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  AuthStatus _authStatus = AuthStatus.notLoggedIn;
  String? currentUid;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    AuthenticationHelper _user =
        Provider.of<AuthenticationHelper>(context, listen: false);

    String returnString = await _user.onStartUp();

    if (returnString == 'success') {
      setState(() {
        _authStatus = AuthStatus.loggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget? retVal;

    switch (_authStatus) {
      case AuthStatus.notLoggedIn:
        retVal = const SpashScreen();
        break;
      case AuthStatus.loggedIn:
        retVal = const HomeScreen();
        break;
      default:
    }
    return retVal!;
  }
}
