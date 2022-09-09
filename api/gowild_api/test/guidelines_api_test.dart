import 'package:test/test.dart';
import 'package:gowild_api/gowild_api.dart';


/// tests for GuidelinesApi
void main() {
  final instance = GowildApi().getGuidelinesApi();

  group(GuidelinesApi, () {
    // Create one Guideline
    //
    //Future<Guideline> createOneBaseGuidelinesControllerGuideline(Guideline guideline) async
    test('test createOneBaseGuidelinesControllerGuideline', () async {
      // TODO
    });

    // Delete one Guideline
    //
    //Future deleteOneBaseGuidelinesControllerGuideline(String id) async
    test('test deleteOneBaseGuidelinesControllerGuideline', () async {
      // TODO
    });

    // Retrieve many Guideline
    //
    //Future<GetManyGuidelineResponseDto> getManyBaseGuidelinesControllerGuideline({ BuiltList<String> fields, String s, BuiltList<String> filter, BuiltList<String> or, BuiltList<String> sort, BuiltList<String> join, int limit, int offset, int page, int cache }) async
    test('test getManyBaseGuidelinesControllerGuideline', () async {
      // TODO
    });

    // Retrieve one Guideline
    //
    //Future<Guideline> getOneBaseGuidelinesControllerGuideline(String id, { BuiltList<String> fields, BuiltList<String> join, int cache }) async
    test('test getOneBaseGuidelinesControllerGuideline', () async {
      // TODO
    });

    // Get Terms and Conditions by Type
    //
    //Future guidelinesControllerGetTermsByType(String type) async
    test('test guidelinesControllerGetTermsByType', () async {
      // TODO
    });

    // Update one Guideline
    //
    //Future<Guideline> updateOneBaseGuidelinesControllerGuideline(String id, Guideline guideline) async
    test('test updateOneBaseGuidelinesControllerGuideline', () async {
      // TODO
    });

  });
}
