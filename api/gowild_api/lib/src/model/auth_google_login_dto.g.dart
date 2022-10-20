// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_google_login_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AuthGoogleLoginDto extends AuthGoogleLoginDto {
  @override
  final String idToken;

  factory _$AuthGoogleLoginDto(
          [void Function(AuthGoogleLoginDtoBuilder)? updates]) =>
      (new AuthGoogleLoginDtoBuilder()..update(updates))._build();

  _$AuthGoogleLoginDto._({required this.idToken}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        idToken, r'AuthGoogleLoginDto', 'idToken');
  }

  @override
  AuthGoogleLoginDto rebuild(
          void Function(AuthGoogleLoginDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AuthGoogleLoginDtoBuilder toBuilder() =>
      new AuthGoogleLoginDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthGoogleLoginDto && idToken == other.idToken;
  }

  @override
  int get hashCode {
    return $jf($jc(0, idToken.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AuthGoogleLoginDto')
          ..add('idToken', idToken))
        .toString();
  }
}

class AuthGoogleLoginDtoBuilder
    implements Builder<AuthGoogleLoginDto, AuthGoogleLoginDtoBuilder> {
  _$AuthGoogleLoginDto? _$v;

  String? _idToken;
  String? get idToken => _$this._idToken;
  set idToken(String? idToken) => _$this._idToken = idToken;

  AuthGoogleLoginDtoBuilder() {
    AuthGoogleLoginDto._defaults(this);
  }

  AuthGoogleLoginDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _idToken = $v.idToken;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthGoogleLoginDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AuthGoogleLoginDto;
  }

  @override
  void update(void Function(AuthGoogleLoginDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthGoogleLoginDto build() => _build();

  _$AuthGoogleLoginDto _build() {
    final _$result = _$v ??
        new _$AuthGoogleLoginDto._(
            idToken: BuiltValueNullFieldError.checkNotNull(
                idToken, r'AuthGoogleLoginDto', 'idToken'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
