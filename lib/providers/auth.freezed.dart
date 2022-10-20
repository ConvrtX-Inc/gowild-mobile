// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'auth.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthState {
  Map<String, dynamic>? get decoded => throw _privateConstructorUsedError;
  AuthToken? get token => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthStateCopyWith<AuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res>;
  $Res call({Map<String, dynamic>? decoded, AuthToken? token});

  $AuthTokenCopyWith<$Res>? get token;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res> implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  final AuthState _value;
  // ignore: unused_field
  final $Res Function(AuthState) _then;

  @override
  $Res call({
    Object? decoded = freezed,
    Object? token = freezed,
  }) {
    return _then(_value.copyWith(
      decoded: decoded == freezed
          ? _value.decoded
          : decoded // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as AuthToken?,
    ));
  }

  @override
  $AuthTokenCopyWith<$Res>? get token {
    if (_value.token == null) {
      return null;
    }

    return $AuthTokenCopyWith<$Res>(_value.token!, (value) {
      return _then(_value.copyWith(token: value));
    });
  }
}

/// @nodoc
abstract class _$$_AuthStateCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$$_AuthStateCopyWith(
          _$_AuthState value, $Res Function(_$_AuthState) then) =
      __$$_AuthStateCopyWithImpl<$Res>;
  @override
  $Res call({Map<String, dynamic>? decoded, AuthToken? token});

  @override
  $AuthTokenCopyWith<$Res>? get token;
}

/// @nodoc
class __$$_AuthStateCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements _$$_AuthStateCopyWith<$Res> {
  __$$_AuthStateCopyWithImpl(
      _$_AuthState _value, $Res Function(_$_AuthState) _then)
      : super(_value, (v) => _then(v as _$_AuthState));

  @override
  _$_AuthState get _value => super._value as _$_AuthState;

  @override
  $Res call({
    Object? decoded = freezed,
    Object? token = freezed,
  }) {
    return _then(_$_AuthState(
      decoded: decoded == freezed
          ? _value._decoded
          : decoded // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as AuthToken?,
    ));
  }
}

/// @nodoc

class _$_AuthState extends _AuthState {
  _$_AuthState(
      {required final Map<String, dynamic>? decoded, required this.token})
      : _decoded = decoded,
        super._();

  final Map<String, dynamic>? _decoded;
  @override
  Map<String, dynamic>? get decoded {
    final value = _decoded;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final AuthToken? token;

  @override
  String toString() {
    return 'AuthState(decoded: $decoded, token: $token)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthState &&
            const DeepCollectionEquality().equals(other._decoded, _decoded) &&
            const DeepCollectionEquality().equals(other.token, token));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_decoded),
      const DeepCollectionEquality().hash(token));

  @JsonKey(ignore: true)
  @override
  _$$_AuthStateCopyWith<_$_AuthState> get copyWith =>
      __$$_AuthStateCopyWithImpl<_$_AuthState>(this, _$identity);
}

abstract class _AuthState extends AuthState {
  factory _AuthState(
      {required final Map<String, dynamic>? decoded,
      required final AuthToken? token}) = _$_AuthState;
  _AuthState._() : super._();

  @override
  Map<String, dynamic>? get decoded;
  @override
  AuthToken? get token;
  @override
  @JsonKey(ignore: true)
  _$$_AuthStateCopyWith<_$_AuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

AuthToken _$AuthTokenFromJson(Map<String, dynamic> json) {
  return _AuthToken.fromJson(json);
}

/// @nodoc
mixin _$AuthToken {
  String get accessToken => throw _privateConstructorUsedError;
  String get refreshToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthTokenCopyWith<AuthToken> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthTokenCopyWith<$Res> {
  factory $AuthTokenCopyWith(AuthToken value, $Res Function(AuthToken) then) =
      _$AuthTokenCopyWithImpl<$Res>;
  $Res call({String accessToken, String refreshToken});
}

/// @nodoc
class _$AuthTokenCopyWithImpl<$Res> implements $AuthTokenCopyWith<$Res> {
  _$AuthTokenCopyWithImpl(this._value, this._then);

  final AuthToken _value;
  // ignore: unused_field
  final $Res Function(AuthToken) _then;

  @override
  $Res call({
    Object? accessToken = freezed,
    Object? refreshToken = freezed,
  }) {
    return _then(_value.copyWith(
      accessToken: accessToken == freezed
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: refreshToken == freezed
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_AuthTokenCopyWith<$Res> implements $AuthTokenCopyWith<$Res> {
  factory _$$_AuthTokenCopyWith(
          _$_AuthToken value, $Res Function(_$_AuthToken) then) =
      __$$_AuthTokenCopyWithImpl<$Res>;
  @override
  $Res call({String accessToken, String refreshToken});
}

/// @nodoc
class __$$_AuthTokenCopyWithImpl<$Res> extends _$AuthTokenCopyWithImpl<$Res>
    implements _$$_AuthTokenCopyWith<$Res> {
  __$$_AuthTokenCopyWithImpl(
      _$_AuthToken _value, $Res Function(_$_AuthToken) _then)
      : super(_value, (v) => _then(v as _$_AuthToken));

  @override
  _$_AuthToken get _value => super._value as _$_AuthToken;

  @override
  $Res call({
    Object? accessToken = freezed,
    Object? refreshToken = freezed,
  }) {
    return _then(_$_AuthToken(
      accessToken: accessToken == freezed
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: refreshToken == freezed
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AuthToken extends _AuthToken {
  _$_AuthToken({required this.accessToken, required this.refreshToken})
      : super._();

  factory _$_AuthToken.fromJson(Map<String, dynamic> json) =>
      _$$_AuthTokenFromJson(json);

  @override
  final String accessToken;
  @override
  final String refreshToken;

  @override
  String toString() {
    return 'AuthToken(accessToken: $accessToken, refreshToken: $refreshToken)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthToken &&
            const DeepCollectionEquality()
                .equals(other.accessToken, accessToken) &&
            const DeepCollectionEquality()
                .equals(other.refreshToken, refreshToken));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(accessToken),
      const DeepCollectionEquality().hash(refreshToken));

  @JsonKey(ignore: true)
  @override
  _$$_AuthTokenCopyWith<_$_AuthToken> get copyWith =>
      __$$_AuthTokenCopyWithImpl<_$_AuthToken>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AuthTokenToJson(
      this,
    );
  }
}

abstract class _AuthToken extends AuthToken {
  factory _AuthToken(
      {required final String accessToken,
      required final String refreshToken}) = _$_AuthToken;
  _AuthToken._() : super._();

  factory _AuthToken.fromJson(Map<String, dynamic> json) =
      _$_AuthToken.fromJson;

  @override
  String get accessToken;
  @override
  String get refreshToken;
  @override
  @JsonKey(ignore: true)
  _$$_AuthTokenCopyWith<_$_AuthToken> get copyWith =>
      throw _privateConstructorUsedError;
}
