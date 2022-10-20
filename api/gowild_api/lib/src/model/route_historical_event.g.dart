// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_historical_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RouteHistoricalEvent extends RouteHistoricalEvent {
  @override
  final String id;
  @override
  final DateTime? createdDate;
  @override
  final DateTime? updatedDate;
  @override
  final RouteHistoricalEventRoute? route;
  @override
  final String? closureUid;
  @override
  final RouteHistoricalEventPoint? point;
  @override
  final String? title;
  @override
  final String? subtitle;
  @override
  final String? description;
  @override
  final UserEntityPicture? image;
  @override
  final BuiltList<FileEntity>? medias;

  factory _$RouteHistoricalEvent(
          [void Function(RouteHistoricalEventBuilder)? updates]) =>
      (new RouteHistoricalEventBuilder()..update(updates))._build();

  _$RouteHistoricalEvent._(
      {required this.id,
      this.createdDate,
      this.updatedDate,
      this.route,
      this.closureUid,
      this.point,
      this.title,
      this.subtitle,
      this.description,
      this.image,
      this.medias})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'RouteHistoricalEvent', 'id');
  }

  @override
  RouteHistoricalEvent rebuild(
          void Function(RouteHistoricalEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RouteHistoricalEventBuilder toBuilder() =>
      new RouteHistoricalEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RouteHistoricalEvent &&
        id == other.id &&
        createdDate == other.createdDate &&
        updatedDate == other.updatedDate &&
        route == other.route &&
        closureUid == other.closureUid &&
        point == other.point &&
        title == other.title &&
        subtitle == other.subtitle &&
        description == other.description &&
        image == other.image &&
        medias == other.medias;
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
                                    route.hashCode),
                                closureUid.hashCode),
                            point.hashCode),
                        title.hashCode),
                    subtitle.hashCode),
                description.hashCode),
            image.hashCode),
        medias.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RouteHistoricalEvent')
          ..add('id', id)
          ..add('createdDate', createdDate)
          ..add('updatedDate', updatedDate)
          ..add('route', route)
          ..add('closureUid', closureUid)
          ..add('point', point)
          ..add('title', title)
          ..add('subtitle', subtitle)
          ..add('description', description)
          ..add('image', image)
          ..add('medias', medias))
        .toString();
  }
}

class RouteHistoricalEventBuilder
    implements Builder<RouteHistoricalEvent, RouteHistoricalEventBuilder> {
  _$RouteHistoricalEvent? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  DateTime? _createdDate;
  DateTime? get createdDate => _$this._createdDate;
  set createdDate(DateTime? createdDate) => _$this._createdDate = createdDate;

  DateTime? _updatedDate;
  DateTime? get updatedDate => _$this._updatedDate;
  set updatedDate(DateTime? updatedDate) => _$this._updatedDate = updatedDate;

  RouteHistoricalEventRouteBuilder? _route;
  RouteHistoricalEventRouteBuilder get route =>
      _$this._route ??= new RouteHistoricalEventRouteBuilder();
  set route(RouteHistoricalEventRouteBuilder? route) => _$this._route = route;

  String? _closureUid;
  String? get closureUid => _$this._closureUid;
  set closureUid(String? closureUid) => _$this._closureUid = closureUid;

  RouteHistoricalEventPointBuilder? _point;
  RouteHistoricalEventPointBuilder get point =>
      _$this._point ??= new RouteHistoricalEventPointBuilder();
  set point(RouteHistoricalEventPointBuilder? point) => _$this._point = point;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _subtitle;
  String? get subtitle => _$this._subtitle;
  set subtitle(String? subtitle) => _$this._subtitle = subtitle;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  UserEntityPictureBuilder? _image;
  UserEntityPictureBuilder get image =>
      _$this._image ??= new UserEntityPictureBuilder();
  set image(UserEntityPictureBuilder? image) => _$this._image = image;

  ListBuilder<FileEntity>? _medias;
  ListBuilder<FileEntity> get medias =>
      _$this._medias ??= new ListBuilder<FileEntity>();
  set medias(ListBuilder<FileEntity>? medias) => _$this._medias = medias;

  RouteHistoricalEventBuilder() {
    RouteHistoricalEvent._defaults(this);
  }

  RouteHistoricalEventBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdDate = $v.createdDate;
      _updatedDate = $v.updatedDate;
      _route = $v.route?.toBuilder();
      _closureUid = $v.closureUid;
      _point = $v.point?.toBuilder();
      _title = $v.title;
      _subtitle = $v.subtitle;
      _description = $v.description;
      _image = $v.image?.toBuilder();
      _medias = $v.medias?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RouteHistoricalEvent other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RouteHistoricalEvent;
  }

  @override
  void update(void Function(RouteHistoricalEventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RouteHistoricalEvent build() => _build();

  _$RouteHistoricalEvent _build() {
    _$RouteHistoricalEvent _$result;
    try {
      _$result = _$v ??
          new _$RouteHistoricalEvent._(
              id: BuiltValueNullFieldError.checkNotNull(
                  id, r'RouteHistoricalEvent', 'id'),
              createdDate: createdDate,
              updatedDate: updatedDate,
              route: _route?.build(),
              closureUid: closureUid,
              point: _point?.build(),
              title: title,
              subtitle: subtitle,
              description: description,
              image: _image?.build(),
              medias: _medias?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'route';
        _route?.build();

        _$failedField = 'point';
        _point?.build();

        _$failedField = 'image';
        _image?.build();
        _$failedField = 'medias';
        _medias?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'RouteHistoricalEvent', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
