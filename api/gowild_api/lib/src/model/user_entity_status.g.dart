// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UserEntityStatusStatusNameEnum
    _$userEntityStatusStatusNameEnum_cancelled =
    const UserEntityStatusStatusNameEnum._('cancelled');
const UserEntityStatusStatusNameEnum _$userEntityStatusStatusNameEnum_active =
    const UserEntityStatusStatusNameEnum._('active');
const UserEntityStatusStatusNameEnum _$userEntityStatusStatusNameEnum_disabled =
    const UserEntityStatusStatusNameEnum._('disabled');
const UserEntityStatusStatusNameEnum _$userEntityStatusStatusNameEnum_approved =
    const UserEntityStatusStatusNameEnum._('approved');
const UserEntityStatusStatusNameEnum _$userEntityStatusStatusNameEnum_refunded =
    const UserEntityStatusStatusNameEnum._('refunded');
const UserEntityStatusStatusNameEnum _$userEntityStatusStatusNameEnum_rejected =
    const UserEntityStatusStatusNameEnum._('rejected');
const UserEntityStatusStatusNameEnum
    _$userEntityStatusStatusNameEnum_completed =
    const UserEntityStatusStatusNameEnum._('completed');
const UserEntityStatusStatusNameEnum _$userEntityStatusStatusNameEnum_pending =
    const UserEntityStatusStatusNameEnum._('pending');
const UserEntityStatusStatusNameEnum _$userEntityStatusStatusNameEnum_inactive =
    const UserEntityStatusStatusNameEnum._('inactive');

UserEntityStatusStatusNameEnum _$userEntityStatusStatusNameEnumValueOf(
    String name) {
  switch (name) {
    case 'cancelled':
      return _$userEntityStatusStatusNameEnum_cancelled;
    case 'active':
      return _$userEntityStatusStatusNameEnum_active;
    case 'disabled':
      return _$userEntityStatusStatusNameEnum_disabled;
    case 'approved':
      return _$userEntityStatusStatusNameEnum_approved;
    case 'refunded':
      return _$userEntityStatusStatusNameEnum_refunded;
    case 'rejected':
      return _$userEntityStatusStatusNameEnum_rejected;
    case 'completed':
      return _$userEntityStatusStatusNameEnum_completed;
    case 'pending':
      return _$userEntityStatusStatusNameEnum_pending;
    case 'inactive':
      return _$userEntityStatusStatusNameEnum_inactive;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<UserEntityStatusStatusNameEnum>
    _$userEntityStatusStatusNameEnumValues = new BuiltSet<
        UserEntityStatusStatusNameEnum>(const <UserEntityStatusStatusNameEnum>[
  _$userEntityStatusStatusNameEnum_cancelled,
  _$userEntityStatusStatusNameEnum_active,
  _$userEntityStatusStatusNameEnum_disabled,
  _$userEntityStatusStatusNameEnum_approved,
  _$userEntityStatusStatusNameEnum_refunded,
  _$userEntityStatusStatusNameEnum_rejected,
  _$userEntityStatusStatusNameEnum_completed,
  _$userEntityStatusStatusNameEnum_pending,
  _$userEntityStatusStatusNameEnum_inactive,
]);

Serializer<UserEntityStatusStatusNameEnum>
    _$userEntityStatusStatusNameEnumSerializer =
    new _$UserEntityStatusStatusNameEnumSerializer();

class _$UserEntityStatusStatusNameEnumSerializer
    implements PrimitiveSerializer<UserEntityStatusStatusNameEnum> {
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
  final Iterable<Type> types = const <Type>[UserEntityStatusStatusNameEnum];
  @override
  final String wireName = 'UserEntityStatusStatusNameEnum';

  @override
  Object serialize(
          Serializers serializers, UserEntityStatusStatusNameEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  UserEntityStatusStatusNameEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UserEntityStatusStatusNameEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$UserEntityStatus extends UserEntityStatus {
  @override
  final String id;
  @override
  final DateTime? createdDate;
  @override
  final DateTime? updatedDate;
  @override
  final UserEntityStatusStatusNameEnum statusName;
  @override
  final bool isActive;

  factory _$UserEntityStatus(
          [void Function(UserEntityStatusBuilder)? updates]) =>
      (new UserEntityStatusBuilder()..update(updates))._build();

  _$UserEntityStatus._(
      {required this.id,
      this.createdDate,
      this.updatedDate,
      required this.statusName,
      required this.isActive})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'UserEntityStatus', 'id');
    BuiltValueNullFieldError.checkNotNull(
        statusName, r'UserEntityStatus', 'statusName');
    BuiltValueNullFieldError.checkNotNull(
        isActive, r'UserEntityStatus', 'isActive');
  }

  @override
  UserEntityStatus rebuild(void Function(UserEntityStatusBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserEntityStatusBuilder toBuilder() =>
      new UserEntityStatusBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserEntityStatus &&
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
    return (newBuiltValueToStringHelper(r'UserEntityStatus')
          ..add('id', id)
          ..add('createdDate', createdDate)
          ..add('updatedDate', updatedDate)
          ..add('statusName', statusName)
          ..add('isActive', isActive))
        .toString();
  }
}

class UserEntityStatusBuilder
    implements Builder<UserEntityStatus, UserEntityStatusBuilder> {
  _$UserEntityStatus? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  DateTime? _createdDate;
  DateTime? get createdDate => _$this._createdDate;
  set createdDate(DateTime? createdDate) => _$this._createdDate = createdDate;

  DateTime? _updatedDate;
  DateTime? get updatedDate => _$this._updatedDate;
  set updatedDate(DateTime? updatedDate) => _$this._updatedDate = updatedDate;

  UserEntityStatusStatusNameEnum? _statusName;
  UserEntityStatusStatusNameEnum? get statusName => _$this._statusName;
  set statusName(UserEntityStatusStatusNameEnum? statusName) =>
      _$this._statusName = statusName;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  UserEntityStatusBuilder() {
    UserEntityStatus._defaults(this);
  }

  UserEntityStatusBuilder get _$this {
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
  void replace(UserEntityStatus other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserEntityStatus;
  }

  @override
  void update(void Function(UserEntityStatusBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserEntityStatus build() => _build();

  _$UserEntityStatus _build() {
    final _$result = _$v ??
        new _$UserEntityStatus._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'UserEntityStatus', 'id'),
            createdDate: createdDate,
            updatedDate: updatedDate,
            statusName: BuiltValueNullFieldError.checkNotNull(
                statusName, r'UserEntityStatus', 'statusName'),
            isActive: BuiltValueNullFieldError.checkNotNull(
                isActive, r'UserEntityStatus', 'isActive'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
