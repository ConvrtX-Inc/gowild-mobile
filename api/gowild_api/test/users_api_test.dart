import 'package:test/test.dart';
import 'package:gowild_api/gowild_api.dart';


/// tests for UsersApi
void main() {
  final instance = GowildApi().getUsersApi();

  group(UsersApi, () {
    // Create one User
    //
    //Future<User> createOneBaseUsersControllerUser(User user) async
    test('test createOneBaseUsersControllerUser', () async {
      // TODO
    });

    // Delete one User
    //
    //Future deleteOneBaseUsersControllerUser(String id) async
    test('test deleteOneBaseUsersControllerUser', () async {
      // TODO
    });

    // Retrieve many User
    //
    //Future<GetManyBaseUsersControllerUser200Response> getManyBaseUsersControllerUser({ BuiltList<String> fields, String s, BuiltList<String> filter, BuiltList<String> or, BuiltList<String> sort, BuiltList<String> join, int limit, int offset, int page, int cache }) async
    test('test getManyBaseUsersControllerUser', () async {
      // TODO
    });

    // Retrieve one User
    //
    //Future<User> getOneBaseUsersControllerUser(String id, { BuiltList<String> fields, BuiltList<String> join, int cache }) async
    test('test getOneBaseUsersControllerUser', () async {
      // TODO
    });

    // Update one User
    //
    //Future<User> updateOneBaseUsersControllerUser(String id, User user) async
    test('test updateOneBaseUsersControllerUser', () async {
      // TODO
    });

    // Approved an user.
    //
    //Future usersControllerApproveUser(String id) async
    test('test usersControllerApproveUser', () async {
      // TODO
    });

    // Reject an user.
    //
    //Future usersControllerRejectUser(String id) async
    test('test usersControllerRejectUser', () async {
      // TODO
    });

  });
}
