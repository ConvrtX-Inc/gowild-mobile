// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_reset_password_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AuthResetPasswordDto extends AuthResetPasswordDto {
  @override
  final String password;
  @override
  final String hash;

  factory _$AuthResetPasswordDto(
          [void Function(AuthResetPasswordDtoBuilder)? updates]) =>
      (new AuthResetPasswordDtoBuilder()..update(updates))._build();

  _$AuthResetPasswordDto._({required this.password, required this.hash})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        password, r'AuthResetPasswordDto', 'password');
    BuiltValueNullFieldError.checkNotNull(
        hash, r'AuthResetPasswordDto', 'hash');
  }

  @override
  AuthResetPasswordDto rebuild(
          void Function(AuthResetPasswordDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AuthResetPasswordDtoBuilder toBuilder() =>
      new AuthResetPasswordDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthResetPasswordDto &&
        password == other.password &&
        hash == other.hash;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, password.hashCode), hash.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AuthResetPasswordDto')
          ..add('password', password)
          ..add('hash', hash))
        .toString();
  }
}

class AuthResetPasswordDtoBuilder
    implements Builder<AuthResetPasswordDto, AuthResetPasswordDtoBuilder> {
  _$AuthResetPasswordDto? _$v;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _hash;
  String? get hash => _$this._hash;
  set hash(String? hash) => _$this._hash = hash;

  AuthResetPasswordDtoBuilder() {
    AuthResetPasswordDto._defaults(this);
  }

  AuthResetPasswordDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _password = $v.password;
      _hash = $v.hash;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthResetPasswordDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AuthResetPasswordDto;
  }

  @override
  void update(void Function(AuthResetPasswordDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthResetPasswordDto build() => _build();

  _$AuthResetPasswordDto _build() {
    final _$result = _$v ??
        new _$AuthResetPasswordDto._(
            password: BuiltValueNullFieldError.checkNotNull(
                password, r'AuthResetPasswordDto', 'password'),
            hash: BuiltValueNullFieldError.checkNotNull(
                hash, r'AuthResetPasswordDto', 'hash'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
