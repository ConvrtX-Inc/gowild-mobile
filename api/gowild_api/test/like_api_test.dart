import 'package:test/test.dart';
import 'package:gowild_api/gowild_api.dart';


/// tests for LikeApi
void main() {
  final instance = GowildApi().getLikeApi();

  group(LikeApi, () {
    // Create one Like
    //
    //Future<Like> createOneBaseLikeControllerLike(Like like) async
    test('test createOneBaseLikeControllerLike', () async {
      // TODO
    });

    // Delete one Like
    //
    //Future deleteOneBaseLikeControllerLike(String id) async
    test('test deleteOneBaseLikeControllerLike', () async {
      // TODO
    });

    // Retrieve many Like
    //
    //Future<GetManyLikeResponseDto> getManyBaseLikeControllerLike({ BuiltList<String> fields, String s, BuiltList<String> filter, BuiltList<String> or, BuiltList<String> sort, BuiltList<String> join, int limit, int offset, int page, int cache }) async
    test('test getManyBaseLikeControllerLike', () async {
      // TODO
    });

    // Retrieve one Like
    //
    //Future<Like> getOneBaseLikeControllerLike(String id, { BuiltList<String> fields, BuiltList<String> join, int cache }) async
    test('test getOneBaseLikeControllerLike', () async {
      // TODO
    });

    // Update one Like
    //
    //Future<Like> updateOneBaseLikeControllerLike(String id, Like like) async
    test('test updateOneBaseLikeControllerLike', () async {
      // TODO
    });

  });
}
