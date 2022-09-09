// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UserStatusStatusNameEnum _$userStatusStatusNameEnum_cancelled =
    const UserStatusStatusNameEnum._('cancelled');
const UserStatusStatusNameEnum _$userStatusStatusNameEnum_active =
    const UserStatusStatusNameEnum._('active');
const UserStatusStatusNameEnum _$userStatusStatusNameEnum_disabled =
    const UserStatusStatusNameEnum._('disabled');
const UserStatusStatusNameEnum _$userStatusStatusNameEnum_approved =
    const UserStatusStatusNameEnum._('approved');
const UserStatusStatusNameEnum _$userStatusStatusNameEnum_refunded =
    const UserStatusStatusNameEnum._('refunded');
const UserStatusStatusNameEnum _$userStatusStatusNameEnum_rejected =
    const UserStatusStatusNameEnum._('rejected');
const UserStatusStatusNameEnum _$userStatusStatusNameEnum_completed =
    const UserStatusStatusNameEnum._('completed');
const UserStatusStatusNameEnum _$userStatusStatusNameEnum_pending =
    const UserStatusStatusNameEnum._('pending');
const UserStatusStatusNameEnum _$userStatusStatusNameEnum_inactive =
    const UserStatusStatusNameEnum._('inactive');

UserStatusStatusNameEnum _$userStatusStatusNameEnumValueOf(String name) {
  switch (name) {
    case 'cancelled':
      return _$userStatusStatusNameEnum_cancelled;
    case 'active':
      return _$userStatusStatusNameEnum_active;
    case 'disabled':
      return _$userStatusStatusNameEnum_disabled;
    case 'approved':
      return _$userStatusStatusNameEnum_approved;
    case 'refunded':
      return _$userStatusStatusNameEnum_refunded;
    case 'rejected':
      return _$userStatusStatusNameEnum_rejected;
    case 'completed':
      return _$userStatusStatusNameEnum_completed;
    case 'pending':
      return _$userStatusStatusNameEnum_pending;
    case 'inactive':
      return _$userStatusStatusNameEnum_inactive;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<UserStatusStatusNameEnum> _$userStatusStatusNameEnumValues =
    new BuiltSet<UserStatusStatusNameEnum>(const <UserStatusStatusNameEnum>[
  _$userStatusStatusNameEnum_cancelled,
  _$userStatusStatusNameEnum_active,
  _$userStatusStatusNameEnum_disabled,
  _$userStatusStatusNameEnum_approved,
  _$userStatusStatusNameEnum_refunded,
  _$userStatusStatusNameEnum_rejected,
  _$userStatusStatusNameEnum_completed,
  _$userStatusStatusNameEnum_pending,
  _$userStatusStatusNameEnum_inactive,
]);

Serializer<UserStatusStatusNameEnum> _$userStatusStatusNameEnumSerializer =
    new _$UserStatusStatusNameEnumSerializer();

class _$UserStatusStatusNameEnumSerializer
    implements PrimitiveSerializer<UserStatusStatusNameEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'cancelled': 'cancelled',
    'active': 'active',
    'disabled': 'disabled',
    'approved': 'approved',
    'refunded': 'refunded',
    'rejected': 'rejected',
    'completed': 'completed',
    'pending': 'pending',
    'inactive': 'inactive',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'cancelled': 'cancelled',
    'active': 'active',
    'disabled': 'disabled',
    'approved': 'approved',
    'refunded': 'refunded',
    'rejected': 'rejected',
    'completed': 'completed',
    'pending': 'pending',
    'inactive': 'inactive',
  };

  @override
  final Iterable<Type> types = const <Type>[UserStatusStatusNameEnum];
  @override
  final String wireName = 'UserStatusStatusNameEnum';

  @override
  Object serialize(Serializers serializers, UserStatusStatusNameEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  UserStatusStatusNameEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UserStatusStatusNameEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$UserStatus extends UserStatus {
  @override
  final String id;
  @override
  final DateTime? createdDate;
  @override
  final DateTime? updatedDate;
  @override
  final UserStatusStatusNameEnum statusName;
  @override
  final bool isActive;

  factory _$UserStatus([void Function(UserStatusBuilder)? updates]) =>
      (new UserStatusBuilder()..update(updates))._build();

  _$UserStatus._(
      {required this.id,
      this.createdDate,
      this.updatedDate,
      required this.statusName,
      required this.isActive})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'UserStatus', 'id');
    BuiltValueNullFieldError.checkNotNull(
        statusName, r'UserStatus', 'statusName');
    BuiltValueNullFieldError.checkNotNull(isActive, r'UserStatus', 'isActive');
  }

  @override
  UserStatus rebuild(void Function(UserStatusBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserStatusBuilder toBuilder() => new UserStatusBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserStatus &&
        id == other.id &&
        createdDate == other.createdDate &&
        updatedDate == other.updatedDate &&
        statusName == other.statusName &&
        isActive == other.isActive;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, id.hashCode), createdDate.hashCode),
                updatedDate.hashCode),
            statusName.hashCode),
        isActive.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserStatus')
          ..add('id', id)
          ..add('createdDate', createdDate)
          ..add('updatedDate', updatedDate)
          ..add('statusName', statusName)
          ..add('isActive', isActive))
        .toString();
  }
}

class UserStatusBuilder implements Builder<UserStatus, UserStatusBuilder> {
  _$UserStatus? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  DateTime? _createdDate;
  DateTime? get createdDate => _$this._createdDate;
  set createdDate(DateTime? createdDate) => _$this._createdDate = createdDate;

  DateTime? _updatedDate;
  DateTime? get updatedDate => _$this._updatedDate;
  set updatedDate(DateTime? updatedDate) => _$this._updatedDate = updatedDate;

  UserStatusStatusNameEnum? _statusName;
  UserStatusStatusNameEnum? get statusName => _$this._statusName;
  set statusName(UserStatusStatusNameEnum? statusName) =>
      _$this._statusName = statusName;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  UserStatusBuilder() {
    UserStatus._defaults(this);
  }

  UserStatusBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdDate = $v.createdDate;
      _updatedDate = $v.updatedDate;
      _statusName = $v.statusName;
      _isActive = $v.isActive;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserStatus other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserStatus;
  }

  @override
  void update(void Function(UserStatusBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserStatus build() => _build();

  _$UserStatus _build() {
    final _$result = _$v ??
        new _$UserStatus._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'UserStatus', 'id'),
            createdDate: createdDate,
            updatedDate: updatedDate,
            statusName: BuiltValueNullFieldError.checkNotNull(
                statusName, r'UserStatus', 'statusName'),
            isActive: BuiltValueNullFieldError.checkNotNull(
                isActive, r'UserStatus', 'isActive'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
