import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: avoid_classes_with_only_static_members
/// Class of SecureStorage
class SecureStorage {
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  /// Shared Preference
  static late SharedPreferences sharedPrefs;

  ///Returns user_token key;
  static const String userTokenKey = 'user_token';

  ///Returns user_id key;
  static const String userIdKey = 'user_id';

  /// Returns refresh token key
  static const String ssoTokenKey = 'sso_token';

  /// For saving secure string
  static Future<void> saveValue(
      {required String key, required String value}) async {
    await _secureStorage.write(
      key: key,
      value: value,
      aOptions: const AndroidOptions(encryptedSharedPreferences: true),
    );
  }

  /// For reading secure string
  static Future<String?>? readValue({required String key}) async {
    String? value;
    // ignore: join_return_with_assignment
    value = await _secureStorage.read(
      key: key,
      aOptions: const AndroidOptions(encryptedSharedPreferences: true),
    );
    return value;
  }

  ///Deleting all the secure keys of current user
  static Future<void> deleteKeys() async {
    await _secureStorage.deleteAll(
      aOptions: const AndroidOptions(encryptedSharedPreferences: true),
    );
  }

  /// save value to shared prefs local storage as int
  static Future<bool> saveSharedPrefsValueInInt(String key, int value) async {
    sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.setInt(key, value);
  }

  /// save value to shared prefs local storage as string
  static Future<bool> saveSharedPrefsValueInString(
      String key, String value) async {
    sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.setString(key, value);
  }

  /// get value from shared prefs local storage
  static Future<dynamic> getSharedPrefsValue(String key) async {
    sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.get(key);
  }
}
