import 'package:test/test.dart';
import 'package:gowild_api/gowild_api.dart';


/// tests for CurrenciesApi
void main() {
  final instance = GowildApi().getCurrenciesApi();

  group(CurrenciesApi, () {
    // Retrieve many Currency
    //
    //Future<GetManyBaseCurrencyControllerCurrency200Response> getManyBaseCurrencyControllerCurrency({ BuiltList<String> fields, String s, BuiltList<String> filter, BuiltList<String> or, BuiltList<String> sort, BuiltList<String> join, int limit, int offset, int page, int cache }) async
    test('test getManyBaseCurrencyControllerCurrency', () async {
      // TODO
    });

    // Retrieve one Currency
    //
    //Future<Currency> getOneBaseCurrencyControllerCurrency(String id, { BuiltList<String> fields, BuiltList<String> join, int cache }) async
    test('test getOneBaseCurrencyControllerCurrency', () async {
      // TODO
    });

  });
}
