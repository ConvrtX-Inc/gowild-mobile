import 'package:test/test.dart';
import 'package:gowild_api/gowild_api.dart';


/// tests for VerifyApi
void main() {
  final instance = GowildApi().getVerifyApi();

  group(VerifyApi, () {
    //Future verifyControllerCheckMobileVerificationToken(CheckVerificationTokenDto checkVerificationTokenDto) async
    test('test verifyControllerCheckMobileVerificationToken', () async {
      // TODO
    });

    //Future verifyControllerSendPhoneVerificationToken(SendVerificationTokenDto sendVerificationTokenDto) async
    test('test verifyControllerSendPhoneVerificationToken', () async {
      // TODO
    });

  });
}
