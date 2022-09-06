import 'package:test/test.dart';
import 'package:gowild_api/gowild_api.dart';


/// tests for NotificationApi
void main() {
  final instance = GowildApi().getNotificationApi();

  group(NotificationApi, () {
    // Create one Notification
    //
    //Future<Notification> createOneBaseNotificationControllerNotification(Notification notification) async
    test('test createOneBaseNotificationControllerNotification', () async {
      // TODO
    });

    // Delete one Notification
    //
    //Future deleteOneBaseNotificationControllerNotification(String id) async
    test('test deleteOneBaseNotificationControllerNotification', () async {
      // TODO
    });

    // Retrieve many Notification
    //
    //Future<GetManyBaseNotificationControllerNotification200Response> getManyBaseNotificationControllerNotification({ BuiltList<String> fields, String s, BuiltList<String> filter, BuiltList<String> or, BuiltList<String> sort, BuiltList<String> join, int limit, int offset, int page, int cache }) async
    test('test getManyBaseNotificationControllerNotification', () async {
      // TODO
    });

    // Retrieve one Notification
    //
    //Future<Notification> getOneBaseNotificationControllerNotification(String id, { BuiltList<String> fields, BuiltList<String> join, int cache }) async
    test('test getOneBaseNotificationControllerNotification', () async {
      // TODO
    });

    // Update one Notification
    //
    //Future<Notification> updateOneBaseNotificationControllerNotification(String id, Notification notification) async
    test('test updateOneBaseNotificationControllerNotification', () async {
      // TODO
    });

  });
}
