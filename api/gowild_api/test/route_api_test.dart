import 'package:test/test.dart';
import 'package:gowild_api/gowild_api.dart';


/// tests for RouteApi
void main() {
  final instance = GowildApi().getRouteApi();

  group(RouteApi, () {
    // Create one Route
    //
    //Future<Route> createOneBaseRouteControllerRoute(Route route) async
    test('test createOneBaseRouteControllerRoute', () async {
      // TODO
    });

    // Delete one Route
    //
    //Future deleteOneBaseRouteControllerRoute(String id) async
    test('test deleteOneBaseRouteControllerRoute', () async {
      // TODO
    });

    // Retrieve many Route
    //
    //Future<GetManyRouteResponseDto> getManyBaseRouteControllerRoute({ BuiltList<String> fields, String s, BuiltList<String> filter, BuiltList<String> or, BuiltList<String> sort, BuiltList<String> join, int limit, int offset, int page, int cache }) async
    test('test getManyBaseRouteControllerRoute', () async {
      // TODO
    });

    // Retrieve one Route
    //
    //Future<Route> getOneBaseRouteControllerRoute(String id, { BuiltList<String> fields, BuiltList<String> join, int cache }) async
    test('test getOneBaseRouteControllerRoute', () async {
      // TODO
    });

    // Update one Route
    //
    //Future<Route> updateOneBaseRouteControllerRoute(String id, Route route) async
    test('test updateOneBaseRouteControllerRoute', () async {
      // TODO
    });

  });
}
