import 'dart:async';

import 'package:easy_geofencing/enums/geofence_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofence/geofence.dart';
import 'package:gowild_mobile/constants/image_constants.dart';
import 'package:gowild_mobile/models/historical_event.dart';
import 'package:gowild_mobile/services/Geofencing.dart';
import 'package:gowild_mobile/services/geolocation_service.dart';
import 'package:gowild_mobile/utils/ui/historical_dialogs.dart';
import 'package:gowild_mobile/widgets/grass_themed_button.dart';
import 'package:geolocator/geolocator.dart';
import 'package:easy_geofencing/easy_geofencing.dart';

class HistoricalEvent extends StatefulWidget {
  const HistoricalEvent({Key? key}) : super(key: key);

  @override
  _HistoricalEventState createState() => _HistoricalEventState();
}

class _HistoricalEventState extends State<HistoricalEvent> {
  String currentLocation = '';
  List<HistoricalEventModel> historicalEvents = [
    HistoricalEventModel(
        id: '1',
        eventLat: 37.3050,
        eventLong: -121.8822,
        eventTitle: 'Did you know? 1',
        description: 'This is a Test Description 1'),
    HistoricalEventModel(
        id: '2',
        eventLat: 37.2875,
        eventLong: -121.8515,
        eventTitle: 'Did you know? 2',
        description: 'This is a Test Description 2'),
    HistoricalEventModel(
        id: '3',
        eventLat: 37.0810,
        eventLong: -121.9631,
        eventTitle: 'Did you know? 3',
        description: 'This is a Test Description 3')
  ];

  double radius = 500;
  double currentLat = 0;
  double currentLng = 0;

  StreamSubscription<GeofenceStatus>? geofenceStatusStream;
  String geofenceStatus = '';

  @override
  void initState() {
    listenToLocationUpdates();

    createGeoFences();

    initPlatformState();
  }

  listenToLocationUpdates() {
    StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
            desiredAccuracy: LocationAccuracy.high, distanceFilter: 100)
        .listen((Position? position) {
      if (position != null) {
        setState(() {
          currentLat = position.latitude;
          currentLng = position.longitude;
          currentLocation =
              '${position.latitude.toString()}, ${position.longitude.toString()}';
        });

        checkHistoricalEventsProximity();
      }
      print(position == null
          ? 'Unknown Location'
          : 'CURRENT LOCATION  ${position.latitude.toString()}, ${position.longitude.toString()}');
    });
  }

  checkHistoricalEventsProximity() {
    for (HistoricalEventModel event in historicalEvents) {
      double distanceInMeters = GeoLocationServices().calculateDistanceInMeters(
          currentLat, currentLng, event.eventLat!, event.eventLong!);
      debugPrint('Distance in meters:: $distanceInMeters');
      // if (distanceInMeters < radius) {
      //   HistoricalDialogs().showPlainText(context, event.description!);
      // }
    }
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;

    debugPrint('Listening///');
    debugPrint('Listening///');
    Geofence.initialize();
    Geofence.startListening(GeolocationEvent.entry, (entry) {
      HistoricalDialogs().showPlainText(context, 'content ${entry.id}');
    });

    Geofence.startListening(GeolocationEvent.exit, (entry) {
      debugPrint('Exit ${entry.id}');
    });
  }

  createGeoFences() {
    // for (HistoricalEventModel event in historicalEvents) {
    //   GeofencingServices()
    //       .addRegion('event.eventLat!', event.eventLong!, 7.5, event.id!);
    // }

    GeofencingServices()
        .addRegion(37.3050, -121.8822, 10, '12');


    /*   EasyGeofencing.startGeofenceService(
        pointedLatitude: '37.3050',
        pointedLongitude: '-121.8822',
        radiusMeter: '10',
        eventPeriodInSeconds: 5);

    EasyGeofencing.startGeofenceService(
        pointedLatitude: '37.3049917',
        pointedLongitude: '-121.8821867',
        radiusMeter: '10',
        eventPeriodInSeconds: 5);

    geofenceStatusStream ??=
        EasyGeofencing.getGeofenceStream()!.listen((GeofenceStatus status) {
      print('GEOFENCE STATUS: ${geofenceStatus}');
      setState(() {
        geofenceStatus = status.toString();
      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('CURRENT LOCATION: $currentLocation'),
          RaisedButton(
            child: Text("Request Permissions"),
            onPressed: () {
              Geofence.requestPermissions();
            },
          ),
          RaisedButton(
              child: Text("get user location"),
              onPressed: () {
                Geofence.getCurrentLocation().then((coordinate) {
                  print(
                      "great got latitude: ${coordinate?.latitude} and longitude: ${coordinate?.longitude}");
                });
              }),
          Center(
            child: ElevatedButton(
              onPressed: () => HistoricalDialogs().showPlainText(context,
                  'Lorem Ipsum Lorem IpsumLorem IpsumLorem IpsumLorem IpsumLorem Ipsum'),
              child: const Text('Show Historical Event',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
          ElevatedButton(
            onPressed: () => HistoricalDialogs().showWithImage(
                context,
                'https://www.roadaffair.com/wp-content/uploads/2017/12/taj-mahal-india-shutterstock_180918317-1024x683.jpg',
                'This is a test Image'),
            child: const Text('Show Historical Event Image',
                style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }
}
