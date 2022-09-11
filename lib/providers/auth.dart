import 'dart:convert';

import 'package:dio/dio.dart' hide Lock;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gowild/environment_config.dart';
import 'package:gowild/helper/logging.dart';
import 'package:gowild/providers/secure_storage.dart';
import 'package:gowild_api/gowild_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:synchronized/synchronized.dart';

part 'auth.freezed.dart';

part 'auth.g.dart';

final authProvider = StateNotifierProvider<AuthProvider, AuthState>((ref) {
  return AuthProvider();
});

class AuthProvider extends StateNotifier<AuthState> {
  final _lock = Lock();
  bool _init = false;
  final api =
      GowildApi(dio: Dio(BaseOptions(baseUrl: EnvironmentConfig.apiBaseUrl)))
          .getAuthApi();
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
        } catch (err) {
          logger.e(err);
        }
      } else {
        state = state.copyWith(token: null, decoded: null);
      }
      _init = true;
    }
    return state.status;
  }

  Future<bool> _needRefresh() async {
    final int? exp = state.decoded?['exp'];
    final nowTime = DateTime.now().millisecondsSinceEpoch + 100;
    if (exp == null) {
      return false;
    }

    return nowTime > exp;
  }

  Future<void> refresh() async {
    try {
      logger.d('Should refresh token');
      if (!await _needRefresh()) {
        logger.d('No need to refresh');
        return;
      }

      logger.d('Will refresh token');
      await _lock.synchronized(() async {
        if (!await _needRefresh()) {
          logger.d('No need to refresh again');
          return;
        }

        logger.d('Will refresh the token now');
        if (state.token != null) {
          final builder = AuthRefreshTokenDtoBuilder();
          builder.refreshToken = state.token!.refreshToken;
          final result = await api.authControllerRefreshToken(
              authRefreshTokenDto: builder.build());
          final data = result.data;
          if (data != null) {
            setToken(
              accessToken: data.accessToken,
              refreshToken: data.refreshToken,
            );
            logger.d('Token refreshed and set');
          }
        }
      });
    } catch(e) {
      logger.e('Could not refresh token :', e);
    }
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
