import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gowild/services/logging.dart';
import 'package:gowild/services/secure_storage.dart';
import 'package:gowild_api/gowild_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'auth.freezed.dart';

final authProvider = StateNotifierProvider<AuthProvider, AuthState>((ref) {
  return AuthProvider();
});

class AuthProvider extends StateNotifier<AuthState> {
  bool _init = false;
  final SecureStorage _storage = SecureStorage(SecureStorage.userTokenKey);

  AuthProvider()
      : super(
          AuthState(
            user: null,
            token: null,
          ),
        );

  String? get token => state.token;

  Future<void> setUser({User? user, String? token}) async {
    if (token != null) {
      logger.i('User token set');
      await _storage.saveValue(value: token);
    } else {
      logger.i('Removed user token');
      await _storage.removeValue();
    }
    state = state.copyWith(user: user, token: token);
  }

  Future<bool> init() async {
    if (!_init) {
      final token = await _storage.readValue();
      state = state.copyWith(token: token);
      _init = true;
    }
    return state.status;
  }
}

@freezed
class AuthState with _$AuthState {
  AuthState._();

  factory AuthState({
    required User? user,
    required String? token,
  }) = _AuthState;

  bool get status => token != null;
}
