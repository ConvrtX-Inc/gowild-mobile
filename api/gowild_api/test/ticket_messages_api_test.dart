import 'package:test/test.dart';
import 'package:gowild_api/gowild_api.dart';


/// tests for TicketMessagesApi
void main() {
  final instance = GowildApi().getTicketMessagesApi();

  group(TicketMessagesApi, () {
    // Create one TicketMessage
    //
    //Future<TicketMessage> createOneBaseTicketMessagesControllerTicketMessage(TicketMessage ticketMessage) async
    test('test createOneBaseTicketMessagesControllerTicketMessage', () async {
      // TODO
    });

    // Delete one TicketMessage
    //
    //Future deleteOneBaseTicketMessagesControllerTicketMessage(String id) async
    test('test deleteOneBaseTicketMessagesControllerTicketMessage', () async {
      // TODO
    });

    // Retrieve many TicketMessage
    //
    //Future<GetManyTicketMessageResponseDto> getManyBaseTicketMessagesControllerTicketMessage({ BuiltList<String> fields, String s, BuiltList<String> filter, BuiltList<String> or, BuiltList<String> sort, BuiltList<String> join, int limit, int offset, int page, int cache }) async
    test('test getManyBaseTicketMessagesControllerTicketMessage', () async {
      // TODO
    });

    // Retrieve one TicketMessage
    //
    //Future<TicketMessage> getOneBaseTicketMessagesControllerTicketMessage(String id, { BuiltList<String> fields, BuiltList<String> join, int cache }) async
    test('test getOneBaseTicketMessagesControllerTicketMessage', () async {
      // TODO
    });

    // Update one TicketMessage
    //
    //Future<TicketMessage> updateOneBaseTicketMessagesControllerTicketMessage(String id, TicketMessage ticketMessage) async
    test('test updateOneBaseTicketMessagesControllerTicketMessage', () async {
      // TODO
    });

  });
}
