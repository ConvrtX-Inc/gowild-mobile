// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Notification extends Notification {
  @override
  final String userId;
  @override
  final String notificationMsg;

  factory _$Notification([void Function(NotificationBuilder)? updates]) =>
      (new NotificationBuilder()..update(updates))._build();

  _$Notification._({required this.userId, required this.notificationMsg})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(userId, r'Notification', 'userId');
    BuiltValueNullFieldError.checkNotNull(
        notificationMsg, r'Notification', 'notificationMsg');
  }

  @override
  Notification rebuild(void Function(NotificationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NotificationBuilder toBuilder() => new NotificationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Notification &&
        userId == other.userId &&
        notificationMsg == other.notificationMsg;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, userId.hashCode), notificationMsg.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Notification')
          ..add('userId', userId)
          ..add('notificationMsg', notificationMsg))
        .toString();
  }
}

class NotificationBuilder
    implements Builder<Notification, NotificationBuilder> {
  _$Notification? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _notificationMsg;
  String? get notificationMsg => _$this._notificationMsg;
  set notificationMsg(String? notificationMsg) =>
      _$this._notificationMsg = notificationMsg;

  NotificationBuilder() {
    Notification._defaults(this);
  }

  NotificationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _notificationMsg = $v.notificationMsg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Notification other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Notification;
  }

  @override
  void update(void Function(NotificationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Notification build() => _build();

  _$Notification _build() {
    final _$result = _$v ??
        new _$Notification._(
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'Notification', 'userId'),
            notificationMsg: BuiltValueNullFieldError.checkNotNull(
                notificationMsg, r'Notification', 'notificationMsg'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
