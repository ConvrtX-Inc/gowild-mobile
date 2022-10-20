import 'package:test/test.dart';
import 'package:gowild_api/gowild_api.dart';


/// tests for StatusApi
void main() {
  final instance = GowildApi().getStatusApi();

  group(StatusApi, () {
    // Create one Status
    //
    //Future<Status> createOneBaseStatusControllerStatus(Status status) async
    test('test createOneBaseStatusControllerStatus', () async {
      // TODO
    });

    // Delete one Status
    //
    //Future deleteOneBaseStatusControllerStatus(String id) async
    test('test deleteOneBaseStatusControllerStatus', () async {
      // TODO
    });

    // Retrieve many Status
    //
    //Future<GetManyStatusResponseDto> getManyBaseStatusControllerStatus({ BuiltList<String> fields, String s, BuiltList<String> filter, BuiltList<String> or, BuiltList<String> sort, BuiltList<String> join, int limit, int offset, int page, int cache }) async
    test('test getManyBaseStatusControllerStatus', () async {
      // TODO
    });

    // Retrieve one Status
    //
    //Future<Status> getOneBaseStatusControllerStatus(String id, { BuiltList<String> fields, BuiltList<String> join, int cache }) async
    test('test getOneBaseStatusControllerStatus', () async {
      // TODO
    });

    // Update one Status
    //
    //Future<Status> updateOneBaseStatusControllerStatus(String id, Status status) async
    test('test updateOneBaseStatusControllerStatus', () async {
      // TODO
    });

  });
}
