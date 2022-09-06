// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserStatus extends UserStatus {
  @override
  final num id;
  @override
  final String statusName;
  @override
  final bool isActive;

  factory _$UserStatus([void Function(UserStatusBuilder)? updates]) =>
      (new UserStatusBuilder()..update(updates))._build();

  _$UserStatus._(
      {required this.id, required this.statusName, required this.isActive})
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
        statusName == other.statusName &&
        isActive == other.isActive;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, id.hashCode), statusName.hashCode), isActive.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserStatus')
          ..add('id', id)
          ..add('statusName', statusName)
          ..add('isActive', isActive))
        .toString();
  }
}

class UserStatusBuilder implements Builder<UserStatus, UserStatusBuilder> {
  _$UserStatus? _$v;

  num? _id;
  num? get id => _$this._id;
  set id(num? id) => _$this._id = id;

  String? _statusName;
  String? get statusName => _$this._statusName;
  set statusName(String? statusName) => _$this._statusName = statusName;

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
            statusName: BuiltValueNullFieldError.checkNotNull(
                statusName, r'UserStatus', 'statusName'),
            isActive: BuiltValueNullFieldError.checkNotNull(
                isActive, r'UserStatus', 'isActive'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
