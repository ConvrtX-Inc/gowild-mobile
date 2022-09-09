// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_refresh_token_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AuthRefreshTokenDto extends AuthRefreshTokenDto {
  @override
  final String refreshToken;

  factory _$AuthRefreshTokenDto(
          [void Function(AuthRefreshTokenDtoBuilder)? updates]) =>
      (new AuthRefreshTokenDtoBuilder()..update(updates))._build();

  _$AuthRefreshTokenDto._({required this.refreshToken}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        refreshToken, r'AuthRefreshTokenDto', 'refreshToken');
  }

  @override
  AuthRefreshTokenDto rebuild(
          void Function(AuthRefreshTokenDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AuthRefreshTokenDtoBuilder toBuilder() =>
      new AuthRefreshTokenDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthRefreshTokenDto && refreshToken == other.refreshToken;
  }

  @override
  int get hashCode {
    return $jf($jc(0, refreshToken.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AuthRefreshTokenDto')
          ..add('refreshToken', refreshToken))
        .toString();
  }
}

class AuthRefreshTokenDtoBuilder
    implements Builder<AuthRefreshTokenDto, AuthRefreshTokenDtoBuilder> {
  _$AuthRefreshTokenDto? _$v;

  String? _refreshToken;
  String? get refreshToken => _$this._refreshToken;
  set refreshToken(String? refreshToken) => _$this._refreshToken = refreshToken;

  AuthRefreshTokenDtoBuilder() {
    AuthRefreshTokenDto._defaults(this);
  }

  AuthRefreshTokenDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _refreshToken = $v.refreshToken;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthRefreshTokenDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AuthRefreshTokenDto;
  }

  @override
  void update(void Function(AuthRefreshTokenDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthRefreshTokenDto build() => _build();

  _$AuthRefreshTokenDto _build() {
    final _$result = _$v ??
        new _$AuthRefreshTokenDto._(
            refreshToken: BuiltValueNullFieldError.checkNotNull(
                refreshToken, r'AuthRefreshTokenDto', 'refreshToken'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
