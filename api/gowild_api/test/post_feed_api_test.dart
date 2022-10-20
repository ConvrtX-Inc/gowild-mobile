import 'package:test/test.dart';
import 'package:gowild_api/gowild_api.dart';


/// tests for PostFeedApi
void main() {
  final instance = GowildApi().getPostFeedApi();

  group(PostFeedApi, () {
    // Create one PostFeed
    //
    //Future<PostFeed> createOneBasePostFeedControllerPostFeed(PostFeed postFeed) async
    test('test createOneBasePostFeedControllerPostFeed', () async {
      // TODO
    });

    // Delete one PostFeed
    //
    //Future deleteOneBasePostFeedControllerPostFeed(String id) async
    test('test deleteOneBasePostFeedControllerPostFeed', () async {
      // TODO
    });

    // Retrieve many PostFeed
    //
    //Future<GetManyPostFeedResponseDto> getManyBasePostFeedControllerPostFeed({ BuiltList<String> fields, String s, BuiltList<String> filter, BuiltList<String> or, BuiltList<String> sort, BuiltList<String> join, int limit, int offset, int page, int cache }) async
    test('test getManyBasePostFeedControllerPostFeed', () async {
      // TODO
    });

    // Retrieve one PostFeed
    //
    //Future<PostFeed> getOneBasePostFeedControllerPostFeed(String id, { BuiltList<String> fields, BuiltList<String> join, int cache }) async
    test('test getOneBasePostFeedControllerPostFeed', () async {
      // TODO
    });

    // Get friends post
    //
    //Future postFeedControllerGetFriendsPost(String userId) async
    test('test postFeedControllerGetFriendsPost', () async {
      // TODO
    });

    // Get posts from other users
    //
    //Future postFeedControllerGetPostsFromOtherUsers(String userId) async
    test('test postFeedControllerGetPostsFromOtherUsers', () async {
      // TODO
    });

    // Update one PostFeed
    //
    //Future<PostFeed> updateOneBasePostFeedControllerPostFeed(String id, PostFeed postFeed) async
    test('test updateOneBasePostFeedControllerPostFeed', () async {
      // TODO
    });

  });
}
