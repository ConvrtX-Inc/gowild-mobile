// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$User extends User {
  @override
  final String? id;
  @override
  final String? fullName;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final DateTime? birthDate;
  @override
  final String? gender;
  @override
  final String? firebaseSnapshotId1Img;
  @override
  final String? firebaseSnapshotId2Img;
  @override
  final String? username;
  @override
  final String? email;
  @override
  final String? password;
  @override
  final String? phoneNo;
  @override
  final String? addressLine1;
  @override
  final String? addressLine2;
  @override
  final JsonObject? profilePhoto;
  @override
  final String? imgUrl;
  @override
  final String? hash;
  @override
  final DateTime? createdDate;
  @override
  final DateTime? updatedDate;
  @override
  final DateTime? deletedDate;
  @override
  final num? statusId;
  @override
  final UserStatus? status;

  factory _$User([void Function(UserBuilder)? updates]) =>
      (new UserBuilder()..update(updates))._build();

  _$User._(
      {this.id,
      this.fullName,
      this.firstName,
      this.lastName,
      this.birthDate,
      this.gender,
      this.firebaseSnapshotId1Img,
      this.firebaseSnapshotId2Img,
      this.username,
      this.email,
      this.password,
      this.phoneNo,
      this.addressLine1,
      this.addressLine2,
      this.profilePhoto,
      this.imgUrl,
      this.hash,
      this.createdDate,
      this.updatedDate,
      this.deletedDate,
      this.statusId,
      this.status})
      : super._();

  @override
  User rebuild(void Function(UserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserBuilder toBuilder() => new UserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
        id == other.id &&
        fullName == other.fullName &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        birthDate == other.birthDate &&
        gender == other.gender &&
        firebaseSnapshotId1Img == other.firebaseSnapshotId1Img &&
        firebaseSnapshotId2Img == other.firebaseSnapshotId2Img &&
        username == other.username &&
        email == other.email &&
        password == other.password &&
        phoneNo == other.phoneNo &&
        addressLine1 == other.addressLine1 &&
        addressLine2 == other.addressLine2 &&
        profilePhoto == other.profilePhoto &&
        imgUrl == other.imgUrl &&
        hash == other.hash &&
        createdDate == other.createdDate &&
        updatedDate == other.updatedDate &&
        deletedDate == other.deletedDate &&
        statusId == other.statusId &&
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
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    $jc(
                                                                        $jc(
                                                                            $jc($jc($jc($jc(0, id.hashCode), fullName.hashCode), firstName.hashCode),
                                                                                lastName.hashCode),
                                                                            birthDate.hashCode),
                                                                        gender.hashCode),
                                                                    firebaseSnapshotId1Img.hashCode),
                                                                firebaseSnapshotId2Img.hashCode),
                                                            username.hashCode),
                                                        email.hashCode),
                                                    password.hashCode),
                                                phoneNo.hashCode),
                                            addressLine1.hashCode),
                                        addressLine2.hashCode),
                                    profilePhoto.hashCode),
                                imgUrl.hashCode),
                            hash.hashCode),
                        createdDate.hashCode),
                    updatedDate.hashCode),
                deletedDate.hashCode),
            statusId.hashCode),
        status.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'User')
          ..add('id', id)
          ..add('fullName', fullName)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('birthDate', birthDate)
          ..add('gender', gender)
          ..add('firebaseSnapshotId1Img', firebaseSnapshotId1Img)
          ..add('firebaseSnapshotId2Img', firebaseSnapshotId2Img)
          ..add('username', username)
          ..add('email', email)
          ..add('password', password)
          ..add('phoneNo', phoneNo)
          ..add('addressLine1', addressLine1)
          ..add('addressLine2', addressLine2)
          ..add('profilePhoto', profilePhoto)
          ..add('imgUrl', imgUrl)
          ..add('hash', hash)
          ..add('createdDate', createdDate)
          ..add('updatedDate', updatedDate)
          ..add('deletedDate', deletedDate)
          ..add('statusId', statusId)
          ..add('status', status))
        .toString();
  }
}

class UserBuilder implements Builder<User, UserBuilder> {
  _$User? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _fullName;
  String? get fullName => _$this._fullName;
  set fullName(String? fullName) => _$this._fullName = fullName;

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

  String? _firebaseSnapshotId1Img;
  String? get firebaseSnapshotId1Img => _$this._firebaseSnapshotId1Img;
  set firebaseSnapshotId1Img(String? firebaseSnapshotId1Img) =>
      _$this._firebaseSnapshotId1Img = firebaseSnapshotId1Img;

  String? _firebaseSnapshotId2Img;
  String? get firebaseSnapshotId2Img => _$this._firebaseSnapshotId2Img;
  set firebaseSnapshotId2Img(String? firebaseSnapshotId2Img) =>
      _$this._firebaseSnapshotId2Img = firebaseSnapshotId2Img;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _phoneNo;
  String? get phoneNo => _$this._phoneNo;
  set phoneNo(String? phoneNo) => _$this._phoneNo = phoneNo;

  String? _addressLine1;
  String? get addressLine1 => _$this._addressLine1;
  set addressLine1(String? addressLine1) => _$this._addressLine1 = addressLine1;

  String? _addressLine2;
  String? get addressLine2 => _$this._addressLine2;
  set addressLine2(String? addressLine2) => _$this._addressLine2 = addressLine2;

  JsonObject? _profilePhoto;
  JsonObject? get profilePhoto => _$this._profilePhoto;
  set profilePhoto(JsonObject? profilePhoto) =>
      _$this._profilePhoto = profilePhoto;

  String? _imgUrl;
  String? get imgUrl => _$this._imgUrl;
  set imgUrl(String? imgUrl) => _$this._imgUrl = imgUrl;

  String? _hash;
  String? get hash => _$this._hash;
  set hash(String? hash) => _$this._hash = hash;

  DateTime? _createdDate;
  DateTime? get createdDate => _$this._createdDate;
  set createdDate(DateTime? createdDate) => _$this._createdDate = createdDate;

  DateTime? _updatedDate;
  DateTime? get updatedDate => _$this._updatedDate;
  set updatedDate(DateTime? updatedDate) => _$this._updatedDate = updatedDate;

  DateTime? _deletedDate;
  DateTime? get deletedDate => _$this._deletedDate;
  set deletedDate(DateTime? deletedDate) => _$this._deletedDate = deletedDate;

  num? _statusId;
  num? get statusId => _$this._statusId;
  set statusId(num? statusId) => _$this._statusId = statusId;

  UserStatusBuilder? _status;
  UserStatusBuilder get status => _$this._status ??= new UserStatusBuilder();
  set status(UserStatusBuilder? status) => _$this._status = status;

  UserBuilder() {
    User._defaults(this);
  }

  UserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _fullName = $v.fullName;
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _birthDate = $v.birthDate;
      _gender = $v.gender;
      _firebaseSnapshotId1Img = $v.firebaseSnapshotId1Img;
      _firebaseSnapshotId2Img = $v.firebaseSnapshotId2Img;
      _username = $v.username;
      _email = $v.email;
      _password = $v.password;
      _phoneNo = $v.phoneNo;
      _addressLine1 = $v.addressLine1;
      _addressLine2 = $v.addressLine2;
      _profilePhoto = $v.profilePhoto;
      _imgUrl = $v.imgUrl;
      _hash = $v.hash;
      _createdDate = $v.createdDate;
      _updatedDate = $v.updatedDate;
      _deletedDate = $v.deletedDate;
      _statusId = $v.statusId;
      _status = $v.status?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(User other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$User;
  }

  @override
  void update(void Function(UserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  User build() => _build();

  _$User _build() {
    _$User _$result;
    try {
      _$result = _$v ??
          new _$User._(
              id: id,
              fullName: fullName,
              firstName: firstName,
              lastName: lastName,
              birthDate: birthDate,
              gender: gender,
              firebaseSnapshotId1Img: firebaseSnapshotId1Img,
              firebaseSnapshotId2Img: firebaseSnapshotId2Img,
              username: username,
              email: email,
              password: password,
              phoneNo: phoneNo,
              addressLine1: addressLine1,
              addressLine2: addressLine2,
              profilePhoto: profilePhoto,
              imgUrl: imgUrl,
              hash: hash,
              createdDate: createdDate,
              updatedDate: updatedDate,
              deletedDate: deletedDate,
              statusId: statusId,
              status: _status?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'status';
        _status?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'User', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
