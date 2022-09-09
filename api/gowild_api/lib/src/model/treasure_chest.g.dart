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
  final double locationLong;
  @override
  final double locationLat;
  @override
  final DateTime eventDate;
  @override
  final String eventTime;
  @override
  final num noOfParticipants;
  @override
  final String imgUrl;
  @override
  final JsonObject thumbnailImg;
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
      required this.locationLong,
      required this.locationLat,
      required this.eventDate,
      required this.eventTime,
      required this.noOfParticipants,
      required this.imgUrl,
      required this.thumbnailImg,
      required this.aR})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'TreasureChest', 'id');
    BuiltValueNullFieldError.checkNotNull(title, r'TreasureChest', 'title');
    BuiltValueNullFieldError.checkNotNull(
        description, r'TreasureChest', 'description');
    BuiltValueNullFieldError.checkNotNull(
        locationLong, r'TreasureChest', 'locationLong');
    BuiltValueNullFieldError.checkNotNull(
        locationLat, r'TreasureChest', 'locationLat');
    BuiltValueNullFieldError.checkNotNull(
        eventDate, r'TreasureChest', 'eventDate');
    BuiltValueNullFieldError.checkNotNull(
        eventTime, r'TreasureChest', 'eventTime');
    BuiltValueNullFieldError.checkNotNull(
        noOfParticipants, r'TreasureChest', 'noOfParticipants');
    BuiltValueNullFieldError.checkNotNull(imgUrl, r'TreasureChest', 'imgUrl');
    BuiltValueNullFieldError.checkNotNull(
        thumbnailImg, r'TreasureChest', 'thumbnailImg');
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
        locationLong == other.locationLong &&
        locationLat == other.locationLat &&
        eventDate == other.eventDate &&
        eventTime == other.eventTime &&
        noOfParticipants == other.noOfParticipants &&
        imgUrl == other.imgUrl &&
        thumbnailImg == other.thumbnailImg &&
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
                                        $jc(
                                            $jc(
                                                $jc($jc(0, id.hashCode),
                                                    createdDate.hashCode),
                                                updatedDate.hashCode),
                                            title.hashCode),
                                        description.hashCode),
                                    locationLong.hashCode),
                                locationLat.hashCode),
                            eventDate.hashCode),
                        eventTime.hashCode),
                    noOfParticipants.hashCode),
                imgUrl.hashCode),
            thumbnailImg.hashCode),
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
          ..add('locationLong', locationLong)
          ..add('locationLat', locationLat)
          ..add('eventDate', eventDate)
          ..add('eventTime', eventTime)
          ..add('noOfParticipants', noOfParticipants)
          ..add('imgUrl', imgUrl)
          ..add('thumbnailImg', thumbnailImg)
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

  double? _locationLong;
  double? get locationLong => _$this._locationLong;
  set locationLong(double? locationLong) => _$this._locationLong = locationLong;

  double? _locationLat;
  double? get locationLat => _$this._locationLat;
  set locationLat(double? locationLat) => _$this._locationLat = locationLat;

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

  String? _imgUrl;
  String? get imgUrl => _$this._imgUrl;
  set imgUrl(String? imgUrl) => _$this._imgUrl = imgUrl;

  JsonObject? _thumbnailImg;
  JsonObject? get thumbnailImg => _$this._thumbnailImg;
  set thumbnailImg(JsonObject? thumbnailImg) =>
      _$this._thumbnailImg = thumbnailImg;

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
      _locationLong = $v.locationLong;
      _locationLat = $v.locationLat;
      _eventDate = $v.eventDate;
      _eventTime = $v.eventTime;
      _noOfParticipants = $v.noOfParticipants;
      _imgUrl = $v.imgUrl;
      _thumbnailImg = $v.thumbnailImg;
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
    final _$result = _$v ??
        new _$TreasureChest._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'TreasureChest', 'id'),
            createdDate: createdDate,
            updatedDate: updatedDate,
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'TreasureChest', 'title'),
            description: BuiltValueNullFieldError.checkNotNull(
                description, r'TreasureChest', 'description'),
            locationLong: BuiltValueNullFieldError.checkNotNull(
                locationLong, r'TreasureChest', 'locationLong'),
            locationLat: BuiltValueNullFieldError.checkNotNull(
                locationLat, r'TreasureChest', 'locationLat'),
            eventDate: BuiltValueNullFieldError.checkNotNull(
                eventDate, r'TreasureChest', 'eventDate'),
            eventTime: BuiltValueNullFieldError.checkNotNull(
                eventTime, r'TreasureChest', 'eventTime'),
            noOfParticipants: BuiltValueNullFieldError.checkNotNull(
                noOfParticipants, r'TreasureChest', 'noOfParticipants'),
            imgUrl: BuiltValueNullFieldError.checkNotNull(
                imgUrl, r'TreasureChest', 'imgUrl'),
            thumbnailImg:
                BuiltValueNullFieldError.checkNotNull(thumbnailImg, r'TreasureChest', 'thumbnailImg'),
            aR: BuiltValueNullFieldError.checkNotNull(aR, r'TreasureChest', 'aR'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
