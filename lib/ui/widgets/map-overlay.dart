import 'dart:core';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gowild/constants/colors.dart';
import 'package:gowild/providers/map_settings_provider.dart';
import 'package:gowild/ui/screens/main/main.screen.dart';

class MapOverlayWidget extends HookWidget {
  const MapOverlayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final pickMap = useCallback((MapPicked? type) async {
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
    }, []);
    return Scaffold(
      backgroundColor: primaryBlack,
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: true,
      floatingActionButton: const BottomFlatButtonWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: const BottomNavBar(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // iconTheme: const IconThemeData(color: primaryYellow, size: 28),
        leading: IconButton(
          onPressed: () {
            context.popBeamLocation();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 29,
            color: kprimaryYellow,
          ),
        ),
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
            const SizedBox(height: 60, width: 0),
            _MapTypeWidget(
              image: 'assets/satelite.png',
              text: 'Road Map',
              dafault: 'DEFAULT',
              isPicked: setAsDefaultRoadMap,
              type: MapPicked.roadMap,
              pickThis: pickMap,
            ),
            const SizedBox(height: 30, width: 0),
            _MapTypeWidget(
              image: 'assets/roadmap.png',
              text: 'Terrain',
              dafault: 'DEFAULT',
              isPicked: setAsDefaultTerrain,
              type: MapPicked.terrain,
              pickThis: pickMap,
            ),
            const SizedBox(height: 30, width: 0),
            _MapTypeWidget(
              image: 'assets/terrain.png',
              text: 'Satellite',
              dafault: 'DEFAULT',
              isPicked: setAsDefaultSatellite,
              type: MapPicked.satellite,
              pickThis: pickMap,
            )
          ],
        )),
      ),
    );
  }
}

class _MapTypeWidget extends HookWidget {
  final String image;
  final String text;
  final String dafault;
  final bool isPicked;
  final MapPicked? type;
  final ValueChanged<MapPicked?> pickThis;

  const _MapTypeWidget({
    required this.image,
    required this.text,
    required this.dafault,
    required this.isPicked,
    required this.pickThis,
    this.type,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    const SizedBox(height: 10, width: 20),
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
                          const SizedBox(height: 10, width: 0),
                          isPicked
                              ? Text(
                                  dafault,
                                  style:
                                      const TextStyle(color: Color(0xff09110E)),
                                )
                              : ElevatedButton(
                                  onPressed: () => pickThis(type),
                                  style: ElevatedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                    primary: kprimaryOrange,
                                  ),
                                  child: const Text(
                                    'Set as default',
                                    style: TextStyle(fontSize: 15),
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
  }
}
