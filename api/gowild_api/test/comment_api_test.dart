import 'package:test/test.dart';
import 'package:gowild_api/gowild_api.dart';


/// tests for CommentApi
void main() {
  final instance = GowildApi().getCommentApi();

  group(CommentApi, () {
    // Create one Comment
    //
    //Future<Comment> createOneBaseCommentControllerComment(Comment comment) async
    test('test createOneBaseCommentControllerComment', () async {
      // TODO
    });

    // Delete one Comment
    //
    //Future deleteOneBaseCommentControllerComment(String id) async
    test('test deleteOneBaseCommentControllerComment', () async {
      // TODO
    });

    // Retrieve many Comment
    //
    //Future<GetManyBaseCommentControllerComment200Response> getManyBaseCommentControllerComment({ BuiltList<String> fields, String s, BuiltList<String> filter, BuiltList<String> or, BuiltList<String> sort, BuiltList<String> join, int limit, int offset, int page, int cache }) async
    test('test getManyBaseCommentControllerComment', () async {
      // TODO
    });

    // Retrieve one Comment
    //
    //Future<Comment> getOneBaseCommentControllerComment(String id, { BuiltList<String> fields, BuiltList<String> join, int cache }) async
    test('test getOneBaseCommentControllerComment', () async {
      // TODO
    });

    // Update one Comment
    //
    //Future<Comment> updateOneBaseCommentControllerComment(String id, Comment comment) async
    test('test updateOneBaseCommentControllerComment', () async {
      // TODO
    });

  });
}
