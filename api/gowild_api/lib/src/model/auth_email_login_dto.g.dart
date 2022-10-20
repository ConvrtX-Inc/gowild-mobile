// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_email_login_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AuthEmailLoginDto extends AuthEmailLoginDto {
  @override
  final String email;
  @override
  final String password;

  factory _$AuthEmailLoginDto(
          [void Function(AuthEmailLoginDtoBuilder)? updates]) =>
      (new AuthEmailLoginDtoBuilder()..update(updates))._build();

  _$AuthEmailLoginDto._({required this.email, required this.password})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(email, r'AuthEmailLoginDto', 'email');
    BuiltValueNullFieldError.checkNotNull(
        password, r'AuthEmailLoginDto', 'password');
  }

  @override
  AuthEmailLoginDto rebuild(void Function(AuthEmailLoginDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AuthEmailLoginDtoBuilder toBuilder() =>
      new AuthEmailLoginDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthEmailLoginDto &&
        email == other.email &&
        password == other.password;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, email.hashCode), password.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AuthEmailLoginDto')
          ..add('email', email)
          ..add('password', password))
        .toString();
  }
}

class AuthEmailLoginDtoBuilder
    implements Builder<AuthEmailLoginDto, AuthEmailLoginDtoBuilder> {
  _$AuthEmailLoginDto? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  AuthEmailLoginDtoBuilder() {
    AuthEmailLoginDto._defaults(this);
  }

  AuthEmailLoginDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthEmailLoginDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AuthEmailLoginDto;
  }

  @override
  void update(void Function(AuthEmailLoginDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthEmailLoginDto build() => _build();

  _$AuthEmailLoginDto _build() {
    final _$result = _$v ??
        new _$AuthEmailLoginDto._(
            email: BuiltValueNullFieldError.checkNotNull(
                email, r'AuthEmailLoginDto', 'email'),
            password: BuiltValueNullFieldError.checkNotNull(
                password, r'AuthEmailLoginDto', 'password'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
