// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const StatusStatusNameEnum _$statusStatusNameEnum_cancelled =
    const StatusStatusNameEnum._('cancelled');
const StatusStatusNameEnum _$statusStatusNameEnum_active =
    const StatusStatusNameEnum._('active');
const StatusStatusNameEnum _$statusStatusNameEnum_disabled =
    const StatusStatusNameEnum._('disabled');
const StatusStatusNameEnum _$statusStatusNameEnum_approved =
    const StatusStatusNameEnum._('approved');
const StatusStatusNameEnum _$statusStatusNameEnum_refunded =
    const StatusStatusNameEnum._('refunded');
const StatusStatusNameEnum _$statusStatusNameEnum_rejected =
    const StatusStatusNameEnum._('rejected');
const StatusStatusNameEnum _$statusStatusNameEnum_completed =
    const StatusStatusNameEnum._('completed');
const StatusStatusNameEnum _$statusStatusNameEnum_pending =
    const StatusStatusNameEnum._('pending');
const StatusStatusNameEnum _$statusStatusNameEnum_inactive =
    const StatusStatusNameEnum._('inactive');

StatusStatusNameEnum _$statusStatusNameEnumValueOf(String name) {
  switch (name) {
    case 'cancelled':
      return _$statusStatusNameEnum_cancelled;
    case 'active':
      return _$statusStatusNameEnum_active;
    case 'disabled':
      return _$statusStatusNameEnum_disabled;
    case 'approved':
      return _$statusStatusNameEnum_approved;
    case 'refunded':
      return _$statusStatusNameEnum_refunded;
    case 'rejected':
      return _$statusStatusNameEnum_rejected;
    case 'completed':
      return _$statusStatusNameEnum_completed;
    case 'pending':
      return _$statusStatusNameEnum_pending;
    case 'inactive':
      return _$statusStatusNameEnum_inactive;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<StatusStatusNameEnum> _$statusStatusNameEnumValues =
    new BuiltSet<StatusStatusNameEnum>(const <StatusStatusNameEnum>[
  _$statusStatusNameEnum_cancelled,
  _$statusStatusNameEnum_active,
  _$statusStatusNameEnum_disabled,
  _$statusStatusNameEnum_approved,
  _$statusStatusNameEnum_refunded,
  _$statusStatusNameEnum_rejected,
  _$statusStatusNameEnum_completed,
  _$statusStatusNameEnum_pending,
  _$statusStatusNameEnum_inactive,
]);

Serializer<StatusStatusNameEnum> _$statusStatusNameEnumSerializer =
    new _$StatusStatusNameEnumSerializer();

class _$StatusStatusNameEnumSerializer
    implements PrimitiveSerializer<StatusStatusNameEnum> {
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
  final Iterable<Type> types = const <Type>[StatusStatusNameEnum];
  @override
  final String wireName = 'StatusStatusNameEnum';

  @override
  Object serialize(Serializers serializers, StatusStatusNameEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  StatusStatusNameEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      StatusStatusNameEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Status extends Status {
  @override
  final String id;
  @override
  final DateTime? createdDate;
  @override
  final DateTime? updatedDate;
  @override
  final StatusStatusNameEnum statusName;
  @override
  final bool isActive;

  factory _$Status([void Function(StatusBuilder)? updates]) =>
      (new StatusBuilder()..update(updates))._build();

  _$Status._(
      {required this.id,
      this.createdDate,
      this.updatedDate,
      required this.statusName,
      required this.isActive})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'Status', 'id');
    BuiltValueNullFieldError.checkNotNull(statusName, r'Status', 'statusName');
    BuiltValueNullFieldError.checkNotNull(isActive, r'Status', 'isActive');
  }

  @override
  Status rebuild(void Function(StatusBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StatusBuilder toBuilder() => new StatusBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Status &&
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
    return (newBuiltValueToStringHelper(r'Status')
          ..add('id', id)
          ..add('createdDate', createdDate)
          ..add('updatedDate', updatedDate)
          ..add('statusName', statusName)
          ..add('isActive', isActive))
        .toString();
  }
}

class StatusBuilder implements Builder<Status, StatusBuilder> {
  _$Status? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  DateTime? _createdDate;
  DateTime? get createdDate => _$this._createdDate;
  set createdDate(DateTime? createdDate) => _$this._createdDate = createdDate;

  DateTime? _updatedDate;
  DateTime? get updatedDate => _$this._updatedDate;
  set updatedDate(DateTime? updatedDate) => _$this._updatedDate = updatedDate;

  StatusStatusNameEnum? _statusName;
  StatusStatusNameEnum? get statusName => _$this._statusName;
  set statusName(StatusStatusNameEnum? statusName) =>
      _$this._statusName = statusName;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  StatusBuilder() {
    Status._defaults(this);
  }

  StatusBuilder get _$this {
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
  void replace(Status other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Status;
  }

  @override
  void update(void Function(StatusBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Status build() => _build();

  _$Status _build() {
    final _$result = _$v ??
        new _$Status._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Status', 'id'),
            createdDate: createdDate,
            updatedDate: updatedDate,
            statusName: BuiltValueNullFieldError.checkNotNull(
                statusName, r'Status', 'statusName'),
            isActive: BuiltValueNullFieldError.checkNotNull(
                isActive, r'Status', 'isActive'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
