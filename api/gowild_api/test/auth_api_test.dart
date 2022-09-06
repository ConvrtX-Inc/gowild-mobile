import 'package:test/test.dart';
import 'package:gowild_api/gowild_api.dart';


/// tests for AuthApi
void main() {
  final instance = GowildApi().getAuthApi();

  group(AuthApi, () {
    // Request forgot password
    //
    //Future authControllerForgotPassword(AuthForgotPasswordDto authForgotPasswordDto) async
    test('test authControllerForgotPassword', () async {
      // TODO
    });

    // Generates default admin
    //
    //Future<User> authControllerGenerateAdmin() async
    test('test authControllerGenerateAdmin', () async {
      // TODO
    });

    // Login account
    //
    //Future<LoginResponse> authControllerLogin(AuthEmailLoginDto authEmailLoginDto) async
    test('test authControllerLogin', () async {
      // TODO
    });

    //Future<User> authControllerMe() async
    test('test authControllerMe', () async {
      // TODO
    });

    // Register new account
    //
    //Future<User> authControllerRegister(AuthRegisterLoginDto authRegisterLoginDto) async
    test('test authControllerRegister', () async {
      // TODO
    });

    // Reset password for default admin
    //
    //Future<User> authControllerResetAdminPassword(AuthResetPasswordAdminDto authResetPasswordAdminDto) async
    test('test authControllerResetAdminPassword', () async {
      // TODO
    });

    // Reset user password
    //
    //Future authControllerResetPassword(AuthResetPasswordDto authResetPasswordDto) async
    test('test authControllerResetPassword', () async {
      // TODO
    });

    // Login using facebook
    //
    //Future authFacebookControllerLogin(AuthFacebookLoginDto authFacebookLoginDto) async
    test('test authFacebookControllerLogin', () async {
      // TODO
    });

    // Login using google
    //
    //Future authGoogleControllerLogin(AuthGoogleLoginDto authGoogleLoginDto) async
    test('test authGoogleControllerLogin', () async {
      // TODO
    });

  });
}
