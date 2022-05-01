import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

enum AuthStatus {
  Success,
  NewUser,
  UserNotFound,
  InvalidEmail,
  InvalidPassword,
  Error,
}

class AuthenticationHelper extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel _currentUser = UserModel();
  String? _email;
  User? _user;

  User get user => _user!;

  UserModel get getCurrentUser => _currentUser;

  String? get getEmail => _currentUser.email;

  Future<String> signUpUser(
    String email,
    String password,
  ) async {
    String retVal = "error";

    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);

      _currentUser.uid = _authResult.user?.uid;
      _currentUser.email = _authResult.user?.email;

      _currentUser.accountCreated = DateTime.now();

      if (_currentUser != null) {
        retVal = 'success';
      }
    } on PlatformException catch (e) {
      retVal = e.message!;
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return retVal;
  }

  Future loggedOnce() async {
    final prefs = await SharedPreferences.getInstance();
    final init = await prefs.setBool("initScreen", true);

    print('checked user if once logeged');
  }

  Future<String> loginUser(String email, String password) async {
    String retVal = 'error';

    try {
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (_currentUser != null) {
        // await prefs.setBool("initScreen", true);
        retVal = 'success';
      }
    } catch (e) {
      retVal = e.toString();
    }
    notifyListeners();
    return retVal;
  }

  Future<String> onStartUp() async {
    String retVal = 'error';
    try {
      User? _firebaseUser = _auth.currentUser;
      if (_firebaseUser != null) {
        if (_currentUser != null) {
          print('success');

          print('initScreen ${loggedOnce}');
          retVal = 'success';
        }
      }
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> onSignOut() async {
    String retVal = "error";
    try {
      await _auth.signOut();

      _email = null;
      _currentUser = UserModel();

      retVal = "success";
    } catch (e) {
      print(e);
    }

    notifyListeners();
    return retVal;
  }
}
