// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'map_settings_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MapsSettings _$MapsSettingsFromJson(Map<String, dynamic> json) {
  return _MapsSettings.fromJson(json);
}

/// @nodoc
mixin _$MapsSettings {
  Set<MapPicked>? get mapTypePicked => throw _privateConstructorUsedError;
  bool? get roadMap => throw _privateConstructorUsedError;
  bool? get terrain => throw _privateConstructorUsedError;
  bool? get satellite => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MapsSettingsCopyWith<MapsSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapsSettingsCopyWith<$Res> {
  factory $MapsSettingsCopyWith(
          MapsSettings value, $Res Function(MapsSettings) then) =
      _$MapsSettingsCopyWithImpl<$Res>;
  $Res call(
      {Set<MapPicked>? mapTypePicked,
      bool? roadMap,
      bool? terrain,
      bool? satellite});
}

/// @nodoc
class _$MapsSettingsCopyWithImpl<$Res> implements $MapsSettingsCopyWith<$Res> {
  _$MapsSettingsCopyWithImpl(this._value, this._then);

  final MapsSettings _value;
  // ignore: unused_field
  final $Res Function(MapsSettings) _then;

  @override
  $Res call({
    Object? mapTypePicked = freezed,
    Object? roadMap = freezed,
    Object? terrain = freezed,
    Object? satellite = freezed,
  }) {
    return _then(_value.copyWith(
      mapTypePicked: mapTypePicked == freezed
          ? _value.mapTypePicked
          : mapTypePicked // ignore: cast_nullable_to_non_nullable
              as Set<MapPicked>?,
      roadMap: roadMap == freezed
          ? _value.roadMap
          : roadMap // ignore: cast_nullable_to_non_nullable
              as bool?,
      terrain: terrain == freezed
          ? _value.terrain
          : terrain // ignore: cast_nullable_to_non_nullable
              as bool?,
      satellite: satellite == freezed
          ? _value.satellite
          : satellite // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
abstract class _$$_MapsSettingsCopyWith<$Res>
    implements $MapsSettingsCopyWith<$Res> {
  factory _$$_MapsSettingsCopyWith(
          _$_MapsSettings value, $Res Function(_$_MapsSettings) then) =
      __$$_MapsSettingsCopyWithImpl<$Res>;
  @override
  $Res call(
      {Set<MapPicked>? mapTypePicked,
      bool? roadMap,
      bool? terrain,
      bool? satellite});
}

/// @nodoc
class __$$_MapsSettingsCopyWithImpl<$Res>
    extends _$MapsSettingsCopyWithImpl<$Res>
    implements _$$_MapsSettingsCopyWith<$Res> {
  __$$_MapsSettingsCopyWithImpl(
      _$_MapsSettings _value, $Res Function(_$_MapsSettings) _then)
      : super(_value, (v) => _then(v as _$_MapsSettings));

  @override
  _$_MapsSettings get _value => super._value as _$_MapsSettings;

  @override
  $Res call({
    Object? mapTypePicked = freezed,
    Object? roadMap = freezed,
    Object? terrain = freezed,
    Object? satellite = freezed,
  }) {
    return _then(_$_MapsSettings(
      mapTypePicked: mapTypePicked == freezed
          ? _value._mapTypePicked
          : mapTypePicked // ignore: cast_nullable_to_non_nullable
              as Set<MapPicked>?,
      roadMap: roadMap == freezed
          ? _value.roadMap
          : roadMap // ignore: cast_nullable_to_non_nullable
              as bool?,
      terrain: terrain == freezed
          ? _value.terrain
          : terrain // ignore: cast_nullable_to_non_nullable
              as bool?,
      satellite: satellite == freezed
          ? _value.satellite
          : satellite // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MapsSettings extends _MapsSettings {
  _$_MapsSettings(
      {final Set<MapPicked>? mapTypePicked,
      this.roadMap,
      this.terrain,
      this.satellite})
      : _mapTypePicked = mapTypePicked,
        super._();

  factory _$_MapsSettings.fromJson(Map<String, dynamic> json) =>
      _$$_MapsSettingsFromJson(json);

  final Set<MapPicked>? _mapTypePicked;
  @override
  Set<MapPicked>? get mapTypePicked {
    final value = _mapTypePicked;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(value);
  }

  @override
  final bool? roadMap;
  @override
  final bool? terrain;
  @override
  final bool? satellite;

  @override
  String toString() {
    return 'MapsSettings(mapTypePicked: $mapTypePicked, roadMap: $roadMap, terrain: $terrain, satellite: $satellite)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MapsSettings &&
            const DeepCollectionEquality()
                .equals(other._mapTypePicked, _mapTypePicked) &&
            const DeepCollectionEquality().equals(other.roadMap, roadMap) &&
            const DeepCollectionEquality().equals(other.terrain, terrain) &&
            const DeepCollectionEquality().equals(other.satellite, satellite));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_mapTypePicked),
      const DeepCollectionEquality().hash(roadMap),
      const DeepCollectionEquality().hash(terrain),
      const DeepCollectionEquality().hash(satellite));

  @JsonKey(ignore: true)
  @override
  _$$_MapsSettingsCopyWith<_$_MapsSettings> get copyWith =>
      __$$_MapsSettingsCopyWithImpl<_$_MapsSettings>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MapsSettingsToJson(
      this,
    );
  }
}

abstract class _MapsSettings extends MapsSettings {
  factory _MapsSettings(
      {final Set<MapPicked>? mapTypePicked,
      final bool? roadMap,
      final bool? terrain,
      final bool? satellite}) = _$_MapsSettings;
  _MapsSettings._() : super._();

  factory _MapsSettings.fromJson(Map<String, dynamic> json) =
      _$_MapsSettings.fromJson;

  @override
  Set<MapPicked>? get mapTypePicked;
  @override
  bool? get roadMap;
  @override
  bool? get terrain;
  @override
  bool? get satellite;
  @override
  @JsonKey(ignore: true)
  _$$_MapsSettingsCopyWith<_$_MapsSettings> get copyWith =>
      throw _privateConstructorUsedError;
}
