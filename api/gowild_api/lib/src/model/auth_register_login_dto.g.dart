// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_register_login_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AuthRegisterLoginDtoGenderEnum _$authRegisterLoginDtoGenderEnum_male =
    const AuthRegisterLoginDtoGenderEnum._('male');
const AuthRegisterLoginDtoGenderEnum _$authRegisterLoginDtoGenderEnum_female =
    const AuthRegisterLoginDtoGenderEnum._('female');

AuthRegisterLoginDtoGenderEnum _$authRegisterLoginDtoGenderEnumValueOf(
    String name) {
  switch (name) {
    case 'male':
      return _$authRegisterLoginDtoGenderEnum_male;
    case 'female':
      return _$authRegisterLoginDtoGenderEnum_female;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<AuthRegisterLoginDtoGenderEnum>
    _$authRegisterLoginDtoGenderEnumValues = new BuiltSet<
        AuthRegisterLoginDtoGenderEnum>(const <AuthRegisterLoginDtoGenderEnum>[
  _$authRegisterLoginDtoGenderEnum_male,
  _$authRegisterLoginDtoGenderEnum_female,
]);

const AuthRegisterLoginDtoStatusIdEnum
    _$authRegisterLoginDtoStatusIdEnum_cancelled =
    const AuthRegisterLoginDtoStatusIdEnum._('cancelled');
const AuthRegisterLoginDtoStatusIdEnum
    _$authRegisterLoginDtoStatusIdEnum_active =
    const AuthRegisterLoginDtoStatusIdEnum._('active');
const AuthRegisterLoginDtoStatusIdEnum
    _$authRegisterLoginDtoStatusIdEnum_disabled =
    const AuthRegisterLoginDtoStatusIdEnum._('disabled');
const AuthRegisterLoginDtoStatusIdEnum
    _$authRegisterLoginDtoStatusIdEnum_approved =
    const AuthRegisterLoginDtoStatusIdEnum._('approved');
const AuthRegisterLoginDtoStatusIdEnum
    _$authRegisterLoginDtoStatusIdEnum_refunded =
    const AuthRegisterLoginDtoStatusIdEnum._('refunded');
const AuthRegisterLoginDtoStatusIdEnum
    _$authRegisterLoginDtoStatusIdEnum_rejected =
    const AuthRegisterLoginDtoStatusIdEnum._('rejected');
const AuthRegisterLoginDtoStatusIdEnum
    _$authRegisterLoginDtoStatusIdEnum_completed =
    const AuthRegisterLoginDtoStatusIdEnum._('completed');
const AuthRegisterLoginDtoStatusIdEnum
    _$authRegisterLoginDtoStatusIdEnum_pending =
    const AuthRegisterLoginDtoStatusIdEnum._('pending');
const AuthRegisterLoginDtoStatusIdEnum
    _$authRegisterLoginDtoStatusIdEnum_inactive =
    const AuthRegisterLoginDtoStatusIdEnum._('inactive');

AuthRegisterLoginDtoStatusIdEnum _$authRegisterLoginDtoStatusIdEnumValueOf(
    String name) {
  switch (name) {
    case 'cancelled':
      return _$authRegisterLoginDtoStatusIdEnum_cancelled;
    case 'active':
      return _$authRegisterLoginDtoStatusIdEnum_active;
    case 'disabled':
      return _$authRegisterLoginDtoStatusIdEnum_disabled;
    case 'approved':
      return _$authRegisterLoginDtoStatusIdEnum_approved;
    case 'refunded':
      return _$authRegisterLoginDtoStatusIdEnum_refunded;
    case 'rejected':
      return _$authRegisterLoginDtoStatusIdEnum_rejected;
    case 'completed':
      return _$authRegisterLoginDtoStatusIdEnum_completed;
    case 'pending':
      return _$authRegisterLoginDtoStatusIdEnum_pending;
    case 'inactive':
      return _$authRegisterLoginDtoStatusIdEnum_inactive;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<AuthRegisterLoginDtoStatusIdEnum>
    _$authRegisterLoginDtoStatusIdEnumValues =
    new BuiltSet<AuthRegisterLoginDtoStatusIdEnum>(const <
        AuthRegisterLoginDtoStatusIdEnum>[
  _$authRegisterLoginDtoStatusIdEnum_cancelled,
  _$authRegisterLoginDtoStatusIdEnum_active,
  _$authRegisterLoginDtoStatusIdEnum_disabled,
  _$authRegisterLoginDtoStatusIdEnum_approved,
  _$authRegisterLoginDtoStatusIdEnum_refunded,
  _$authRegisterLoginDtoStatusIdEnum_rejected,
  _$authRegisterLoginDtoStatusIdEnum_completed,
  _$authRegisterLoginDtoStatusIdEnum_pending,
  _$authRegisterLoginDtoStatusIdEnum_inactive,
]);

Serializer<AuthRegisterLoginDtoGenderEnum>
    _$authRegisterLoginDtoGenderEnumSerializer =
    new _$AuthRegisterLoginDtoGenderEnumSerializer();
Serializer<AuthRegisterLoginDtoStatusIdEnum>
    _$authRegisterLoginDtoStatusIdEnumSerializer =
    new _$AuthRegisterLoginDtoStatusIdEnumSerializer();

class _$AuthRegisterLoginDtoGenderEnumSerializer
    implements PrimitiveSerializer<AuthRegisterLoginDtoGenderEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'male': 'Male',
    'female': 'Female',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Male': 'male',
    'Female': 'female',
  };

  @override
  final Iterable<Type> types = const <Type>[AuthRegisterLoginDtoGenderEnum];
  @override
  final String wireName = 'AuthRegisterLoginDtoGenderEnum';

  @override
  Object serialize(
          Serializers serializers, AuthRegisterLoginDtoGenderEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AuthRegisterLoginDtoGenderEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AuthRegisterLoginDtoGenderEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$AuthRegisterLoginDtoStatusIdEnumSerializer
    implements PrimitiveSerializer<AuthRegisterLoginDtoStatusIdEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'cancelled': 'Cancelled',
    'active': 'Active',
    'disabled': 'Disabled',
    'approved': 'Approved',
    'refunded': 'Refunded',
    'rejected': 'Rejected',
    'completed': 'Completed',
    'pending': 'Pending',
    'inactive': 'Inactive',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Cancelled': 'cancelled',
    'Active': 'active',
    'Disabled': 'disabled',
    'Approved': 'approved',
    'Refunded': 'refunded',
    'Rejected': 'rejected',
    'Completed': 'completed',
    'Pending': 'pending',
    'Inactive': 'inactive',
  };

  @override
  final Iterable<Type> types = const <Type>[AuthRegisterLoginDtoStatusIdEnum];
  @override
  final String wireName = 'AuthRegisterLoginDtoStatusIdEnum';

  @override
  Object serialize(
          Serializers serializers, AuthRegisterLoginDtoStatusIdEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AuthRegisterLoginDtoStatusIdEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AuthRegisterLoginDtoStatusIdEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$AuthRegisterLoginDto extends AuthRegisterLoginDto {
  @override
  final String email;
  @override
  final String password;
  @override
  final String fullName;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final AuthRegisterLoginDtoGenderEnum gender;
  @override
  final String addressLine1;
  @override
  final String addressLine2;
  @override
  final String phoneNo;
  @override
  final AuthRegisterLoginDtoStatusIdEnum statusId;

  factory _$AuthRegisterLoginDto(
          [void Function(AuthRegisterLoginDtoBuilder)? updates]) =>
      (new AuthRegisterLoginDtoBuilder()..update(updates))._build();

  _$AuthRegisterLoginDto._(
      {required this.email,
      required this.password,
      required this.fullName,
      required this.firstName,
      required this.lastName,
      required this.gender,
      required this.addressLine1,
      required this.addressLine2,
      required this.phoneNo,
      required this.statusId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        email, r'AuthRegisterLoginDto', 'email');
    BuiltValueNullFieldError.checkNotNull(
        password, r'AuthRegisterLoginDto', 'password');
    BuiltValueNullFieldError.checkNotNull(
        fullName, r'AuthRegisterLoginDto', 'fullName');
    BuiltValueNullFieldError.checkNotNull(
        firstName, r'AuthRegisterLoginDto', 'firstName');
    BuiltValueNullFieldError.checkNotNull(
        lastName, r'AuthRegisterLoginDto', 'lastName');
    BuiltValueNullFieldError.checkNotNull(
        gender, r'AuthRegisterLoginDto', 'gender');
    BuiltValueNullFieldError.checkNotNull(
        addressLine1, r'AuthRegisterLoginDto', 'addressLine1');
    BuiltValueNullFieldError.checkNotNull(
        addressLine2, r'AuthRegisterLoginDto', 'addressLine2');
    BuiltValueNullFieldError.checkNotNull(
        phoneNo, r'AuthRegisterLoginDto', 'phoneNo');
    BuiltValueNullFieldError.checkNotNull(
        statusId, r'AuthRegisterLoginDto', 'statusId');
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
        fullName == other.fullName &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        gender == other.gender &&
        addressLine1 == other.addressLine1 &&
        addressLine2 == other.addressLine2 &&
        phoneNo == other.phoneNo &&
        statusId == other.statusId;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc($jc(0, email.hashCode),
                                        password.hashCode),
                                    fullName.hashCode),
                                firstName.hashCode),
                            lastName.hashCode),
                        gender.hashCode),
                    addressLine1.hashCode),
                addressLine2.hashCode),
            phoneNo.hashCode),
        statusId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AuthRegisterLoginDto')
          ..add('email', email)
          ..add('password', password)
          ..add('fullName', fullName)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('gender', gender)
          ..add('addressLine1', addressLine1)
          ..add('addressLine2', addressLine2)
          ..add('phoneNo', phoneNo)
          ..add('statusId', statusId))
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

  String? _fullName;
  String? get fullName => _$this._fullName;
  set fullName(String? fullName) => _$this._fullName = fullName;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  AuthRegisterLoginDtoGenderEnum? _gender;
  AuthRegisterLoginDtoGenderEnum? get gender => _$this._gender;
  set gender(AuthRegisterLoginDtoGenderEnum? gender) => _$this._gender = gender;

  String? _addressLine1;
  String? get addressLine1 => _$this._addressLine1;
  set addressLine1(String? addressLine1) => _$this._addressLine1 = addressLine1;

  String? _addressLine2;
  String? get addressLine2 => _$this._addressLine2;
  set addressLine2(String? addressLine2) => _$this._addressLine2 = addressLine2;

  String? _phoneNo;
  String? get phoneNo => _$this._phoneNo;
  set phoneNo(String? phoneNo) => _$this._phoneNo = phoneNo;

  AuthRegisterLoginDtoStatusIdEnum? _statusId;
  AuthRegisterLoginDtoStatusIdEnum? get statusId => _$this._statusId;
  set statusId(AuthRegisterLoginDtoStatusIdEnum? statusId) =>
      _$this._statusId = statusId;

  AuthRegisterLoginDtoBuilder() {
    AuthRegisterLoginDto._defaults(this);
  }

  AuthRegisterLoginDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _password = $v.password;
      _fullName = $v.fullName;
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _gender = $v.gender;
      _addressLine1 = $v.addressLine1;
      _addressLine2 = $v.addressLine2;
      _phoneNo = $v.phoneNo;
      _statusId = $v.statusId;
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
            fullName: BuiltValueNullFieldError.checkNotNull(
                fullName, r'AuthRegisterLoginDto', 'fullName'),
            firstName: BuiltValueNullFieldError.checkNotNull(
                firstName, r'AuthRegisterLoginDto', 'firstName'),
            lastName: BuiltValueNullFieldError.checkNotNull(
                lastName, r'AuthRegisterLoginDto', 'lastName'),
            gender: BuiltValueNullFieldError.checkNotNull(
                gender, r'AuthRegisterLoginDto', 'gender'),
            addressLine1: BuiltValueNullFieldError.checkNotNull(
                addressLine1, r'AuthRegisterLoginDto', 'addressLine1'),
            addressLine2: BuiltValueNullFieldError.checkNotNull(
                addressLine2, r'AuthRegisterLoginDto', 'addressLine2'),
            phoneNo: BuiltValueNullFieldError.checkNotNull(
                phoneNo, r'AuthRegisterLoginDto', 'phoneNo'),
            statusId: BuiltValueNullFieldError.checkNotNull(statusId, r'AuthRegisterLoginDto', 'statusId'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
