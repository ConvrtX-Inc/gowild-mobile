import 'package:flutter/material.dart';
import 'package:gowild_mobile/constants/colors.dart';
import 'package:gowild_mobile/constants/size.dart';
import 'package:gowild_mobile/views/home.dart';

import '../../models/settings.dart';
import '../../services/prefs_service.dart';
import '../../widgets/bottom_flat_button.dart';
import '../../widgets/bottom_nav_bar.dart';

class MapOverlay extends StatefulWidget {
  const MapOverlay({Key? key}) : super(key: key);

  @override
  _MapOverlayState createState() => _MapOverlayState();
}

class _MapOverlayState extends State<MapOverlay> {
  bool setAsDefaultRoadMap = true;
  bool setAsDefaultSatellite = false;
  bool setAsDefaultTerrain = false;

  final _preferenceService = PrefService();

  // var _selectedMapType = Set<MapPicked>();
  @override
  void initState() {
    // TODO: implement initState
    getAllSavedData();
    super.initState();
  }

  Future getAllSavedData() async {
    final value = await _preferenceService.getMapType();
    setState(() {
      setAsDefaultRoadMap = value.roadMap!;
      setAsDefaultTerrain = value.terrain!;
      setAsDefaultSatellite = value.satellite!;
    });

    setState(() {});
  }

  void pickMap(MapPicked? type) async {
    switch (type) {
      case MapPicked.roadMap:
        setState(() {
          setAsDefaultTerrain = false;
          setAsDefaultSatellite = false;
          setAsDefaultRoadMap = true;
        });
        final newSettings = Settings(
          roadMap: setAsDefaultRoadMap,
          terrain: setAsDefaultTerrain,
          satellite: setAsDefaultSatellite,
          roadMapString: MapPicked.roadMap.toString(),
        );

        _preferenceService.setMapType(newSettings);

        break;
      case MapPicked.terrain:
        setState(() {
          setAsDefaultTerrain = true;
          setAsDefaultRoadMap = false;
          setAsDefaultSatellite = false;
        });
        final newSettings = Settings(
          roadMap: setAsDefaultRoadMap,
          terrain: setAsDefaultTerrain,
          satellite: setAsDefaultSatellite,
          terrainString: MapPicked.terrain.toString(),
        );

        _preferenceService.setMapType(newSettings);

        break;
      case MapPicked.satellite:
        setState(() {
          setAsDefaultTerrain = false;
          setAsDefaultRoadMap = false;
          setAsDefaultSatellite = true;
        });
        final newSettings = Settings(
          roadMap: setAsDefaultRoadMap,
          terrain: setAsDefaultTerrain,
          satellite: setAsDefaultSatellite,
          satelliteString: MapPicked.satellite.toString(),
        );

        _preferenceService.setMapType(newSettings);

        break;
      default:
    }
  }

  Padding buildContainer(String image, String text, String dafault,
          bool isPicked, MapPicked? type) =>
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: Container(
              height: 200,
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20), // Image border
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(70), // Image radius
                          child: Image.asset(image, fit: BoxFit.cover),
                        ),
                      ),
                      sizedBox(10, 20),
                      Container(
                        width: 180,
                        padding: const EdgeInsets.only(bottom: 2, left: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              text,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                            sizedBox(10, 0),
                            isPicked
                                ? Text(
                                    dafault,
                                    style: const TextStyle(
                                        color: Color(0xff09110E)),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      pickMap(type);
                                    },
                                    child: const Text(
                                      'Set as default',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: const StadiumBorder(),
                                      primary: kprimaryOrange,
                                    ),
                                  ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              )),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlack,
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: true,
      floatingActionButton: const BottomFlatButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomNavBar(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // iconTheme: const IconThemeData(color: primaryYellow, size: 28),
        leading: IconButton(
            onPressed: () {
              // Navigator.pop(context, false);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 29,
              color: kprimaryYellow,
            )),

        centerTitle: false,
        title: const Text(
          'Map Overlay',
          style: TextStyle(
              color: primaryYellow, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            sizedBox(60, 0),
            buildContainer('assets/satelite.png', 'Road Map', 'DEFAULT',
                setAsDefaultRoadMap, MapPicked.roadMap),
            sizedBox(30, 0),
            buildContainer('assets/roadmap.png', 'Terrain', 'DEFAULT',
                setAsDefaultTerrain, MapPicked.terrain),
            sizedBox(30, 0),
            buildContainer('assets/terrain.png', 'Satellite', 'DEFAULT',
                setAsDefaultSatellite, MapPicked.satellite)
          ],
        )),
      ),
    );
  }
}
