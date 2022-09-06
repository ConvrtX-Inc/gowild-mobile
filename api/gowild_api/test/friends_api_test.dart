import 'package:test/test.dart';
import 'package:gowild_api/gowild_api.dart';


/// tests for FriendsApi
void main() {
  final instance = GowildApi().getFriendsApi();

  group(FriendsApi, () {
    // Create one Friends
    //
    //Future<Friends> createOneBaseFriendsControllerFriends(Friends friends) async
    test('test createOneBaseFriendsControllerFriends', () async {
      // TODO
    });

    // Delete one Friends
    //
    //Future deleteOneBaseFriendsControllerFriends(String id) async
    test('test deleteOneBaseFriendsControllerFriends', () async {
      // TODO
    });

    // Get suggested friends list
    //
    //Future friendsControllerGetSuggestedFriends(String userId) async
    test('test friendsControllerGetSuggestedFriends', () async {
      // TODO
    });

    // Retrieve many Friends
    //
    //Future<GetManyBaseFriendsControllerFriends200Response> getManyBaseFriendsControllerFriends({ BuiltList<String> fields, String s, BuiltList<String> filter, BuiltList<String> or, BuiltList<String> sort, BuiltList<String> join, int limit, int offset, int page, int cache }) async
    test('test getManyBaseFriendsControllerFriends', () async {
      // TODO
    });

    // Retrieve one Friends
    //
    //Future<Friends> getOneBaseFriendsControllerFriends(String id, { BuiltList<String> fields, BuiltList<String> join, int cache }) async
    test('test getOneBaseFriendsControllerFriends', () async {
      // TODO
    });

    // Update one Friends
    //
    //Future<Friends> updateOneBaseFriendsControllerFriends(String id, Friends friends) async
    test('test updateOneBaseFriendsControllerFriends', () async {
      // TODO
    });

  });
}
