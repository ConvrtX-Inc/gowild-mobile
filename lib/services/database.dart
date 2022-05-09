import 'package:gowild_mobile/constants/api_path_constants.dart';
import 'package:gowild_mobile/services/api_services.dart';
import 'package:gowild_mobile/services/secure_storage.dart';

class Database {
  static Database? _database;

  static Database get instance {
    _database;
    return _database!;
  }

  static Future<void> editProfile(Map<String, dynamic> details) async {
    final String? userId =
        await SecureStorage.readValue(key: SecureStorage.userIdKey);

    try {
      // ignore: cascade_invocations
      details.removeWhere((String key, dynamic value) => value == null);
      final dynamic response = await ApiServices().request(
          '${ApiPathConstants.usersUrl}$userId', RequestType.PATCH,
          data: details, needAccessToken: true);
      print(response);
    } catch (e) {
      rethrow;
    }
  }
}
