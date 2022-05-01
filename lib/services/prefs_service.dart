import 'package:gowild_mobile/models/settings.dart';
import 'package:gowild_mobile/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  Future saveUser(UserModel userModel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', userModel.email!);
    // await prefs.setString('uid', userModel.uid!);
    await prefs.setString('phoneNumber', userModel.phoneNumber!);
    await prefs.setString('password', userModel.password!);
    await prefs.setString('fullName', userModel.fullName!);

    print('saved user');
  }

  Future setMapType(Settings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('setRoadMap', settings.roadMap!);
    await prefs.setBool('setTerrain', settings.terrain!);
    await prefs.setBool('setSatellite', settings.satellite!);
    await prefs.setString('roadMapString', settings.roadMapString ?? '');
    await prefs.setString('terrainString', settings.terrainString ?? '');
    await prefs.setString('satelliteString', settings.satelliteString ?? '');
    // await prefs.setStringList('mapPicked',
    //     settings.mapTypePicked!.map((type) => type.index.toString()).toList());
    print('save setting');
  }

  Future<Settings> getMapType() async {
    final prefs = await SharedPreferences.getInstance();
    // final mapPicked = prefs.getStringList('mapPicked');
    // final picked =
    //     mapPicked!.map(((index) => MapPicked.values[int.parse(index)])).toSet();
    // print(picked);
    // prefs.reload();
    final roadMap = prefs.getBool('setRoadMap');
    final terrain = prefs.getBool('setTerrain');
    final satellite = prefs.getBool('setSatellite');
    final roadString = prefs.getString('roadMapString');
    final terrainString = prefs.getString('terrainString');
    final satelliteString = prefs.getString('satelliteString');
    return Settings(
        roadMap: roadMap,
        terrain: terrain,
        satellite: satellite,
        roadMapString: roadString,
        terrainString: terrainString,
        satelliteString: satelliteString);
  }

  Future<UserModel> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final fullName = prefs.getString('fullName');
    final password = prefs.getString('password');
    final phoneNumber = prefs.getString('phoneNumber');
    final isLoggedIn = prefs.getBool('isLoggedin');
    return UserModel(
        email: email,
        fullName: fullName,
        isLoggedIn: isLoggedIn,
        password: password,
        phoneNumber: phoneNumber);
  }
}
