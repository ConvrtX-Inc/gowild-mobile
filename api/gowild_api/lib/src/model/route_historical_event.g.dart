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
  final String routeId;
  @override
  final String closureUid;
  @override
  final double eventLong;
  @override
  final double eventLat;
  @override
  final String eventTitle;
  @override
  final String eventSubtitle;
  @override
  final String description;

  factory _$RouteHistoricalEvent(
          [void Function(RouteHistoricalEventBuilder)? updates]) =>
      (new RouteHistoricalEventBuilder()..update(updates))._build();

  _$RouteHistoricalEvent._(
      {required this.id,
      this.createdDate,
      this.updatedDate,
      required this.routeId,
      required this.closureUid,
      required this.eventLong,
      required this.eventLat,
      required this.eventTitle,
      required this.eventSubtitle,
      required this.description})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'RouteHistoricalEvent', 'id');
    BuiltValueNullFieldError.checkNotNull(
        routeId, r'RouteHistoricalEvent', 'routeId');
    BuiltValueNullFieldError.checkNotNull(
        closureUid, r'RouteHistoricalEvent', 'closureUid');
    BuiltValueNullFieldError.checkNotNull(
        eventLong, r'RouteHistoricalEvent', 'eventLong');
    BuiltValueNullFieldError.checkNotNull(
        eventLat, r'RouteHistoricalEvent', 'eventLat');
    BuiltValueNullFieldError.checkNotNull(
        eventTitle, r'RouteHistoricalEvent', 'eventTitle');
    BuiltValueNullFieldError.checkNotNull(
        eventSubtitle, r'RouteHistoricalEvent', 'eventSubtitle');
    BuiltValueNullFieldError.checkNotNull(
        description, r'RouteHistoricalEvent', 'description');
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
        routeId == other.routeId &&
        closureUid == other.closureUid &&
        eventLong == other.eventLong &&
        eventLat == other.eventLat &&
        eventTitle == other.eventTitle &&
        eventSubtitle == other.eventSubtitle &&
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
                                    $jc($jc(0, id.hashCode),
                                        createdDate.hashCode),
                                    updatedDate.hashCode),
                                routeId.hashCode),
                            closureUid.hashCode),
                        eventLong.hashCode),
                    eventLat.hashCode),
                eventTitle.hashCode),
            eventSubtitle.hashCode),
        description.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RouteHistoricalEvent')
          ..add('id', id)
          ..add('createdDate', createdDate)
          ..add('updatedDate', updatedDate)
          ..add('routeId', routeId)
          ..add('closureUid', closureUid)
          ..add('eventLong', eventLong)
          ..add('eventLat', eventLat)
          ..add('eventTitle', eventTitle)
          ..add('eventSubtitle', eventSubtitle)
          ..add('description', description))
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

  String? _routeId;
  String? get routeId => _$this._routeId;
  set routeId(String? routeId) => _$this._routeId = routeId;

  String? _closureUid;
  String? get closureUid => _$this._closureUid;
  set closureUid(String? closureUid) => _$this._closureUid = closureUid;

  double? _eventLong;
  double? get eventLong => _$this._eventLong;
  set eventLong(double? eventLong) => _$this._eventLong = eventLong;

  double? _eventLat;
  double? get eventLat => _$this._eventLat;
  set eventLat(double? eventLat) => _$this._eventLat = eventLat;

  String? _eventTitle;
  String? get eventTitle => _$this._eventTitle;
  set eventTitle(String? eventTitle) => _$this._eventTitle = eventTitle;

  String? _eventSubtitle;
  String? get eventSubtitle => _$this._eventSubtitle;
  set eventSubtitle(String? eventSubtitle) =>
      _$this._eventSubtitle = eventSubtitle;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  RouteHistoricalEventBuilder() {
    RouteHistoricalEvent._defaults(this);
  }

  RouteHistoricalEventBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdDate = $v.createdDate;
      _updatedDate = $v.updatedDate;
      _routeId = $v.routeId;
      _closureUid = $v.closureUid;
      _eventLong = $v.eventLong;
      _eventLat = $v.eventLat;
      _eventTitle = $v.eventTitle;
      _eventSubtitle = $v.eventSubtitle;
      _description = $v.description;
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
    final _$result = _$v ??
        new _$RouteHistoricalEvent._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'RouteHistoricalEvent', 'id'),
            createdDate: createdDate,
            updatedDate: updatedDate,
            routeId: BuiltValueNullFieldError.checkNotNull(
                routeId, r'RouteHistoricalEvent', 'routeId'),
            closureUid: BuiltValueNullFieldError.checkNotNull(
                closureUid, r'RouteHistoricalEvent', 'closureUid'),
            eventLong: BuiltValueNullFieldError.checkNotNull(
                eventLong, r'RouteHistoricalEvent', 'eventLong'),
            eventLat: BuiltValueNullFieldError.checkNotNull(
                eventLat, r'RouteHistoricalEvent', 'eventLat'),
            eventTitle: BuiltValueNullFieldError.checkNotNull(
                eventTitle, r'RouteHistoricalEvent', 'eventTitle'),
            eventSubtitle: BuiltValueNullFieldError.checkNotNull(
                eventSubtitle, r'RouteHistoricalEvent', 'eventSubtitle'),
            description: BuiltValueNullFieldError.checkNotNull(
                description, r'RouteHistoricalEvent', 'description'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
