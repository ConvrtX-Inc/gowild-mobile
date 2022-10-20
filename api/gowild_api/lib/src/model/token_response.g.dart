// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TokenResponse extends TokenResponse {
  @override
  final String accessToken;
  @override
  final String refreshToken;

  factory _$TokenResponse([void Function(TokenResponseBuilder)? updates]) =>
      (new TokenResponseBuilder()..update(updates))._build();

  _$TokenResponse._({required this.accessToken, required this.refreshToken})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        accessToken, r'TokenResponse', 'accessToken');
    BuiltValueNullFieldError.checkNotNull(
        refreshToken, r'TokenResponse', 'refreshToken');
  }

  @override
  TokenResponse rebuild(void Function(TokenResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TokenResponseBuilder toBuilder() => new TokenResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TokenResponse &&
        accessToken == other.accessToken &&
        refreshToken == other.refreshToken;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, accessToken.hashCode), refreshToken.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TokenResponse')
          ..add('accessToken', accessToken)
          ..add('refreshToken', refreshToken))
        .toString();
  }
}

class TokenResponseBuilder
    implements Builder<TokenResponse, TokenResponseBuilder> {
  _$TokenResponse? _$v;

  String? _accessToken;
  String? get accessToken => _$this._accessToken;
  set accessToken(String? accessToken) => _$this._accessToken = accessToken;

  String? _refreshToken;
  String? get refreshToken => _$this._refreshToken;
  set refreshToken(String? refreshToken) => _$this._refreshToken = refreshToken;

  TokenResponseBuilder() {
    TokenResponse._defaults(this);
  }

  TokenResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accessToken = $v.accessToken;
      _refreshToken = $v.refreshToken;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TokenResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TokenResponse;
  }

  @override
  void update(void Function(TokenResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TokenResponse build() => _build();

  _$TokenResponse _build() {
    final _$result = _$v ??
        new _$TokenResponse._(
            accessToken: BuiltValueNullFieldError.checkNotNull(
                accessToken, r'TokenResponse', 'accessToken'),
            refreshToken: BuiltValueNullFieldError.checkNotNull(
                refreshToken, r'TokenResponse', 'refreshToken'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
