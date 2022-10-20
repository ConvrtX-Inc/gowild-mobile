// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treasure_chest.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TreasureChest extends TreasureChest {
  @override
  final String id;
  @override
  final DateTime? createdDate;
  @override
  final DateTime? updatedDate;
  @override
  final String title;
  @override
  final String description;
  @override
  final AppPoint location;
  @override
  final DateTime eventDate;
  @override
  final String eventTime;
  @override
  final num noOfParticipants;
  @override
  final UserEntityPicture? picture;
  @override
  final String aR;

  factory _$TreasureChest([void Function(TreasureChestBuilder)? updates]) =>
      (new TreasureChestBuilder()..update(updates))._build();

  _$TreasureChest._(
      {required this.id,
      this.createdDate,
      this.updatedDate,
      required this.title,
      required this.description,
      required this.location,
      required this.eventDate,
      required this.eventTime,
      required this.noOfParticipants,
      this.picture,
      required this.aR})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'TreasureChest', 'id');
    BuiltValueNullFieldError.checkNotNull(title, r'TreasureChest', 'title');
    BuiltValueNullFieldError.checkNotNull(
        description, r'TreasureChest', 'description');
    BuiltValueNullFieldError.checkNotNull(
        location, r'TreasureChest', 'location');
    BuiltValueNullFieldError.checkNotNull(
        eventDate, r'TreasureChest', 'eventDate');
    BuiltValueNullFieldError.checkNotNull(
        eventTime, r'TreasureChest', 'eventTime');
    BuiltValueNullFieldError.checkNotNull(
        noOfParticipants, r'TreasureChest', 'noOfParticipants');
    BuiltValueNullFieldError.checkNotNull(aR, r'TreasureChest', 'aR');
  }

  @override
  TreasureChest rebuild(void Function(TreasureChestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TreasureChestBuilder toBuilder() => new TreasureChestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TreasureChest &&
        id == other.id &&
        createdDate == other.createdDate &&
        updatedDate == other.updatedDate &&
        title == other.title &&
        description == other.description &&
        location == other.location &&
        eventDate == other.eventDate &&
        eventTime == other.eventTime &&
        noOfParticipants == other.noOfParticipants &&
        picture == other.picture &&
        aR == other.aR;
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
                                        $jc($jc(0, id.hashCode),
                                            createdDate.hashCode),
                                        updatedDate.hashCode),
                                    title.hashCode),
                                description.hashCode),
                            location.hashCode),
                        eventDate.hashCode),
                    eventTime.hashCode),
                noOfParticipants.hashCode),
            picture.hashCode),
        aR.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TreasureChest')
          ..add('id', id)
          ..add('createdDate', createdDate)
          ..add('updatedDate', updatedDate)
          ..add('title', title)
          ..add('description', description)
          ..add('location', location)
          ..add('eventDate', eventDate)
          ..add('eventTime', eventTime)
          ..add('noOfParticipants', noOfParticipants)
          ..add('picture', picture)
          ..add('aR', aR))
        .toString();
  }
}

class TreasureChestBuilder
    implements Builder<TreasureChest, TreasureChestBuilder> {
  _$TreasureChest? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  DateTime? _createdDate;
  DateTime? get createdDate => _$this._createdDate;
  set createdDate(DateTime? createdDate) => _$this._createdDate = createdDate;

  DateTime? _updatedDate;
  DateTime? get updatedDate => _$this._updatedDate;
  set updatedDate(DateTime? updatedDate) => _$this._updatedDate = updatedDate;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  AppPointBuilder? _location;
  AppPointBuilder get location => _$this._location ??= new AppPointBuilder();
  set location(AppPointBuilder? location) => _$this._location = location;

  DateTime? _eventDate;
  DateTime? get eventDate => _$this._eventDate;
  set eventDate(DateTime? eventDate) => _$this._eventDate = eventDate;

  String? _eventTime;
  String? get eventTime => _$this._eventTime;
  set eventTime(String? eventTime) => _$this._eventTime = eventTime;

  num? _noOfParticipants;
  num? get noOfParticipants => _$this._noOfParticipants;
  set noOfParticipants(num? noOfParticipants) =>
      _$this._noOfParticipants = noOfParticipants;

  UserEntityPictureBuilder? _picture;
  UserEntityPictureBuilder get picture =>
      _$this._picture ??= new UserEntityPictureBuilder();
  set picture(UserEntityPictureBuilder? picture) => _$this._picture = picture;

  String? _aR;
  String? get aR => _$this._aR;
  set aR(String? aR) => _$this._aR = aR;

  TreasureChestBuilder() {
    TreasureChest._defaults(this);
  }

  TreasureChestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdDate = $v.createdDate;
      _updatedDate = $v.updatedDate;
      _title = $v.title;
      _description = $v.description;
      _location = $v.location.toBuilder();
      _eventDate = $v.eventDate;
      _eventTime = $v.eventTime;
      _noOfParticipants = $v.noOfParticipants;
      _picture = $v.picture?.toBuilder();
      _aR = $v.aR;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TreasureChest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TreasureChest;
  }

  @override
  void update(void Function(TreasureChestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TreasureChest build() => _build();

  _$TreasureChest _build() {
    _$TreasureChest _$result;
    try {
      _$result = _$v ??
          new _$TreasureChest._(
              id: BuiltValueNullFieldError.checkNotNull(
                  id, r'TreasureChest', 'id'),
              createdDate: createdDate,
              updatedDate: updatedDate,
              title: BuiltValueNullFieldError.checkNotNull(
                  title, r'TreasureChest', 'title'),
              description: BuiltValueNullFieldError.checkNotNull(
                  description, r'TreasureChest', 'description'),
              location: location.build(),
              eventDate: BuiltValueNullFieldError.checkNotNull(
                  eventDate, r'TreasureChest', 'eventDate'),
              eventTime: BuiltValueNullFieldError.checkNotNull(
                  eventTime, r'TreasureChest', 'eventTime'),
              noOfParticipants: BuiltValueNullFieldError.checkNotNull(
                  noOfParticipants, r'TreasureChest', 'noOfParticipants'),
              picture: _picture?.build(),
              aR: BuiltValueNullFieldError.checkNotNull(
                  aR, r'TreasureChest', 'aR'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'location';
        location.build();

        _$failedField = 'picture';
        _picture?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'TreasureChest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
