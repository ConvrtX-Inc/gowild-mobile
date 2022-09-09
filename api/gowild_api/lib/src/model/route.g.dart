// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Route extends Route {
  @override
  final String id;
  @override
  final DateTime? createdDate;
  @override
  final DateTime? updatedDate;
  @override
  final String userId;
  @override
  final String routeName;
  @override
  final JsonObject routePhoto;
  @override
  final double startPointLong;
  @override
  final double startPointLat;
  @override
  final double stopPointLong;
  @override
  final double stopPointLat;
  @override
  final String imgUrl;
  @override
  final String description;

  factory _$Route([void Function(RouteBuilder)? updates]) =>
      (new RouteBuilder()..update(updates))._build();

  _$Route._(
      {required this.id,
      this.createdDate,
      this.updatedDate,
      required this.userId,
      required this.routeName,
      required this.routePhoto,
      required this.startPointLong,
      required this.startPointLat,
      required this.stopPointLong,
      required this.stopPointLat,
      required this.imgUrl,
      required this.description})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'Route', 'id');
    BuiltValueNullFieldError.checkNotNull(userId, r'Route', 'userId');
    BuiltValueNullFieldError.checkNotNull(routeName, r'Route', 'routeName');
    BuiltValueNullFieldError.checkNotNull(routePhoto, r'Route', 'routePhoto');
    BuiltValueNullFieldError.checkNotNull(
        startPointLong, r'Route', 'startPointLong');
    BuiltValueNullFieldError.checkNotNull(
        startPointLat, r'Route', 'startPointLat');
    BuiltValueNullFieldError.checkNotNull(
        stopPointLong, r'Route', 'stopPointLong');
    BuiltValueNullFieldError.checkNotNull(
        stopPointLat, r'Route', 'stopPointLat');
    BuiltValueNullFieldError.checkNotNull(imgUrl, r'Route', 'imgUrl');
    BuiltValueNullFieldError.checkNotNull(description, r'Route', 'description');
  }

  @override
  Route rebuild(void Function(RouteBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RouteBuilder toBuilder() => new RouteBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Route &&
        id == other.id &&
        createdDate == other.createdDate &&
        updatedDate == other.updatedDate &&
        userId == other.userId &&
        routeName == other.routeName &&
        routePhoto == other.routePhoto &&
        startPointLong == other.startPointLong &&
        startPointLat == other.startPointLat &&
        stopPointLong == other.stopPointLong &&
        stopPointLat == other.stopPointLat &&
        imgUrl == other.imgUrl &&
        description == other.description;
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
                                            $jc($jc(0, id.hashCode),
                                                createdDate.hashCode),
                                            updatedDate.hashCode),
                                        userId.hashCode),
                                    routeName.hashCode),
                                routePhoto.hashCode),
                            startPointLong.hashCode),
                        startPointLat.hashCode),
                    stopPointLong.hashCode),
                stopPointLat.hashCode),
            imgUrl.hashCode),
        description.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Route')
          ..add('id', id)
          ..add('createdDate', createdDate)
          ..add('updatedDate', updatedDate)
          ..add('userId', userId)
          ..add('routeName', routeName)
          ..add('routePhoto', routePhoto)
          ..add('startPointLong', startPointLong)
          ..add('startPointLat', startPointLat)
          ..add('stopPointLong', stopPointLong)
          ..add('stopPointLat', stopPointLat)
          ..add('imgUrl', imgUrl)
          ..add('description', description))
        .toString();
  }
}

class RouteBuilder implements Builder<Route, RouteBuilder> {
  _$Route? _$v;

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

  String? _routeName;
  String? get routeName => _$this._routeName;
  set routeName(String? routeName) => _$this._routeName = routeName;

  JsonObject? _routePhoto;
  JsonObject? get routePhoto => _$this._routePhoto;
  set routePhoto(JsonObject? routePhoto) => _$this._routePhoto = routePhoto;

  double? _startPointLong;
  double? get startPointLong => _$this._startPointLong;
  set startPointLong(double? startPointLong) =>
      _$this._startPointLong = startPointLong;

  double? _startPointLat;
  double? get startPointLat => _$this._startPointLat;
  set startPointLat(double? startPointLat) =>
      _$this._startPointLat = startPointLat;

  double? _stopPointLong;
  double? get stopPointLong => _$this._stopPointLong;
  set stopPointLong(double? stopPointLong) =>
      _$this._stopPointLong = stopPointLong;

  double? _stopPointLat;
  double? get stopPointLat => _$this._stopPointLat;
  set stopPointLat(double? stopPointLat) => _$this._stopPointLat = stopPointLat;

  String? _imgUrl;
  String? get imgUrl => _$this._imgUrl;
  set imgUrl(String? imgUrl) => _$this._imgUrl = imgUrl;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  RouteBuilder() {
    Route._defaults(this);
  }

  RouteBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdDate = $v.createdDate;
      _updatedDate = $v.updatedDate;
      _userId = $v.userId;
      _routeName = $v.routeName;
      _routePhoto = $v.routePhoto;
      _startPointLong = $v.startPointLong;
      _startPointLat = $v.startPointLat;
      _stopPointLong = $v.stopPointLong;
      _stopPointLat = $v.stopPointLat;
      _imgUrl = $v.imgUrl;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Route other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Route;
  }

  @override
  void update(void Function(RouteBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Route build() => _build();

  _$Route _build() {
    final _$result = _$v ??
        new _$Route._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Route', 'id'),
            createdDate: createdDate,
            updatedDate: updatedDate,
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'Route', 'userId'),
            routeName: BuiltValueNullFieldError.checkNotNull(
                routeName, r'Route', 'routeName'),
            routePhoto: BuiltValueNullFieldError.checkNotNull(
                routePhoto, r'Route', 'routePhoto'),
            startPointLong: BuiltValueNullFieldError.checkNotNull(
                startPointLong, r'Route', 'startPointLong'),
            startPointLat: BuiltValueNullFieldError.checkNotNull(
                startPointLat, r'Route', 'startPointLat'),
            stopPointLong: BuiltValueNullFieldError.checkNotNull(
                stopPointLong, r'Route', 'stopPointLong'),
            stopPointLat: BuiltValueNullFieldError.checkNotNull(
                stopPointLat, r'Route', 'stopPointLat'),
            imgUrl: BuiltValueNullFieldError.checkNotNull(
                imgUrl, r'Route', 'imgUrl'),
            description: BuiltValueNullFieldError.checkNotNull(
                description, r'Route', 'description'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
