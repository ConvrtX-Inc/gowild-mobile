// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_auth_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserAuthResponse extends UserAuthResponse {
  @override
  final TokenResponse token;
  @override
  final UserEntity user;

  factory _$UserAuthResponse(
          [void Function(UserAuthResponseBuilder)? updates]) =>
      (new UserAuthResponseBuilder()..update(updates))._build();

  _$UserAuthResponse._({required this.token, required this.user}) : super._() {
    BuiltValueNullFieldError.checkNotNull(token, r'UserAuthResponse', 'token');
    BuiltValueNullFieldError.checkNotNull(user, r'UserAuthResponse', 'user');
  }

  @override
  UserAuthResponse rebuild(void Function(UserAuthResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserAuthResponseBuilder toBuilder() =>
      new UserAuthResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserAuthResponse &&
        token == other.token &&
        user == other.user;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, token.hashCode), user.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserAuthResponse')
          ..add('token', token)
          ..add('user', user))
        .toString();
  }
}

class UserAuthResponseBuilder
    implements Builder<UserAuthResponse, UserAuthResponseBuilder> {
  _$UserAuthResponse? _$v;

  TokenResponseBuilder? _token;
  TokenResponseBuilder get token =>
      _$this._token ??= new TokenResponseBuilder();
  set token(TokenResponseBuilder? token) => _$this._token = token;

  UserEntityBuilder? _user;
  UserEntityBuilder get user => _$this._user ??= new UserEntityBuilder();
  set user(UserEntityBuilder? user) => _$this._user = user;

  UserAuthResponseBuilder() {
    UserAuthResponse._defaults(this);
  }

  UserAuthResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _token = $v.token.toBuilder();
      _user = $v.user.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserAuthResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserAuthResponse;
  }

  @override
  void update(void Function(UserAuthResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserAuthResponse build() => _build();

  _$UserAuthResponse _build() {
    _$UserAuthResponse _$result;
    try {
      _$result = _$v ??
          new _$UserAuthResponse._(token: token.build(), user: user.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'token';
        token.build();
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'UserAuthResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
