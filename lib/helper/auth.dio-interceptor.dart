import 'package:dio/dio.dart';
import 'package:gowild/providers/auth.dart';
import 'package:gowild/services/logging.dart';

// TODO
class AuthenticatorInterceptor extends Interceptor {
  final AuthProvider authProvider;

  AuthenticatorInterceptor(this.authProvider);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = authProvider.token;

    if (token != null) {
      options.headers['Authorization'] = "Bearer $token";
    }
    return handler.next(options);
  }

  @override
  void onError(DioError error, ErrorInterceptorHandler handler) async {
    if (error.type == DioErrorType.response &&
        error.response!.statusCode == 401) {
      logger.d('Should refresh the token');
      await authProvider.refresh();
    }
    return super.onError(error, handler);
  }
}
