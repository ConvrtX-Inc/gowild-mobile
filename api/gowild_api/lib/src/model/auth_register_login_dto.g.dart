// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_register_login_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AuthRegisterLoginDto extends AuthRegisterLoginDto {
  @override
  final String email;
  @override
  final String password;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final GenderEnum gender;
  @override
  final String? phoneNo;

  factory _$AuthRegisterLoginDto(
          [void Function(AuthRegisterLoginDtoBuilder)? updates]) =>
      (new AuthRegisterLoginDtoBuilder()..update(updates))._build();

  _$AuthRegisterLoginDto._(
      {required this.email,
      required this.password,
      required this.firstName,
      required this.lastName,
      required this.gender,
      this.phoneNo})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        email, r'AuthRegisterLoginDto', 'email');
    BuiltValueNullFieldError.checkNotNull(
        password, r'AuthRegisterLoginDto', 'password');
    BuiltValueNullFieldError.checkNotNull(
        firstName, r'AuthRegisterLoginDto', 'firstName');
    BuiltValueNullFieldError.checkNotNull(
        lastName, r'AuthRegisterLoginDto', 'lastName');
    BuiltValueNullFieldError.checkNotNull(
        gender, r'AuthRegisterLoginDto', 'gender');
  }

  @override
  AuthRegisterLoginDto rebuild(
          void Function(AuthRegisterLoginDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AuthRegisterLoginDtoBuilder toBuilder() =>
      new AuthRegisterLoginDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthRegisterLoginDto &&
        email == other.email &&
        password == other.password &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        gender == other.gender &&
        phoneNo == other.phoneNo;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, email.hashCode), password.hashCode),
                    firstName.hashCode),
                lastName.hashCode),
            gender.hashCode),
        phoneNo.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AuthRegisterLoginDto')
          ..add('email', email)
          ..add('password', password)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('gender', gender)
          ..add('phoneNo', phoneNo))
        .toString();
  }
}

class AuthRegisterLoginDtoBuilder
    implements Builder<AuthRegisterLoginDto, AuthRegisterLoginDtoBuilder> {
  _$AuthRegisterLoginDto? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  GenderEnum? _gender;
  GenderEnum? get gender => _$this._gender;
  set gender(GenderEnum? gender) => _$this._gender = gender;

  String? _phoneNo;
  String? get phoneNo => _$this._phoneNo;
  set phoneNo(String? phoneNo) => _$this._phoneNo = phoneNo;

  AuthRegisterLoginDtoBuilder() {
    AuthRegisterLoginDto._defaults(this);
  }

  AuthRegisterLoginDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _password = $v.password;
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _gender = $v.gender;
      _phoneNo = $v.phoneNo;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthRegisterLoginDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AuthRegisterLoginDto;
  }

  @override
  void update(void Function(AuthRegisterLoginDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthRegisterLoginDto build() => _build();

  _$AuthRegisterLoginDto _build() {
    final _$result = _$v ??
        new _$AuthRegisterLoginDto._(
            email: BuiltValueNullFieldError.checkNotNull(
                email, r'AuthRegisterLoginDto', 'email'),
            password: BuiltValueNullFieldError.checkNotNull(
                password, r'AuthRegisterLoginDto', 'password'),
            firstName: BuiltValueNullFieldError.checkNotNull(
                firstName, r'AuthRegisterLoginDto', 'firstName'),
            lastName: BuiltValueNullFieldError.checkNotNull(
                lastName, r'AuthRegisterLoginDto', 'lastName'),
            gender: BuiltValueNullFieldError.checkNotNull(
                gender, r'AuthRegisterLoginDto', 'gender'),
            phoneNo: phoneNo);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
