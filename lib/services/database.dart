import 'package:gowild_mobile/constants/api_path_constants.dart';
import 'package:gowild_mobile/models/notifications.dart';
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

  static Future<Notifications> getNotifications() async {
    final String? userId =
        await SecureStorage.readValue(key: SecureStorage.userIdKey);

    try {
      final dynamic response = await ApiServices().request(
          '${ApiPathConstants.notificationUrl}?user_id||\$eq||"$userId"',
          RequestType.GET,
          needAccessToken: true);
      print(response);

      if (response is List<Map<String, dynamic>>) {
        return Notifications.fromJson(response);
      }

      return Notifications();
    } catch (e) {
      rethrow;
    }
  }
}
