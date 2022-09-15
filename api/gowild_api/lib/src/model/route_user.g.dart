// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RouteUser extends RouteUser {
  @override
  final String id;
  @override
  final DateTime? createdDate;
  @override
  final DateTime? updatedDate;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final DateTime? birthDate;
  @override
  final GenderEnum gender;
  @override
  final String? username;
  @override
  final String email;
  @override
  final String? phoneNo;
  @override
  final UserEntityPicture? picture;
  @override
  final UserEntityStatus? status;

  factory _$RouteUser([void Function(RouteUserBuilder)? updates]) =>
      (new RouteUserBuilder()..update(updates))._build();

  _$RouteUser._(
      {required this.id,
      this.createdDate,
      this.updatedDate,
      this.firstName,
      this.lastName,
      this.birthDate,
      required this.gender,
      this.username,
      required this.email,
      this.phoneNo,
      this.picture,
      this.status})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'RouteUser', 'id');
    BuiltValueNullFieldError.checkNotNull(gender, r'RouteUser', 'gender');
    BuiltValueNullFieldError.checkNotNull(email, r'RouteUser', 'email');
  }

  @override
  RouteUser rebuild(void Function(RouteUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RouteUserBuilder toBuilder() => new RouteUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RouteUser &&
        id == other.id &&
        createdDate == other.createdDate &&
        updatedDate == other.updatedDate &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        birthDate == other.birthDate &&
        gender == other.gender &&
        username == other.username &&
        email == other.email &&
        phoneNo == other.phoneNo &&
        picture == other.picture &&
        status == other.status;
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
                                    $jc(
                                        $jc(
                                            $jc($jc(0, id.hashCode),
                                                createdDate.hashCode),
                                            updatedDate.hashCode),
                                        firstName.hashCode),
                                    lastName.hashCode),
                                birthDate.hashCode),
                            gender.hashCode),
                        username.hashCode),
                    email.hashCode),
                phoneNo.hashCode),
            picture.hashCode),
        status.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RouteUser')
          ..add('id', id)
          ..add('createdDate', createdDate)
          ..add('updatedDate', updatedDate)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('birthDate', birthDate)
          ..add('gender', gender)
          ..add('username', username)
          ..add('email', email)
          ..add('phoneNo', phoneNo)
          ..add('picture', picture)
          ..add('status', status))
        .toString();
  }
}

class RouteUserBuilder implements Builder<RouteUser, RouteUserBuilder> {
  _$RouteUser? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  DateTime? _createdDate;
  DateTime? get createdDate => _$this._createdDate;
  set createdDate(DateTime? createdDate) => _$this._createdDate = createdDate;

  DateTime? _updatedDate;
  DateTime? get updatedDate => _$this._updatedDate;
  set updatedDate(DateTime? updatedDate) => _$this._updatedDate = updatedDate;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  DateTime? _birthDate;
  DateTime? get birthDate => _$this._birthDate;
  set birthDate(DateTime? birthDate) => _$this._birthDate = birthDate;

  GenderEnum? _gender;
  GenderEnum? get gender => _$this._gender;
  set gender(GenderEnum? gender) => _$this._gender = gender;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _phoneNo;
  String? get phoneNo => _$this._phoneNo;
  set phoneNo(String? phoneNo) => _$this._phoneNo = phoneNo;

  UserEntityPictureBuilder? _picture;
  UserEntityPictureBuilder get picture =>
      _$this._picture ??= new UserEntityPictureBuilder();
  set picture(UserEntityPictureBuilder? picture) => _$this._picture = picture;

  UserEntityStatusBuilder? _status;
  UserEntityStatusBuilder get status =>
      _$this._status ??= new UserEntityStatusBuilder();
  set status(UserEntityStatusBuilder? status) => _$this._status = status;

  RouteUserBuilder() {
    RouteUser._defaults(this);
  }

  RouteUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdDate = $v.createdDate;
      _updatedDate = $v.updatedDate;
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _birthDate = $v.birthDate;
      _gender = $v.gender;
      _username = $v.username;
      _email = $v.email;
      _phoneNo = $v.phoneNo;
      _picture = $v.picture?.toBuilder();
      _status = $v.status?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RouteUser other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RouteUser;
  }

  @override
  void update(void Function(RouteUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RouteUser build() => _build();

  _$RouteUser _build() {
    _$RouteUser _$result;
    try {
      _$result = _$v ??
          new _$RouteUser._(
              id: BuiltValueNullFieldError.checkNotNull(id, r'RouteUser', 'id'),
              createdDate: createdDate,
              updatedDate: updatedDate,
              firstName: firstName,
              lastName: lastName,
              birthDate: birthDate,
              gender: BuiltValueNullFieldError.checkNotNull(
                  gender, r'RouteUser', 'gender'),
              username: username,
              email: BuiltValueNullFieldError.checkNotNull(
                  email, r'RouteUser', 'email'),
              phoneNo: phoneNo,
              picture: _picture?.build(),
              status: _status?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'picture';
        _picture?.build();
        _$failedField = 'status';
        _status?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'RouteUser', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
