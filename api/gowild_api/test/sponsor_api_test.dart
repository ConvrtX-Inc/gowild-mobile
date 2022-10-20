import 'package:test/test.dart';
import 'package:gowild_api/gowild_api.dart';


/// tests for SponsorApi
void main() {
  final instance = GowildApi().getSponsorApi();

  group(SponsorApi, () {
    // Create one Sponsor
    //
    //Future<Sponsor> createOneBaseSponsorControllerSponsor(Sponsor sponsor) async
    test('test createOneBaseSponsorControllerSponsor', () async {
      // TODO
    });

    // Delete one Sponsor
    //
    //Future deleteOneBaseSponsorControllerSponsor(String id) async
    test('test deleteOneBaseSponsorControllerSponsor', () async {
      // TODO
    });

    // Retrieve many Sponsor
    //
    //Future<GetManySponsorResponseDto> getManyBaseSponsorControllerSponsor({ BuiltList<String> fields, String s, BuiltList<String> filter, BuiltList<String> or, BuiltList<String> sort, BuiltList<String> join, int limit, int offset, int page, int cache }) async
    test('test getManyBaseSponsorControllerSponsor', () async {
      // TODO
    });

    // Retrieve one Sponsor
    //
    //Future<Sponsor> getOneBaseSponsorControllerSponsor(String id, { BuiltList<String> fields, BuiltList<String> join, int cache }) async
    test('test getOneBaseSponsorControllerSponsor', () async {
      // TODO
    });

    // Update one Sponsor
    //
    //Future<Sponsor> updateOneBaseSponsorControllerSponsor(String id, Sponsor sponsor) async
    test('test updateOneBaseSponsorControllerSponsor', () async {
      // TODO
    });

  });
}
