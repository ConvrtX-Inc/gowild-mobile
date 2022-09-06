import 'package:test/test.dart';
import 'package:gowild_api/gowild_api.dart';


/// tests for SmsApi
void main() {
  final instance = GowildApi().getSmsApi();

  group(SmsApi, () {
    //Future smsControllerSend(SmsDto smsDto) async
    test('test smsControllerSend', () async {
      // TODO
    });

  });
}
