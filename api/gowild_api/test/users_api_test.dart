import 'package:test/test.dart';
import 'package:gowild_api/gowild_api.dart';


/// tests for UsersApi
void main() {
  final instance = GowildApi().getUsersApi();

  group(UsersApi, () {
    // Create one UserEntity
    //
    //Future<UserEntity> createOneBaseUsersControllerUserEntity(UserEntity userEntity) async
    test('test createOneBaseUsersControllerUserEntity', () async {
      // TODO
    });

    // Delete one UserEntity
    //
    //Future deleteOneBaseUsersControllerUserEntity(String id) async
    test('test deleteOneBaseUsersControllerUserEntity', () async {
      // TODO
    });

    // Retrieve many UserEntity
    //
    //Future<GetManyUserEntityResponseDto> getManyBaseUsersControllerUserEntity({ BuiltList<String> fields, String s, BuiltList<String> filter, BuiltList<String> or, BuiltList<String> sort, BuiltList<String> join, int limit, int offset, int page, int cache }) async
    test('test getManyBaseUsersControllerUserEntity', () async {
      // TODO
    });

    // Retrieve one UserEntity
    //
    //Future<UserEntity> getOneBaseUsersControllerUserEntity(String id, { BuiltList<String> fields, BuiltList<String> join, int cache }) async
    test('test getOneBaseUsersControllerUserEntity', () async {
      // TODO
    });

    // Update one UserEntity
    //
    //Future<UserEntity> updateOneBaseUsersControllerUserEntity(String id, UserEntity userEntity) async
    test('test updateOneBaseUsersControllerUserEntity', () async {
      // TODO
    });

    // Approved an user.
    //
    //Future<UserEntity> usersControllerApproveUser(String id) async
    test('test usersControllerApproveUser', () async {
      // TODO
    });

    // Reject an user.
    //
    //Future<UserEntity> usersControllerRejectUser(String id) async
    test('test usersControllerRejectUser', () async {
      // TODO
    });

    // Update user's profile picture
    //
    //Future<UserEntity> usersControllerUpdateAvatar(String id, ImageUpdateDto imageUpdateDto) async
    test('test usersControllerUpdateAvatar', () async {
      // TODO
    });

  });
}
