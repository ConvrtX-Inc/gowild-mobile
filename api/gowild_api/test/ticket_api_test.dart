import 'package:test/test.dart';
import 'package:gowild_api/gowild_api.dart';


/// tests for TicketApi
void main() {
  final instance = GowildApi().getTicketApi();

  group(TicketApi, () {
    // Create one Ticket
    //
    //Future<Ticket> createOneBaseTicketControllerTicket(Ticket ticket) async
    test('test createOneBaseTicketControllerTicket', () async {
      // TODO
    });

    // Delete one Ticket
    //
    //Future deleteOneBaseTicketControllerTicket(String id) async
    test('test deleteOneBaseTicketControllerTicket', () async {
      // TODO
    });

    // Retrieve many Ticket
    //
    //Future<GetManyTicketResponseDto> getManyBaseTicketControllerTicket({ BuiltList<String> fields, String s, BuiltList<String> filter, BuiltList<String> or, BuiltList<String> sort, BuiltList<String> join, int limit, int offset, int page, int cache }) async
    test('test getManyBaseTicketControllerTicket', () async {
      // TODO
    });

    // Retrieve one Ticket
    //
    //Future<Ticket> getOneBaseTicketControllerTicket(String id, { BuiltList<String> fields, BuiltList<String> join, int cache }) async
    test('test getOneBaseTicketControllerTicket', () async {
      // TODO
    });

    // Update one Ticket
    //
    //Future<Ticket> updateOneBaseTicketControllerTicket(String id, Ticket ticket) async
    test('test updateOneBaseTicketControllerTicket', () async {
      // TODO
    });

  });
}
