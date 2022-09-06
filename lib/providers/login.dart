import 'package:dio/dio.dart';
import 'package:gowild/providers/auth.dart';
import 'package:gowild/providers/gowild.api-client.dart';
import 'package:gowild/services/logging.dart';
import 'package:gowild_api/gowild_api.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginProvider {
  final AuthProvider authProvider;
  final AuthApi api;

  LoginProvider(this.authProvider, this.api);

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

      await authProvider.setUser(user: data.user, token: data.token);
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
}

class SimpleLogin {
  String email = '';
  String password = '';
}

final loginProvider = Provider.autoDispose((ref) {
  final auth = ref.watch(authProvider.notifier);
  final gowildApi = ref.watch(gowildApiProvider);
  return LoginProvider(auth, gowildApi.getAuthApi());
});
