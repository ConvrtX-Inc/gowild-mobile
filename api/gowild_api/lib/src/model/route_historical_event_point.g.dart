// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_historical_event_point.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const RouteHistoricalEventPointTypeEnum
    _$routeHistoricalEventPointTypeEnum_point =
    const RouteHistoricalEventPointTypeEnum._('point');

RouteHistoricalEventPointTypeEnum _$routeHistoricalEventPointTypeEnumValueOf(
    String name) {
  switch (name) {
    case 'point':
      return _$routeHistoricalEventPointTypeEnum_point;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<RouteHistoricalEventPointTypeEnum>
    _$routeHistoricalEventPointTypeEnumValues =
    new BuiltSet<RouteHistoricalEventPointTypeEnum>(const <
        RouteHistoricalEventPointTypeEnum>[
  _$routeHistoricalEventPointTypeEnum_point,
]);

Serializer<RouteHistoricalEventPointTypeEnum>
    _$routeHistoricalEventPointTypeEnumSerializer =
    new _$RouteHistoricalEventPointTypeEnumSerializer();

class _$RouteHistoricalEventPointTypeEnumSerializer
    implements PrimitiveSerializer<RouteHistoricalEventPointTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'point': 'Point',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Point': 'point',
  };

  @override
  final Iterable<Type> types = const <Type>[RouteHistoricalEventPointTypeEnum];
  @override
  final String wireName = 'RouteHistoricalEventPointTypeEnum';

  @override
  Object serialize(
          Serializers serializers, RouteHistoricalEventPointTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  RouteHistoricalEventPointTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      RouteHistoricalEventPointTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$RouteHistoricalEventPoint extends RouteHistoricalEventPoint {
  @override
  final RouteHistoricalEventPointTypeEnum type;
  @override
  final BuiltList<double> coordinates;

  factory _$RouteHistoricalEventPoint(
          [void Function(RouteHistoricalEventPointBuilder)? updates]) =>
      (new RouteHistoricalEventPointBuilder()..update(updates))._build();

  _$RouteHistoricalEventPoint._({required this.type, required this.coordinates})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        type, r'RouteHistoricalEventPoint', 'type');
    BuiltValueNullFieldError.checkNotNull(
        coordinates, r'RouteHistoricalEventPoint', 'coordinates');
  }

  @override
  RouteHistoricalEventPoint rebuild(
          void Function(RouteHistoricalEventPointBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RouteHistoricalEventPointBuilder toBuilder() =>
      new RouteHistoricalEventPointBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RouteHistoricalEventPoint &&
        type == other.type &&
        coordinates == other.coordinates;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, type.hashCode), coordinates.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RouteHistoricalEventPoint')
          ..add('type', type)
          ..add('coordinates', coordinates))
        .toString();
  }
}

class RouteHistoricalEventPointBuilder
    implements
        Builder<RouteHistoricalEventPoint, RouteHistoricalEventPointBuilder> {
  _$RouteHistoricalEventPoint? _$v;

  RouteHistoricalEventPointTypeEnum? _type;
  RouteHistoricalEventPointTypeEnum? get type => _$this._type;
  set type(RouteHistoricalEventPointTypeEnum? type) => _$this._type = type;

  ListBuilder<double>? _coordinates;
  ListBuilder<double> get coordinates =>
      _$this._coordinates ??= new ListBuilder<double>();
  set coordinates(ListBuilder<double>? coordinates) =>
      _$this._coordinates = coordinates;

  RouteHistoricalEventPointBuilder() {
    RouteHistoricalEventPoint._defaults(this);
  }

  RouteHistoricalEventPointBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _coordinates = $v.coordinates.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RouteHistoricalEventPoint other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RouteHistoricalEventPoint;
  }

  @override
  void update(void Function(RouteHistoricalEventPointBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RouteHistoricalEventPoint build() => _build();

  _$RouteHistoricalEventPoint _build() {
    _$RouteHistoricalEventPoint _$result;
    try {
      _$result = _$v ??
          new _$RouteHistoricalEventPoint._(
              type: BuiltValueNullFieldError.checkNotNull(
                  type, r'RouteHistoricalEventPoint', 'type'),
              coordinates: coordinates.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'coordinates';
        coordinates.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'RouteHistoricalEventPoint', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
