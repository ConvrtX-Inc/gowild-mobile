// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Participant extends Participant {
  @override
  final String id;
  @override
  final DateTime? createdDate;
  @override
  final DateTime? updatedDate;
  @override
  final String userId;
  @override
  final String roomId;

  factory _$Participant([void Function(ParticipantBuilder)? updates]) =>
      (new ParticipantBuilder()..update(updates))._build();

  _$Participant._(
      {required this.id,
      this.createdDate,
      this.updatedDate,
      required this.userId,
      required this.roomId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'Participant', 'id');
    BuiltValueNullFieldError.checkNotNull(userId, r'Participant', 'userId');
    BuiltValueNullFieldError.checkNotNull(roomId, r'Participant', 'roomId');
  }

  @override
  Participant rebuild(void Function(ParticipantBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ParticipantBuilder toBuilder() => new ParticipantBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Participant &&
        id == other.id &&
        createdDate == other.createdDate &&
        updatedDate == other.updatedDate &&
        userId == other.userId &&
        roomId == other.roomId;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, id.hashCode), createdDate.hashCode),
                updatedDate.hashCode),
            userId.hashCode),
        roomId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Participant')
          ..add('id', id)
          ..add('createdDate', createdDate)
          ..add('updatedDate', updatedDate)
          ..add('userId', userId)
          ..add('roomId', roomId))
        .toString();
  }
}

class ParticipantBuilder implements Builder<Participant, ParticipantBuilder> {
  _$Participant? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  DateTime? _createdDate;
  DateTime? get createdDate => _$this._createdDate;
  set createdDate(DateTime? createdDate) => _$this._createdDate = createdDate;

  DateTime? _updatedDate;
  DateTime? get updatedDate => _$this._updatedDate;
  set updatedDate(DateTime? updatedDate) => _$this._updatedDate = updatedDate;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _roomId;
  String? get roomId => _$this._roomId;
  set roomId(String? roomId) => _$this._roomId = roomId;

  ParticipantBuilder() {
    Participant._defaults(this);
  }

  ParticipantBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdDate = $v.createdDate;
      _updatedDate = $v.updatedDate;
      _userId = $v.userId;
      _roomId = $v.roomId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Participant other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Participant;
  }

  @override
  void update(void Function(ParticipantBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Participant build() => _build();

  _$Participant _build() {
    final _$result = _$v ??
        new _$Participant._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Participant', 'id'),
            createdDate: createdDate,
            updatedDate: updatedDate,
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'Participant', 'userId'),
            roomId: BuiltValueNullFieldError.checkNotNull(
                roomId, r'Participant', 'roomId'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas