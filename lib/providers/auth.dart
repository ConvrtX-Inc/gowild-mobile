import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gowild/services/logging.dart';
import 'package:gowild/services/secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jwt_decode/jwt_decode.dart';

part 'auth.freezed.dart';

part 'auth.g.dart';

final authProvider = StateNotifierProvider<AuthProvider, AuthState>((ref) {
  return AuthProvider();
});

class AuthProvider extends StateNotifier<AuthState> {
  bool _init = false;
  final SecureStorage _storage = SecureStorage(SecureStorage.userTokenKey);

  AuthProvider()
      : super(
          AuthState(
            decoded: null,
            token: null,
          ),
        );

  String? get token => state.token?.accessToken;

  Future<void> setToken({String? accessToken, String? refreshToken}) async {
    if (accessToken != null && refreshToken != null) {
      final token = AuthToken(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
      await _storage.saveValue(value: json.encode(token.toJson()));

      final decoded = Jwt.parseJwt(accessToken);
      state = state.copyWith(decoded: decoded, token: token);
      logger.i('User token set');
    } else {
      state = state.copyWith(decoded: null, token: null);
      logger.i('Removed user token');
      await _storage.removeValue();
    }
  }

  Future<bool> init() async {
    if (!_init) {
      final token = await _storage.readValue();
      logger.d('token $token');
      if (token != null) {
        try {
          final parsed = json.decode(token);
          final authToken = AuthToken.fromJson(parsed);
          final decoded = Jwt.parseJwt(authToken.accessToken);
          state = state.copyWith(token: authToken, decoded: decoded);
        } catch(err) {
          logger.e(err);
        }
      } else {
        state = state.copyWith(token: null, decoded: null);
      }
      _init = true;
    }
    return state.status;
  }
}

@freezed
class AuthState with _$AuthState {
  AuthState._();

  factory AuthState({
    required Map<String, dynamic>? decoded,
    required AuthToken? token,
  }) = _AuthState;

  bool get status => token != null;
}

@freezed
class AuthToken with _$AuthToken {
  AuthToken._();

  factory AuthToken({
    required String accessToken,
    required String refreshToken,
  }) = _AuthToken;

  factory AuthToken.fromJson(Map<String, Object?> json) =>
      _$AuthTokenFromJson(json);
}
