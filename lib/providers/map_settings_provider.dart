import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gowild/providers/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'map_settings_provider.freezed.dart';
part 'map_settings_provider.g.dart';

const kMapSettings = 'map_settings';

enum MapPicked { roadMap, terrain, satellite }

@freezed
class MapsSettings with _$MapsSettings {
  MapsSettings._();

  factory MapsSettings({
    Set<MapPicked>? mapTypePicked,
    bool? roadMap,
    bool? terrain,
    bool? satellite,
  }) = _MapsSettings;

  factory MapsSettings.fromJson(Map<String, Object?> json) =>
      _$MapsSettingsFromJson(json);
}

final mapSettingsProvider =
    StateNotifierProvider<MapsSettingsProvider, MapsSettings>((ref) {
      final hive = ref.read(hiveProvider(kMapSettings));
  return MapsSettingsProvider(hive);
});

class MapsSettingsProvider extends StateNotifier<MapsSettings> {
  final HiveProvider<String> hiveProvider;

  MapsSettingsProvider(this.hiveProvider): super(MapsSettings());

  Future<void> init() async {
    await hiveProvider.init(kMapSettings);
    _load();
  }

  MapsSettings setRoadMap() {
    state = state.copyWith(roadMap: true, satellite: false, terrain: false);
    _save();
    return state;
  }

  MapsSettings setSatellite() {
    state = state.copyWith(roadMap: false, satellite: true, terrain: false);
    _save();
    return state;
  }

  MapsSettings setTerrain() {
    state = state.copyWith(roadMap: false, satellite: false, terrain: true);
    _save();
    return state;
  }

  void _save() async {
    hiveProvider.setValue('all_map_setting', jsonEncode(state.toJson()));
  }

  void _load() async {
    final got = hiveProvider.value('all_map_setting');
    if (got != null) {
      state = MapsSettings.fromJson(jsonDecode(got));
    }
  }
}
