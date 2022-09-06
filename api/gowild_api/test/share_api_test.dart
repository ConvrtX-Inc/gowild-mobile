import 'package:test/test.dart';
import 'package:gowild_api/gowild_api.dart';


/// tests for ShareApi
void main() {
  final instance = GowildApi().getShareApi();

  group(ShareApi, () {
    // Create one Share
    //
    //Future<Share> createOneBaseShareControllerShare(Share share) async
    test('test createOneBaseShareControllerShare', () async {
      // TODO
    });

    // Delete one Share
    //
    //Future deleteOneBaseShareControllerShare(String id) async
    test('test deleteOneBaseShareControllerShare', () async {
      // TODO
    });

    // Retrieve many Share
    //
    //Future<GetManyBaseShareControllerShare200Response> getManyBaseShareControllerShare({ BuiltList<String> fields, String s, BuiltList<String> filter, BuiltList<String> or, BuiltList<String> sort, BuiltList<String> join, int limit, int offset, int page, int cache }) async
    test('test getManyBaseShareControllerShare', () async {
      // TODO
    });

    // Retrieve one Share
    //
    //Future<Share> getOneBaseShareControllerShare(String id, { BuiltList<String> fields, BuiltList<String> join, int cache }) async
    test('test getOneBaseShareControllerShare', () async {
      // TODO
    });

    // Update one Share
    //
    //Future<Share> updateOneBaseShareControllerShare(String id, Share share) async
    test('test updateOneBaseShareControllerShare', () async {
      // TODO
    });

  });
}
