import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gowild_mobile/constants/colors.dart';
import 'package:gowild_mobile/constants/map_types.dart';
import 'package:gowild_mobile/utils/getx/controllers/map_type_controller.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

/// Map Overlay Settings Screen
class MapOverlaySettingScreen extends StatefulWidget {
  ///Constructor
  const MapOverlaySettingScreen({Key? key}) : super(key: key);

  @override
  _MapOverlaySettingScreenState createState() =>
      _MapOverlaySettingScreenState();
}

class _MapOverlaySettingScreenState extends State<MapOverlaySettingScreen> {
  GoogleMapController? _mapController;
  // MapType currentMapType = MapType.normal;

  String currentMapStyle = MapboxStyles.OUTDOORS;

  final MapTypeController _mapTypeController = Get.put(MapTypeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlack,
      appBar: AppBar(
        backgroundColor: primaryBlack,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: primaryYellow,
          ),
        ),
        elevation: 0,
        title: const Text(
          'Map Overlay',
          style: TextStyle(
              color: primaryYellow, fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
      body: GetBuilder<MapTypeController>(
        builder: (controller){
          // currentMapType = controller.mapType;
          currentMapStyle = controller.mapStyle;
          return buildMapOverlayUI();
        },
      ),
    );
  }

  Widget buildMapOverlayUI() => Column(
        children: [
          buildOverlayItem(
              imageUrl: 'assets/roadmap.png',
              // mapType: MapType.normal,
              mapStyle : MapboxStyles.MAPBOX_STREETS,
              label: MapTypes().roadMap),
          buildOverlayItem(
              imageUrl: 'assets/satelite.png',
              // mapType: MapType.terrain,
              mapStyle : MapboxStyles.OUTDOORS,
              label: MapTypes().terrain),
          buildOverlayItem(
              imageUrl: 'assets/terrain.png',
              // mapType: MapType.satellite,
              mapStyle : MapboxStyles.SATELLITE,
              label: MapTypes().satellite)
        ],
      );

  Widget buildOverlayItem(
          {required String imageUrl,
          // required MapType mapType,
            required String mapStyle,
          required String label}) =>
      Container(
        margin: EdgeInsets.symmetric(horizontal: 26, vertical: 16),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.white),
        child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(imageUrl),
              ),
              const SizedBox(
                width: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    label,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 14),
                  currentMapStyle == mapStyle
                      ? const Text(
                          'Default',
                          style: TextStyle(color: Color(0xff09110E)),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            // pickMap(type);
                            // setDefaultMap(mapType);

                            setDefaultMap(mapStyle);
                          },
                          child: const Text(
                            'Set as default',
                            style: TextStyle(fontSize: 15),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            primary: kprimaryOrange,
                          ),
                        )
                ],
              )
            ]),
      );



 /* void setDefaultMap(MapType mapType) {
    setState(() {
      currentMapType = mapType;
    });
    _mapTypeController.setMapType(mapType);
  }*/

  void setDefaultMap(String mapStyle) {
    setState(() {
      currentMapStyle = mapStyle;
    });
    _mapTypeController.setMapStyle(currentMapStyle);
  }
}
