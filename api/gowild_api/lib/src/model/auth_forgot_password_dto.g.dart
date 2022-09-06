// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_forgot_password_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AuthForgotPasswordDto extends AuthForgotPasswordDto {
  @override
  final String email;
  @override
  final String phone;

  factory _$AuthForgotPasswordDto(
          [void Function(AuthForgotPasswordDtoBuilder)? updates]) =>
      (new AuthForgotPasswordDtoBuilder()..update(updates))._build();

  _$AuthForgotPasswordDto._({required this.email, required this.phone})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        email, r'AuthForgotPasswordDto', 'email');
    BuiltValueNullFieldError.checkNotNull(
        phone, r'AuthForgotPasswordDto', 'phone');
  }

  @override
  AuthForgotPasswordDto rebuild(
          void Function(AuthForgotPasswordDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AuthForgotPasswordDtoBuilder toBuilder() =>
      new AuthForgotPasswordDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthForgotPasswordDto &&
        email == other.email &&
        phone == other.phone;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, email.hashCode), phone.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AuthForgotPasswordDto')
          ..add('email', email)
          ..add('phone', phone))
        .toString();
  }
}

class AuthForgotPasswordDtoBuilder
    implements Builder<AuthForgotPasswordDto, AuthForgotPasswordDtoBuilder> {
  _$AuthForgotPasswordDto? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  AuthForgotPasswordDtoBuilder() {
    AuthForgotPasswordDto._defaults(this);
  }

  AuthForgotPasswordDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _phone = $v.phone;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthForgotPasswordDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AuthForgotPasswordDto;
  }

  @override
  void update(void Function(AuthForgotPasswordDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthForgotPasswordDto build() => _build();

  _$AuthForgotPasswordDto _build() {
    final _$result = _$v ??
        new _$AuthForgotPasswordDto._(
            email: BuiltValueNullFieldError.checkNotNull(
                email, r'AuthForgotPasswordDto', 'email'),
            phone: BuiltValueNullFieldError.checkNotNull(
                phone, r'AuthForgotPasswordDto', 'phone'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
