import 'package:dio/dio.dart';
import 'package:gowild/providers/auth.dart';
import 'package:gowild/providers/gowild.api-client.dart';
import 'package:gowild/services/logging.dart';
import 'package:gowild_api/gowild_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CurrentUserProvider extends StateNotifier<User?> {
  final AuthApi authApi;
  final UsersApi usersApi;
  final AuthProvider authProvider;

  CurrentUserProvider({
    required this.authApi,
    required this.usersApi,
    required this.authProvider,
  }) : super(null);

  void checkUser() async {
    try {
      final result = await authApi.authControllerMe();
      state = result.data;
      authProvider.setUser(user: state);
    } catch (e) {
      if (e is DioError) {
        final DioError err = e;
        if (err.response?.statusCode == 404) {
          authProvider.setUser(user: state);
          logger.i('User not found');
          return;
        }
      }
      rethrow;
    }
  }
}

final currentUserProvider = StateNotifierProvider((ref) {
  final api = ref.watch(gowildApiProvider);
  final auth = ref.watch(authProvider.notifier);
  return CurrentUserProvider(
    authApi: api.getAuthApi(),
    usersApi: api.getUsersApi(),
    authProvider: auth,
  );
});
