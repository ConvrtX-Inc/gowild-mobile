// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_settings_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MapsSettings _$$_MapsSettingsFromJson(Map<String, dynamic> json) =>
    _$_MapsSettings(
      mapTypePicked: (json['mapTypePicked'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$MapPickedEnumMap, e))
          .toSet(),
      roadMap: json['roadMap'] as bool?,
      terrain: json['terrain'] as bool?,
      satellite: json['satellite'] as bool?,
      roadMapString: json['roadMapString'] as String?,
      terrainString: json['terrainString'] as String?,
      satelliteString: json['satelliteString'] as String?,
    );

Map<String, dynamic> _$$_MapsSettingsToJson(_$_MapsSettings instance) =>
    <String, dynamic>{
      'mapTypePicked':
          instance.mapTypePicked?.map((e) => _$MapPickedEnumMap[e]!).toList(),
      'roadMap': instance.roadMap,
      'terrain': instance.terrain,
      'satellite': instance.satellite,
      'roadMapString': instance.roadMapString,
      'terrainString': instance.terrainString,
      'satelliteString': instance.satelliteString,
    };

const _$MapPickedEnumMap = {
  MapPicked.roadMap: 'roadMap',
  MapPicked.terrain: 'terrain',
  MapPicked.satellite: 'satellite',
};
