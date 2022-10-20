// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_reset_password_admin_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AuthResetPasswordAdminDto extends AuthResetPasswordAdminDto {
  @override
  final String password;

  factory _$AuthResetPasswordAdminDto(
          [void Function(AuthResetPasswordAdminDtoBuilder)? updates]) =>
      (new AuthResetPasswordAdminDtoBuilder()..update(updates))._build();

  _$AuthResetPasswordAdminDto._({required this.password}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        password, r'AuthResetPasswordAdminDto', 'password');
  }

  @override
  AuthResetPasswordAdminDto rebuild(
          void Function(AuthResetPasswordAdminDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AuthResetPasswordAdminDtoBuilder toBuilder() =>
      new AuthResetPasswordAdminDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthResetPasswordAdminDto && password == other.password;
  }

  @override
  int get hashCode {
    return $jf($jc(0, password.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AuthResetPasswordAdminDto')
          ..add('password', password))
        .toString();
  }
}

class AuthResetPasswordAdminDtoBuilder
    implements
        Builder<AuthResetPasswordAdminDto, AuthResetPasswordAdminDtoBuilder> {
  _$AuthResetPasswordAdminDto? _$v;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  AuthResetPasswordAdminDtoBuilder() {
    AuthResetPasswordAdminDto._defaults(this);
  }

  AuthResetPasswordAdminDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthResetPasswordAdminDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AuthResetPasswordAdminDto;
  }

  @override
  void update(void Function(AuthResetPasswordAdminDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthResetPasswordAdminDto build() => _build();

  _$AuthResetPasswordAdminDto _build() {
    final _$result = _$v ??
        new _$AuthResetPasswordAdminDto._(
            password: BuiltValueNullFieldError.checkNotNull(
                password, r'AuthResetPasswordAdminDto', 'password'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
