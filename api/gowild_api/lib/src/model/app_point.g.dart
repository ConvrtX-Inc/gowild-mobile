// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_point.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AppPointTypeEnum _$appPointTypeEnum_point =
    const AppPointTypeEnum._('point');

AppPointTypeEnum _$appPointTypeEnumValueOf(String name) {
  switch (name) {
    case 'point':
      return _$appPointTypeEnum_point;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<AppPointTypeEnum> _$appPointTypeEnumValues =
    new BuiltSet<AppPointTypeEnum>(const <AppPointTypeEnum>[
  _$appPointTypeEnum_point,
]);

Serializer<AppPointTypeEnum> _$appPointTypeEnumSerializer =
    new _$AppPointTypeEnumSerializer();

class _$AppPointTypeEnumSerializer
    implements PrimitiveSerializer<AppPointTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'point': 'Point',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Point': 'point',
  };

  @override
  final Iterable<Type> types = const <Type>[AppPointTypeEnum];
  @override
  final String wireName = 'AppPointTypeEnum';

  @override
  Object serialize(Serializers serializers, AppPointTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AppPointTypeEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AppPointTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$AppPoint extends AppPoint {
  @override
  final AppPointTypeEnum type;
  @override
  final BuiltList<double> coordinates;

  factory _$AppPoint([void Function(AppPointBuilder)? updates]) =>
      (new AppPointBuilder()..update(updates))._build();

  _$AppPoint._({required this.type, required this.coordinates}) : super._() {
    BuiltValueNullFieldError.checkNotNull(type, r'AppPoint', 'type');
    BuiltValueNullFieldError.checkNotNull(
        coordinates, r'AppPoint', 'coordinates');
  }

  @override
  AppPoint rebuild(void Function(AppPointBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppPointBuilder toBuilder() => new AppPointBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppPoint &&
        type == other.type &&
        coordinates == other.coordinates;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, type.hashCode), coordinates.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AppPoint')
          ..add('type', type)
          ..add('coordinates', coordinates))
        .toString();
  }
}

class AppPointBuilder implements Builder<AppPoint, AppPointBuilder> {
  _$AppPoint? _$v;

  AppPointTypeEnum? _type;
  AppPointTypeEnum? get type => _$this._type;
  set type(AppPointTypeEnum? type) => _$this._type = type;

  ListBuilder<double>? _coordinates;
  ListBuilder<double> get coordinates =>
      _$this._coordinates ??= new ListBuilder<double>();
  set coordinates(ListBuilder<double>? coordinates) =>
      _$this._coordinates = coordinates;

  AppPointBuilder() {
    AppPoint._defaults(this);
  }

  AppPointBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _coordinates = $v.coordinates.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppPoint other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AppPoint;
  }

  @override
  void update(void Function(AppPointBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AppPoint build() => _build();

  _$AppPoint _build() {
    _$AppPoint _$result;
    try {
      _$result = _$v ??
          new _$AppPoint._(
              type: BuiltValueNullFieldError.checkNotNull(
                  type, r'AppPoint', 'type'),
              coordinates: coordinates.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'coordinates';
        coordinates.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'AppPoint', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
