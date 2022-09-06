// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Ticket extends Ticket {
  @override
  final String userId;
  @override
  final String subject;
  @override
  final String message;
  @override
  final String imgUrl;
  @override
  final num status;

  factory _$Ticket([void Function(TicketBuilder)? updates]) =>
      (new TicketBuilder()..update(updates))._build();

  _$Ticket._(
      {required this.userId,
      required this.subject,
      required this.message,
      required this.imgUrl,
      required this.status})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(userId, r'Ticket', 'userId');
    BuiltValueNullFieldError.checkNotNull(subject, r'Ticket', 'subject');
    BuiltValueNullFieldError.checkNotNull(message, r'Ticket', 'message');
    BuiltValueNullFieldError.checkNotNull(imgUrl, r'Ticket', 'imgUrl');
    BuiltValueNullFieldError.checkNotNull(status, r'Ticket', 'status');
  }

  @override
  Ticket rebuild(void Function(TicketBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TicketBuilder toBuilder() => new TicketBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Ticket &&
        userId == other.userId &&
        subject == other.subject &&
        message == other.message &&
        imgUrl == other.imgUrl &&
        status == other.status;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, userId.hashCode), subject.hashCode),
                message.hashCode),
            imgUrl.hashCode),
        status.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Ticket')
          ..add('userId', userId)
          ..add('subject', subject)
          ..add('message', message)
          ..add('imgUrl', imgUrl)
          ..add('status', status))
        .toString();
  }
}

class TicketBuilder implements Builder<Ticket, TicketBuilder> {
  _$Ticket? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _subject;
  String? get subject => _$this._subject;
  set subject(String? subject) => _$this._subject = subject;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  String? _imgUrl;
  String? get imgUrl => _$this._imgUrl;
  set imgUrl(String? imgUrl) => _$this._imgUrl = imgUrl;

  num? _status;
  num? get status => _$this._status;
  set status(num? status) => _$this._status = status;

  TicketBuilder() {
    Ticket._defaults(this);
  }

  TicketBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _subject = $v.subject;
      _message = $v.message;
      _imgUrl = $v.imgUrl;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Ticket other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Ticket;
  }

  @override
  void update(void Function(TicketBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Ticket build() => _build();

  _$Ticket _build() {
    final _$result = _$v ??
        new _$Ticket._(
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'Ticket', 'userId'),
            subject: BuiltValueNullFieldError.checkNotNull(
                subject, r'Ticket', 'subject'),
            message: BuiltValueNullFieldError.checkNotNull(
                message, r'Ticket', 'message'),
            imgUrl: BuiltValueNullFieldError.checkNotNull(
                imgUrl, r'Ticket', 'imgUrl'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'Ticket', 'status'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
