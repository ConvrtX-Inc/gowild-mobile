// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_message.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TicketMessage extends TicketMessage {
  @override
  final String id;
  @override
  final DateTime? createdDate;
  @override
  final DateTime? updatedDate;
  @override
  final String ticketId;
  @override
  final String userId;
  @override
  final String message;

  factory _$TicketMessage([void Function(TicketMessageBuilder)? updates]) =>
      (new TicketMessageBuilder()..update(updates))._build();

  _$TicketMessage._(
      {required this.id,
      this.createdDate,
      this.updatedDate,
      required this.ticketId,
      required this.userId,
      required this.message})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'TicketMessage', 'id');
    BuiltValueNullFieldError.checkNotNull(
        ticketId, r'TicketMessage', 'ticketId');
    BuiltValueNullFieldError.checkNotNull(userId, r'TicketMessage', 'userId');
    BuiltValueNullFieldError.checkNotNull(message, r'TicketMessage', 'message');
  }

  @override
  TicketMessage rebuild(void Function(TicketMessageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TicketMessageBuilder toBuilder() => new TicketMessageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TicketMessage &&
        id == other.id &&
        createdDate == other.createdDate &&
        updatedDate == other.updatedDate &&
        ticketId == other.ticketId &&
        userId == other.userId &&
        message == other.message;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, id.hashCode), createdDate.hashCode),
                    updatedDate.hashCode),
                ticketId.hashCode),
            userId.hashCode),
        message.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TicketMessage')
          ..add('id', id)
          ..add('createdDate', createdDate)
          ..add('updatedDate', updatedDate)
          ..add('ticketId', ticketId)
          ..add('userId', userId)
          ..add('message', message))
        .toString();
  }
}

class TicketMessageBuilder
    implements Builder<TicketMessage, TicketMessageBuilder> {
  _$TicketMessage? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  DateTime? _createdDate;
  DateTime? get createdDate => _$this._createdDate;
  set createdDate(DateTime? createdDate) => _$this._createdDate = createdDate;

  DateTime? _updatedDate;
  DateTime? get updatedDate => _$this._updatedDate;
  set updatedDate(DateTime? updatedDate) => _$this._updatedDate = updatedDate;

  String? _ticketId;
  String? get ticketId => _$this._ticketId;
  set ticketId(String? ticketId) => _$this._ticketId = ticketId;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  TicketMessageBuilder() {
    TicketMessage._defaults(this);
  }

  TicketMessageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdDate = $v.createdDate;
      _updatedDate = $v.updatedDate;
      _ticketId = $v.ticketId;
      _userId = $v.userId;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TicketMessage other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TicketMessage;
  }

  @override
  void update(void Function(TicketMessageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TicketMessage build() => _build();

  _$TicketMessage _build() {
    final _$result = _$v ??
        new _$TicketMessage._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'TicketMessage', 'id'),
            createdDate: createdDate,
            updatedDate: updatedDate,
            ticketId: BuiltValueNullFieldError.checkNotNull(
                ticketId, r'TicketMessage', 'ticketId'),
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'TicketMessage', 'userId'),
            message: BuiltValueNullFieldError.checkNotNull(
                message, r'TicketMessage', 'message'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
