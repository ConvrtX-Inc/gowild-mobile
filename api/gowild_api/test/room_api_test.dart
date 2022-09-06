import 'package:test/test.dart';
import 'package:gowild_api/gowild_api.dart';


/// tests for RoomApi
void main() {
  final instance = GowildApi().getRoomApi();

  group(RoomApi, () {
    // Create one Room
    //
    //Future<Room> createOneBaseRoomControllerRoom(Room room) async
    test('test createOneBaseRoomControllerRoom', () async {
      // TODO
    });

    // Delete one Room
    //
    //Future deleteOneBaseRoomControllerRoom(String id) async
    test('test deleteOneBaseRoomControllerRoom', () async {
      // TODO
    });

    // Retrieve many Room
    //
    //Future<GetManyBaseRoomControllerRoom200Response> getManyBaseRoomControllerRoom({ BuiltList<String> fields, String s, BuiltList<String> filter, BuiltList<String> or, BuiltList<String> sort, BuiltList<String> join, int limit, int offset, int page, int cache }) async
    test('test getManyBaseRoomControllerRoom', () async {
      // TODO
    });

    // Retrieve one Room
    //
    //Future<Room> getOneBaseRoomControllerRoom(String id, { BuiltList<String> fields, BuiltList<String> join, int cache }) async
    test('test getOneBaseRoomControllerRoom', () async {
      // TODO
    });

    // Update one Room
    //
    //Future<Room> updateOneBaseRoomControllerRoom(String id, Room room) async
    test('test updateOneBaseRoomControllerRoom', () async {
      // TODO
    });

  });
}
