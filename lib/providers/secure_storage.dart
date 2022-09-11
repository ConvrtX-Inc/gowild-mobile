import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// ignore: avoid_classes_with_only_static_members
/// Class of SecureStorage
class SecureStorage {
  final String key;

  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  /// Returns user_token key;
  static const String userTokenKey = 'user_token';

  /// Returns user_id key;
  static const String userIdKey = 'user_id';

  /// Returns refresh token key
  static const String ssoTokenKey = 'sso_token';

  //Returns bool if user is logged in for the first time
  static const String isFirstTime = 'first_time';

  SecureStorage(this.key);

  /// For saving secure string
  Future<void> saveValue({required String value}) async {
    await _secureStorage.write(
      key: key,
      value: value,
    );
  }

  /// For reading secure string
  Future<String?> readValue() async {
    final value = await _secureStorage.read(
      key: key,
    );
    return value;
  }

  /// For reading secure string
  Future<void> removeValue() async {
    await _secureStorage.delete(
      key: key,
    );
  }

  /// Deleting all the secure keys of current user
  static Future<void> deleteKeys() async {
    await _secureStorage.deleteAll();
  }
}
