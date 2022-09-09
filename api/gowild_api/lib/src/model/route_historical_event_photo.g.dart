// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_historical_event_photo.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RouteHistoricalEventPhoto extends RouteHistoricalEventPhoto {
  @override
  final String id;
  @override
  final DateTime? createdDate;
  @override
  final DateTime? updatedDate;
  @override
  final String routeHistoricalEventId;
  @override
  final String eventPhotoUrl;

  factory _$RouteHistoricalEventPhoto(
          [void Function(RouteHistoricalEventPhotoBuilder)? updates]) =>
      (new RouteHistoricalEventPhotoBuilder()..update(updates))._build();

  _$RouteHistoricalEventPhoto._(
      {required this.id,
      this.createdDate,
      this.updatedDate,
      required this.routeHistoricalEventId,
      required this.eventPhotoUrl})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        id, r'RouteHistoricalEventPhoto', 'id');
    BuiltValueNullFieldError.checkNotNull(routeHistoricalEventId,
        r'RouteHistoricalEventPhoto', 'routeHistoricalEventId');
    BuiltValueNullFieldError.checkNotNull(
        eventPhotoUrl, r'RouteHistoricalEventPhoto', 'eventPhotoUrl');
  }

  @override
  RouteHistoricalEventPhoto rebuild(
          void Function(RouteHistoricalEventPhotoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RouteHistoricalEventPhotoBuilder toBuilder() =>
      new RouteHistoricalEventPhotoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RouteHistoricalEventPhoto &&
        id == other.id &&
        createdDate == other.createdDate &&
        updatedDate == other.updatedDate &&
        routeHistoricalEventId == other.routeHistoricalEventId &&
        eventPhotoUrl == other.eventPhotoUrl;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, id.hashCode), createdDate.hashCode),
                updatedDate.hashCode),
            routeHistoricalEventId.hashCode),
        eventPhotoUrl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RouteHistoricalEventPhoto')
          ..add('id', id)
          ..add('createdDate', createdDate)
          ..add('updatedDate', updatedDate)
          ..add('routeHistoricalEventId', routeHistoricalEventId)
          ..add('eventPhotoUrl', eventPhotoUrl))
        .toString();
  }
}

class RouteHistoricalEventPhotoBuilder
    implements
        Builder<RouteHistoricalEventPhoto, RouteHistoricalEventPhotoBuilder> {
  _$RouteHistoricalEventPhoto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  DateTime? _createdDate;
  DateTime? get createdDate => _$this._createdDate;
  set createdDate(DateTime? createdDate) => _$this._createdDate = createdDate;

  DateTime? _updatedDate;
  DateTime? get updatedDate => _$this._updatedDate;
  set updatedDate(DateTime? updatedDate) => _$this._updatedDate = updatedDate;

  String? _routeHistoricalEventId;
  String? get routeHistoricalEventId => _$this._routeHistoricalEventId;
  set routeHistoricalEventId(String? routeHistoricalEventId) =>
      _$this._routeHistoricalEventId = routeHistoricalEventId;

  String? _eventPhotoUrl;
  String? get eventPhotoUrl => _$this._eventPhotoUrl;
  set eventPhotoUrl(String? eventPhotoUrl) =>
      _$this._eventPhotoUrl = eventPhotoUrl;

  RouteHistoricalEventPhotoBuilder() {
    RouteHistoricalEventPhoto._defaults(this);
  }

  RouteHistoricalEventPhotoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdDate = $v.createdDate;
      _updatedDate = $v.updatedDate;
      _routeHistoricalEventId = $v.routeHistoricalEventId;
      _eventPhotoUrl = $v.eventPhotoUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RouteHistoricalEventPhoto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RouteHistoricalEventPhoto;
  }

  @override
  void update(void Function(RouteHistoricalEventPhotoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RouteHistoricalEventPhoto build() => _build();

  _$RouteHistoricalEventPhoto _build() {
    final _$result = _$v ??
        new _$RouteHistoricalEventPhoto._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'RouteHistoricalEventPhoto', 'id'),
            createdDate: createdDate,
            updatedDate: updatedDate,
            routeHistoricalEventId: BuiltValueNullFieldError.checkNotNull(
                routeHistoricalEventId,
                r'RouteHistoricalEventPhoto',
                'routeHistoricalEventId'),
            eventPhotoUrl: BuiltValueNullFieldError.checkNotNull(
                eventPhotoUrl, r'RouteHistoricalEventPhoto', 'eventPhotoUrl'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
