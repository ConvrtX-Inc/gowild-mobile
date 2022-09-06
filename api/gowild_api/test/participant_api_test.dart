import 'package:test/test.dart';
import 'package:gowild_api/gowild_api.dart';


/// tests for ParticipantApi
void main() {
  final instance = GowildApi().getParticipantApi();

  group(ParticipantApi, () {
    // Create one Participant
    //
    //Future<Participant> createOneBaseParticipantControllerParticipant(Participant participant) async
    test('test createOneBaseParticipantControllerParticipant', () async {
      // TODO
    });

    // Delete one Participant
    //
    //Future deleteOneBaseParticipantControllerParticipant(String id) async
    test('test deleteOneBaseParticipantControllerParticipant', () async {
      // TODO
    });

    // Retrieve many Participant
    //
    //Future<GetManyBaseParticipantControllerParticipant200Response> getManyBaseParticipantControllerParticipant({ BuiltList<String> fields, String s, BuiltList<String> filter, BuiltList<String> or, BuiltList<String> sort, BuiltList<String> join, int limit, int offset, int page, int cache }) async
    test('test getManyBaseParticipantControllerParticipant', () async {
      // TODO
    });

    // Retrieve one Participant
    //
    //Future<Participant> getOneBaseParticipantControllerParticipant(String id, { BuiltList<String> fields, BuiltList<String> join, int cache }) async
    test('test getOneBaseParticipantControllerParticipant', () async {
      // TODO
    });

    // Update one Participant
    //
    //Future<Participant> updateOneBaseParticipantControllerParticipant(String id, Participant participant) async
    test('test updateOneBaseParticipantControllerParticipant', () async {
      // TODO
    });

  });
}
