// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SimpleUser extends SimpleUser {
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final DateTime? birthDate;
  @override
  final String? gender;
  @override
  final String? username;
  @override
  final String? phoneNo;
  @override
  final String? email;
  @override
  final String? fullName;
  @override
  final String? picture;

  factory _$SimpleUser([void Function(SimpleUserBuilder)? updates]) =>
      (new SimpleUserBuilder()..update(updates))._build();

  _$SimpleUser._(
      {this.firstName,
      this.lastName,
      this.birthDate,
      this.gender,
      this.username,
      this.phoneNo,
      this.email,
      this.fullName,
      this.picture})
      : super._();

  @override
  SimpleUser rebuild(void Function(SimpleUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SimpleUserBuilder toBuilder() => new SimpleUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SimpleUser &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        birthDate == other.birthDate &&
        gender == other.gender &&
        username == other.username &&
        phoneNo == other.phoneNo &&
        email == other.email &&
        fullName == other.fullName &&
        picture == other.picture;
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
                                $jc($jc(0, firstName.hashCode),
                                    lastName.hashCode),
                                birthDate.hashCode),
                            gender.hashCode),
                        username.hashCode),
                    phoneNo.hashCode),
                email.hashCode),
            fullName.hashCode),
        picture.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SimpleUser')
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('birthDate', birthDate)
          ..add('gender', gender)
          ..add('username', username)
          ..add('phoneNo', phoneNo)
          ..add('email', email)
          ..add('fullName', fullName)
          ..add('picture', picture))
        .toString();
  }
}

class SimpleUserBuilder implements Builder<SimpleUser, SimpleUserBuilder> {
  _$SimpleUser? _$v;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  DateTime? _birthDate;
  DateTime? get birthDate => _$this._birthDate;
  set birthDate(DateTime? birthDate) => _$this._birthDate = birthDate;

  String? _gender;
  String? get gender => _$this._gender;
  set gender(String? gender) => _$this._gender = gender;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _phoneNo;
  String? get phoneNo => _$this._phoneNo;
  set phoneNo(String? phoneNo) => _$this._phoneNo = phoneNo;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _fullName;
  String? get fullName => _$this._fullName;
  set fullName(String? fullName) => _$this._fullName = fullName;

  String? _picture;
  String? get picture => _$this._picture;
  set picture(String? picture) => _$this._picture = picture;

  SimpleUserBuilder() {
    SimpleUser._defaults(this);
  }

  SimpleUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _birthDate = $v.birthDate;
      _gender = $v.gender;
      _username = $v.username;
      _phoneNo = $v.phoneNo;
      _email = $v.email;
      _fullName = $v.fullName;
      _picture = $v.picture;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SimpleUser other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SimpleUser;
  }

  @override
  void update(void Function(SimpleUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SimpleUser build() => _build();

  _$SimpleUser _build() {
    final _$result = _$v ??
        new _$SimpleUser._(
            firstName: firstName,
            lastName: lastName,
            birthDate: birthDate,
            gender: gender,
            username: username,
            phoneNo: phoneNo,
            email: email,
            fullName: fullName,
            picture: picture);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
