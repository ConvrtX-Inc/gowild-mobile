// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Room extends Room {
  @override
  final String id;
  @override
  final DateTime? createdDate;
  @override
  final DateTime? updatedDate;
  @override
  final String name;
  @override
  final String type;

  factory _$Room([void Function(RoomBuilder)? updates]) =>
      (new RoomBuilder()..update(updates))._build();

  _$Room._(
      {required this.id,
      this.createdDate,
      this.updatedDate,
      required this.name,
      required this.type})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'Room', 'id');
    BuiltValueNullFieldError.checkNotNull(name, r'Room', 'name');
    BuiltValueNullFieldError.checkNotNull(type, r'Room', 'type');
  }

  @override
  Room rebuild(void Function(RoomBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RoomBuilder toBuilder() => new RoomBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Room &&
        id == other.id &&
        createdDate == other.createdDate &&
        updatedDate == other.updatedDate &&
        name == other.name &&
        type == other.type;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, id.hashCode), createdDate.hashCode),
                updatedDate.hashCode),
            name.hashCode),
        type.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Room')
          ..add('id', id)
          ..add('createdDate', createdDate)
          ..add('updatedDate', updatedDate)
          ..add('name', name)
          ..add('type', type))
        .toString();
  }
}

class RoomBuilder implements Builder<Room, RoomBuilder> {
  _$Room? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  DateTime? _createdDate;
  DateTime? get createdDate => _$this._createdDate;
  set createdDate(DateTime? createdDate) => _$this._createdDate = createdDate;

  DateTime? _updatedDate;
  DateTime? get updatedDate => _$this._updatedDate;
  set updatedDate(DateTime? updatedDate) => _$this._updatedDate = updatedDate;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  RoomBuilder() {
    Room._defaults(this);
  }

  RoomBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdDate = $v.createdDate;
      _updatedDate = $v.updatedDate;
      _name = $v.name;
      _type = $v.type;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Room other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Room;
  }

  @override
  void update(void Function(RoomBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Room build() => _build();

  _$Room _build() {
    final _$result = _$v ??
        new _$Room._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Room', 'id'),
            createdDate: createdDate,
            updatedDate: updatedDate,
            name: BuiltValueNullFieldError.checkNotNull(name, r'Room', 'name'),
            type: BuiltValueNullFieldError.checkNotNull(type, r'Room', 'type'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas