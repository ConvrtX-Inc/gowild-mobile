import 'package:dio/dio.dart';
import 'package:gowild/providers/auth.dart';

class AuthenticatorInterceptor extends Interceptor {
  final AuthProvider authProvider;

  AuthenticatorInterceptor(this.authProvider);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    await authProvider.refresh();
    final token = authProvider.token;

    if (token != null) {
      options.headers['Authorization'] = "Bearer $token";
    }
    return handler.next(options);
  }
}
