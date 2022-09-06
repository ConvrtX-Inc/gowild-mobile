// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_facebook_login_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AuthFacebookLoginDto extends AuthFacebookLoginDto {
  @override
  final String accessToken;

  factory _$AuthFacebookLoginDto(
          [void Function(AuthFacebookLoginDtoBuilder)? updates]) =>
      (new AuthFacebookLoginDtoBuilder()..update(updates))._build();

  _$AuthFacebookLoginDto._({required this.accessToken}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        accessToken, r'AuthFacebookLoginDto', 'accessToken');
  }

  @override
  AuthFacebookLoginDto rebuild(
          void Function(AuthFacebookLoginDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AuthFacebookLoginDtoBuilder toBuilder() =>
      new AuthFacebookLoginDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthFacebookLoginDto && accessToken == other.accessToken;
  }

  @override
  int get hashCode {
    return $jf($jc(0, accessToken.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AuthFacebookLoginDto')
          ..add('accessToken', accessToken))
        .toString();
  }
}

class AuthFacebookLoginDtoBuilder
    implements Builder<AuthFacebookLoginDto, AuthFacebookLoginDtoBuilder> {
  _$AuthFacebookLoginDto? _$v;

  String? _accessToken;
  String? get accessToken => _$this._accessToken;
  set accessToken(String? accessToken) => _$this._accessToken = accessToken;

  AuthFacebookLoginDtoBuilder() {
    AuthFacebookLoginDto._defaults(this);
  }

  AuthFacebookLoginDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accessToken = $v.accessToken;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthFacebookLoginDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AuthFacebookLoginDto;
  }

  @override
  void update(void Function(AuthFacebookLoginDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthFacebookLoginDto build() => _build();

  _$AuthFacebookLoginDto _build() {
    final _$result = _$v ??
        new _$AuthFacebookLoginDto._(
            accessToken: BuiltValueNullFieldError.checkNotNull(
                accessToken, r'AuthFacebookLoginDto', 'accessToken'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
