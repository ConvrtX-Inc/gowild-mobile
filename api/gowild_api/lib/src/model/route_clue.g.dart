// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_clue.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RouteClue extends RouteClue {
  @override
  final String id;
  @override
  final DateTime? createdDate;
  @override
  final DateTime? updatedDate;
  @override
  final String routeId;
  @override
  final double locationPointLong;
  @override
  final double locationPointLat;
  @override
  final double cluePointLong;
  @override
  final double cluePointLat;
  @override
  final String clueTitle;
  @override
  final String description;
  @override
  final JsonObject clueImg;
  @override
  final String videoUrl;
  @override
  final String arClue;

  factory _$RouteClue([void Function(RouteClueBuilder)? updates]) =>
      (new RouteClueBuilder()..update(updates))._build();

  _$RouteClue._(
      {required this.id,
      this.createdDate,
      this.updatedDate,
      required this.routeId,
      required this.locationPointLong,
      required this.locationPointLat,
      required this.cluePointLong,
      required this.cluePointLat,
      required this.clueTitle,
      required this.description,
      required this.clueImg,
      required this.videoUrl,
      required this.arClue})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'RouteClue', 'id');
    BuiltValueNullFieldError.checkNotNull(routeId, r'RouteClue', 'routeId');
    BuiltValueNullFieldError.checkNotNull(
        locationPointLong, r'RouteClue', 'locationPointLong');
    BuiltValueNullFieldError.checkNotNull(
        locationPointLat, r'RouteClue', 'locationPointLat');
    BuiltValueNullFieldError.checkNotNull(
        cluePointLong, r'RouteClue', 'cluePointLong');
    BuiltValueNullFieldError.checkNotNull(
        cluePointLat, r'RouteClue', 'cluePointLat');
    BuiltValueNullFieldError.checkNotNull(clueTitle, r'RouteClue', 'clueTitle');
    BuiltValueNullFieldError.checkNotNull(
        description, r'RouteClue', 'description');
    BuiltValueNullFieldError.checkNotNull(clueImg, r'RouteClue', 'clueImg');
    BuiltValueNullFieldError.checkNotNull(videoUrl, r'RouteClue', 'videoUrl');
    BuiltValueNullFieldError.checkNotNull(arClue, r'RouteClue', 'arClue');
  }

  @override
  RouteClue rebuild(void Function(RouteClueBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RouteClueBuilder toBuilder() => new RouteClueBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RouteClue &&
        id == other.id &&
        createdDate == other.createdDate &&
        updatedDate == other.updatedDate &&
        routeId == other.routeId &&
        locationPointLong == other.locationPointLong &&
        locationPointLat == other.locationPointLat &&
        cluePointLong == other.cluePointLong &&
        cluePointLat == other.cluePointLat &&
        clueTitle == other.clueTitle &&
        description == other.description &&
        clueImg == other.clueImg &&
        videoUrl == other.videoUrl &&
        arClue == other.arClue;
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
                                            routeId.hashCode),
                                        locationPointLong.hashCode),
                                    locationPointLat.hashCode),
                                cluePointLong.hashCode),
                            cluePointLat.hashCode),
                        clueTitle.hashCode),
                    description.hashCode),
                clueImg.hashCode),
            videoUrl.hashCode),
        arClue.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RouteClue')
          ..add('id', id)
          ..add('createdDate', createdDate)
          ..add('updatedDate', updatedDate)
          ..add('routeId', routeId)
          ..add('locationPointLong', locationPointLong)
          ..add('locationPointLat', locationPointLat)
          ..add('cluePointLong', cluePointLong)
          ..add('cluePointLat', cluePointLat)
          ..add('clueTitle', clueTitle)
          ..add('description', description)
          ..add('clueImg', clueImg)
          ..add('videoUrl', videoUrl)
          ..add('arClue', arClue))
        .toString();
  }
}

class RouteClueBuilder implements Builder<RouteClue, RouteClueBuilder> {
  _$RouteClue? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  DateTime? _createdDate;
  DateTime? get createdDate => _$this._createdDate;
  set createdDate(DateTime? createdDate) => _$this._createdDate = createdDate;

  DateTime? _updatedDate;
  DateTime? get updatedDate => _$this._updatedDate;
  set updatedDate(DateTime? updatedDate) => _$this._updatedDate = updatedDate;

  String? _routeId;
  String? get routeId => _$this._routeId;
  set routeId(String? routeId) => _$this._routeId = routeId;

  double? _locationPointLong;
  double? get locationPointLong => _$this._locationPointLong;
  set locationPointLong(double? locationPointLong) =>
      _$this._locationPointLong = locationPointLong;

  double? _locationPointLat;
  double? get locationPointLat => _$this._locationPointLat;
  set locationPointLat(double? locationPointLat) =>
      _$this._locationPointLat = locationPointLat;

  double? _cluePointLong;
  double? get cluePointLong => _$this._cluePointLong;
  set cluePointLong(double? cluePointLong) =>
      _$this._cluePointLong = cluePointLong;

  double? _cluePointLat;
  double? get cluePointLat => _$this._cluePointLat;
  set cluePointLat(double? cluePointLat) => _$this._cluePointLat = cluePointLat;

  String? _clueTitle;
  String? get clueTitle => _$this._clueTitle;
  set clueTitle(String? clueTitle) => _$this._clueTitle = clueTitle;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  JsonObject? _clueImg;
  JsonObject? get clueImg => _$this._clueImg;
  set clueImg(JsonObject? clueImg) => _$this._clueImg = clueImg;

  String? _videoUrl;
  String? get videoUrl => _$this._videoUrl;
  set videoUrl(String? videoUrl) => _$this._videoUrl = videoUrl;

  String? _arClue;
  String? get arClue => _$this._arClue;
  set arClue(String? arClue) => _$this._arClue = arClue;

  RouteClueBuilder() {
    RouteClue._defaults(this);
  }

  RouteClueBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdDate = $v.createdDate;
      _updatedDate = $v.updatedDate;
      _routeId = $v.routeId;
      _locationPointLong = $v.locationPointLong;
      _locationPointLat = $v.locationPointLat;
      _cluePointLong = $v.cluePointLong;
      _cluePointLat = $v.cluePointLat;
      _clueTitle = $v.clueTitle;
      _description = $v.description;
      _clueImg = $v.clueImg;
      _videoUrl = $v.videoUrl;
      _arClue = $v.arClue;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RouteClue other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RouteClue;
  }

  @override
  void update(void Function(RouteClueBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RouteClue build() => _build();

  _$RouteClue _build() {
    final _$result = _$v ??
        new _$RouteClue._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'RouteClue', 'id'),
            createdDate: createdDate,
            updatedDate: updatedDate,
            routeId: BuiltValueNullFieldError.checkNotNull(
                routeId, r'RouteClue', 'routeId'),
            locationPointLong: BuiltValueNullFieldError.checkNotNull(
                locationPointLong, r'RouteClue', 'locationPointLong'),
            locationPointLat: BuiltValueNullFieldError.checkNotNull(
                locationPointLat, r'RouteClue', 'locationPointLat'),
            cluePointLong: BuiltValueNullFieldError.checkNotNull(
                cluePointLong, r'RouteClue', 'cluePointLong'),
            cluePointLat: BuiltValueNullFieldError.checkNotNull(
                cluePointLat, r'RouteClue', 'cluePointLat'),
            clueTitle: BuiltValueNullFieldError.checkNotNull(
                clueTitle, r'RouteClue', 'clueTitle'),
            description: BuiltValueNullFieldError.checkNotNull(
                description, r'RouteClue', 'description'),
            clueImg: BuiltValueNullFieldError.checkNotNull(
                clueImg, r'RouteClue', 'clueImg'),
            videoUrl:
                BuiltValueNullFieldError.checkNotNull(videoUrl, r'RouteClue', 'videoUrl'),
            arClue: BuiltValueNullFieldError.checkNotNull(arClue, r'RouteClue', 'arClue'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas