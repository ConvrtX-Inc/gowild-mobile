enum MapPicked { roadMap, terrain, satellite }

class Settings {
  final Set<MapPicked>? mapTypePicked;
  final bool? roadMap;
  final bool? terrain;
  final bool? satellite;
  final String? roadMapString;
  final String? terrainString;
  final String? satelliteString;
  Settings(
      {this.mapTypePicked,
        this.roadMap,
        this.satellite,
        this.terrain,
        this.roadMapString,
        this.satelliteString,
        this.terrainString});
}
