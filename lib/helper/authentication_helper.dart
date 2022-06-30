import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gowild_mobile/services/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gowild_mobile/constants/api_path_constants.dart';
import 'package:gowild_mobile/services/api_services.dart';
import 'package:gowild_mobile/services/secure_storage.dart';
import 'package:gowild_mobile/views/main_screen.dart';
import '../models/user_model.dart';

class AuthenticationHelper extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel _currentUser = UserModel();
  String? _email;
  User? _user;
  String _token = '';
  User get user => _user!;

  UserModel get getCurrentUser => _currentUser;

  String? get getEmail => _currentUser.email;
  String get tokenUser => _token;
  // Future<String> signUpUser(
  //   String email,
  //   String password,
  // ) async {
  //   String retVal = "error";

  //   try {
  //     UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
  //         email: email.trim(), password: password);

  //     _currentUser.uid = _authResult.user?.uid;
  //     _currentUser.email = _authResult.user?.email;

  //     _currentUser.accountCreated = DateTime.now();

  //     if (_currentUser != null) {
  //       retVal = 'success';
  //     }
  //   } on PlatformException catch (e) {
  //     retVal = e.message!;
  //   } catch (e) {
  //     print(e);
  //   }
  //   notifyListeners();
  //   return retVal;
  // }

  Future<bool> authenticateToken() async {
    try {
      final dynamic response = await ApiServices().request(
          ApiPathConstants.authUrl, RequestType.GET,
          needAccessToken: true);
      print(response);
      if (response['status'] != 200) {
        return false;
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future loggedOnce() async {
    final prefs = await SharedPreferences.getInstance();
    final init = await prefs.setBool("initScreen", true);

    print('checked user if once logeged');
  }

  Future<void> saveUserDetails(Map<String, dynamic> userDetails) async {
    try {
      final dynamic response = await ApiServices().request(
          ApiPathConstants.registerUrl, RequestType.POST,
          data: userDetails);
      print(response);
    } catch (e) {
      rethrow;
    }
  }

  // Future<String> loginUser(String email, String password) async {
  //   String retVal = 'error';
  //   try {
  //     UserCredential _authResult = await _auth.signInWithEmailAndPassword(
  //         email: email, password: password);

  //     if (_currentUser != null) {
  //       // await prefs.setBool("initScreen", true);
  //       retVal = 'success';
  //     }
  //   } catch (e) {
  //     retVal = e.toString();
  //   }
  //   notifyListeners();
  //   return retVal;
  // }

  Future<void> emailLogin(
      Map<String, dynamic> emailAndPassword, BuildContext context) async {
    try {
      final dynamic response = await ApiServices().request(
          ApiPathConstants.loginUrl, RequestType.POST,
          data: emailAndPassword);
      print(response);
      if (response is Map<String, dynamic>) {
        await SecureStorage.saveValue(
            key: SecureStorage.userTokenKey, value: response['token']);
        await SecureStorage.saveValue(
            key: SecureStorage.userIdKey, value: response['user']['id']);
        await Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MainNavigation()));
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> onStartUp() async {
    String retVal = 'error';
    try {
      // User? _firebaseUser = _auth.currentUser;
      _currentUser = await DioClient().getUser();
      if (_currentUser.toJson().values.isNotEmpty) {
        print('success');

        print('initScreen ${loggedOnce}');

        retVal = 'success';
      }
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> loginUserWithGoogle() async {
    String retVal = "error";
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    UserModel _users = UserModel();
    try {
      GoogleSignInAccount? _googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication _googleAuth =
          await _googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);

      UserCredential _authResult = await _auth.signInWithCredential(credential);
      if (_authResult.additionalUserInfo!.isNewUser) {
        _users.uid = _authResult.user!.uid;
        _users.email = _authResult.user!.email;
        _users.fullName = _authResult.user!.displayName;
        await DioClient().postGoogleLogin(_googleAuth.accessToken.toString());
      }

      if (_currentUser != null) {
        retVal = "success";
      }
    } on PlatformException catch (e) {
      retVal = e.message!;
      print(retVal);
    } catch (e) {
      // retVal = e.message;
      print(e);
    }
    return retVal;
  }

  Future<String> onSignOut() async {
    String retVal = "error";
    try {
      // await _auth.signOut();

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
