import 'package:dio/dio.dart';
import 'package:gowild/providers/auth.dart';
import 'package:gowild/providers/gowild.api-client.dart';
import 'package:gowild/helper/logging.dart';
import 'package:gowild_api/gowild_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginProvider {
  final AuthProvider authProvider;
  final AuthApi api;

  LoginProvider(this.authProvider, this.api);

  Future<UserEntity> register(SimpleRegister register) async {
    try {
      final builder = AuthRegisterLoginDtoBuilder();
      builder.email = register.email;
      builder.password = register.password;
      builder.firstName = register.firstName;
      builder.lastName = register.lastName;
      builder.gender = register.gender;
      builder.phoneNo = register.phoneNo;

      final result = await api.authControllerRegister(
        authRegisterLoginDto: builder.build(),
      );
      final data = result.data;
      logger.i('Login request complete $data');
      if (data != null) {
        return data;
      }
      throw Exception('register error');
    } catch (e) {
      if (e is DioError) {
        DioError err = e;
        logger.e('err --> ${err.message}');

        throw err.message;
      }
      rethrow;
    }
  }

  Future<bool> simpleLogin(SimpleLogin simpleLogin) async {
    try {
      final builder = AuthEmailLoginDtoBuilder();
      builder.email = simpleLogin.email;
      builder.password = simpleLogin.password;

      final result = await api.authControllerLogin(
        authEmailLoginDto: builder.build(),
      );
      final data = result.data;
      logger.i('Login request complete $data');
      if (data == null) {
        return false;
      }

      await authProvider.setToken(
        accessToken: data.accessToken,
        refreshToken: data.refreshToken,
      );
      return true;
    } catch (e) {
      if (e is DioError) {
        DioError err = e;
        logger.e('err --> ${err.message}');

        throw err.message;
      }
      rethrow;
    }
  }

  Future<void> logout() async {
    authProvider.setToken(accessToken: null, refreshToken: null);
  }
}

class SimpleLogin {
  String email = '';
  String password = '';

  SimpleLogin();

  SimpleLogin.from(SimpleRegister register)
      : email = register.email,
        password = register.password;
}

class SimpleRegister {
  String email = '';
  String password = '';
  String confirmPassword = '';
  String firstName = '';
  String lastName = '';
  GenderEnum gender = GenderEnum.other;
  String phoneNo = '';
}

class CreateNewPassword {
  String password = '';
  String confirmPassword = '';
}

final loginProvider = Provider.autoDispose((ref) {
  final auth = ref.watch(authProvider.notifier);
  final gowildApi = ref.watch(gowildApiProvider);
  return LoginProvider(auth, gowildApi.getAuthApi());
});
