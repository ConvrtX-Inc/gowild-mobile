import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:gowild_mobile/constants/api_path_constants.dart';
import 'package:gowild_mobile/constants/app_text_constants.dart';
import 'package:gowild_mobile/models/notifications.dart';
import 'package:gowild_mobile/models/tickets.dart';
import 'package:gowild_mobile/services/api_services.dart';
import 'package:gowild_mobile/services/firebase_storage.dart';
import 'package:gowild_mobile/services/secure_storage.dart';

class Database {
  static Database? _database;

  static Database get instance {
    _database;
    return _database!;
  }

  static Future<dynamic> editProfile(
      Map<String, dynamic> details, BuildContext context) async {
    final String? userId =
        await SecureStorage.readValue(key: SecureStorage.userIdKey);

    try {
      // ignore: cascade_invocations
      details.removeWhere((String key, dynamic value) => value == null);

      print(details);

      final int response = await ApiServices().request(
          '${ApiPathConstants.usersUrl}$userId', RequestType.PATCH,
          data: details, needAccessToken: true, returnStatusCodeOnly: true);
      print(response);
      if (response != 200 && response != 201) {
        return showOkAlertDialog(
            context: context,
            title: AppTextConstants.editProfileTitle,
            message: AppTextConstants.editProfileMessage);
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<Tickets> getTickets() async {
    final String? userId =
        await SecureStorage.readValue(key: SecureStorage.userIdKey);
    try {
      final dynamic response = await ApiServices().request(
          '${ApiPathConstants.ticketsUrl}?user_id||\$eq||"$userId"',
          RequestType.GET,
          needAccessToken: true);
      print(response.runtimeType);

      if (response is Map<String, dynamic>) {
        return Tickets.fromJson(response);
      }

      return Tickets();
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> addTicket(
      Map<String, dynamic> ticketDetails, BuildContext context) async {
    final String? userId =
        await SecureStorage.readValue(key: SecureStorage.userIdKey);

    try {
      String? imageFbUrl = await FBStorage.uploadPicture(
          ticketDetails['file'], ticketDetails['file_name']);
      ticketDetails['img_url'] = imageFbUrl;
      ticketDetails['user_id'] = userId;
      print(ticketDetails);
      final dynamic response = await ApiServices().request(
          ApiPathConstants.ticketsUrl, RequestType.POST,
          needAccessToken: true, data: ticketDetails);
      print(response);
      Navigator.pop(context);
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
