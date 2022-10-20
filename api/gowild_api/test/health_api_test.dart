import 'package:test/test.dart';
import 'package:gowild_api/gowild_api.dart';


/// tests for HealthApi
void main() {
  final instance = GowildApi().getHealthApi();

  group(HealthApi, () {
    //Future<HealthControllerCheck200Response> healthControllerCheck() async
    test('test healthControllerCheck', () async {
      // TODO
    });

  });
}
