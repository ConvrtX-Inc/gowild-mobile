import 'dart:ui';

import 'package:beamer/beamer.dart';
import 'package:easy_geofencing/easy_geofencing.dart';
import 'package:flutter/cupertino.dart' show CupertinoSwitch;
import 'package:flutter/material.dart' hide Route;
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gowild/constants/colors.dart';
import 'package:gowild/helper/latlng_position.extensions.dart';
import 'package:gowild/helper/logging.dart';
import 'package:gowild/helper/maps_utils.dart';
import 'package:gowild/helper/poly_lines.dart';
import 'package:gowild/helper/route.extention.dart';
import 'package:gowild/providers/current_location_provider.dart';
import 'package:gowild/providers/notification.dart';
import 'package:gowild/providers/route_provider.dart';
import 'package:gowild/ui/widgets/auth_widgets.dart';
import 'package:gowild/ui/widgets/custom_app_bar.dart';
import 'package:gowild_api/gowild_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

enum MarkerType { start, end, middle }

class TryRouteScreen extends HookConsumerWidget {
  final String routeId;

  const TryRouteScreen({
    super.key,
    required this.routeId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final findRoute = useMemoized(
        () => ref
            .read(routeApiProvider)
            .getOneBaseRouteControllerRoute(id: routeId),
        []);
    final routeResult$ = useFuture(findRoute);

    if (!routeResult$.hasData) {
      return const Scaffold(
        appBar: CustomAppBar(
          titleText: 'Loading',
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final route = routeResult$.data!.data!;
    return _TryRouteContentWidget(route: route);
  }
}

class _TryRouteContentWidget extends HookConsumerWidget {
  final Route route;

  const _TryRouteContentWidget({required this.route});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Basic State
    final atFinishLine = useState(false);
    final controller = useState<GoogleMapController?>(null);
    final routeText = useState<String?>(null);
    final state = useState(false);
    final started = useState(false);

    // Current location state
    final currentLocationRef = ref.watch(currentLocationProvider);
    final locationStream = useMemoized(
        () => Geolocator.getPositionStream().map((event) => event.toLatLng()),
        []);
    final currentLocation =
        useStream(locationStream, initialData: currentLocationRef);

    // Notification service
    final notif = ref.read(notificationProvider);

    // Fixed camera
    final initialCameraPosition = useMemoized(
      () => CameraPosition(
        target: route.toStart(),
        zoom: 17,
      ),
      [],
    );

    // Bound for camera
    final bounds = useMemoized(() => route.toBounds(), []);

    // Maps
    final onMapCreated = useCallback((GoogleMapController ctr) {
      controller.value = ctr;
      // TODO This causes an error
      ctr.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50.0));
      logger.d('Centered using bound ${bounds.toJson()}');
    }, [controller, bounds]);

    // Notifications
    final showInAppNotification = useCallback(() {
      notif.showAndroidNotification(
        'route-${route.id}'.hashCode,
        'Go Wild Historiy',
        'You are not in the proxmity ot the starting point',
      );
    }, [notif]);

    // Markers
    final markers = useState<Set<Marker>>({});
    void addMarker({
      required MarkerType type,
      required LatLng latLng,
      required String title,
    }) async {
      late Uint8List bytes;
      switch (type) {
        case MarkerType.start:
          bytes = await getBytesFromAsset(
            'assets/images/pngs/start_point_icon.png',
            128,
          );
          break;
        case MarkerType.end:
          bytes = await getBytesFromAsset(
            'assets/images/pngs/finish_point_icon.png',
            128,
          );
          break;
        case MarkerType.middle:
          bytes = await getBytesFromAsset(
            'assets/images/pngs/location_point.png',
            128,
          );
          break;
        default:
          logger.e('Cannot handle this type $type');
          return;
      }

      final marker = Marker(
        markerId:
        MarkerId('${route.id}-${latLng.toString()}-${const Uuid().v4()}'),
        position: latLng,
        icon: BitmapDescriptor.fromBytes(bytes),
        infoWindow: InfoWindow(
          title: title,
          snippet: route.routeName,
        ),
      );
      markers.value = {...markers.value, marker};
      logger.d('Marker added ${marker.markerId}');
    }
    final showResults = useCallback(() {
      final pos = currentLocation.data;
      if (pos != null) {
        addMarker(type: MarkerType.middle, latLng: pos, title: "You're here");
      }
    }, [currentLocation, addMarker]);
    final showStats = useCallback(() {
      final pos = currentLocation.data;
      if (pos != null) {
        addMarker(type: MarkerType.middle, latLng: pos, title: "You're here");
        showInAppNotification();
      }
    }, [addMarker]);

    // Poly lines
    final polyLinesFuture = useMemoized<Future<Set<Polyline>>>(() async {
      try {
        final points = await findPolyLines(route);
        final polyline = Polyline(
          polylineId: PolylineId('poly-line-${route.id}'),
          points: [route.toStart(), ...points, route.toEnd()],
          visible: true,
        );
        logger.d('Got poly lines for route ${points.length}');
        return {polyline};
      } catch (e) {
        logger.e('Could not find direction for route#${route.id}: $e');
        return {};
      }
    }, []);
    final polyLines$ =
        useFuture<Set<Polyline>>(polyLinesFuture, initialData: {});

    useEffect(() {
      if (started.value) {
        final ctr = controller.value;
        final pos = currentLocation.data;
        if (ctr != null && pos != null) {
          ctr.animateCamera(
            CameraUpdate.newLatLngZoom(pos, 17),
          );
        }
      }
      return () {};
    }, [currentLocation, controller, started]);

    useEffect(() {
      addMarker(
        type: MarkerType.end,
        title: 'Ending point',
        latLng: route.toEnd(),
      );
      addMarker(
        type: MarkerType.start,
        title: 'Starting point',
        latLng: route.toStart(),
      );
      return () {
        EasyGeofencing.stopGeofenceService();
      };
    }, []);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            context.popToNamed('/main');
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: primaryYellow,
          iconSize: 28,
        ),
        // iconTheme: const IconThemeData(color: primaryYellow, size: 28),
        centerTitle: false,
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.30,
            child: CupertinoSwitch(
              value: state.value,
              activeColor: kprimaryOrange,
              onChanged: (value) {
                state.value = value;
              },
            ),
          ),
        ],
        title: const Text(
          'TRY ROUTE',
          style: TextStyle(
              color: primaryYellow, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      routeText.value ?? '',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      height: 40,
                      width: 75,
                      padding: const EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xffEC6537),
                        border: Border.all(
                            color: const Color(0xffEC6537),
                            width: 1.0), // Set border width
                        borderRadius: const BorderRadius.all(
                            Radius.circular(10.0)), // Set rounded corner radius
                      ),
                      child: const Text(
                        " Details ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 20, width: 0),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * .64,
                          width: MediaQuery.of(context).size.width - 32,
                          child: GoogleMap(
                            myLocationButtonEnabled: true,
                            zoomControlsEnabled: true,
                            zoomGesturesEnabled: true,
                            tiltGesturesEnabled: true,
                            initialCameraPosition: initialCameraPosition,
                            onMapCreated: onMapCreated,
                            markers: markers.value,
                            polylines: polyLines$.requireData,
                            mapType: MapType.normal,
                            myLocationEnabled: true,
                            cameraTargetBounds: CameraTargetBounds(bounds),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20, width: 0),
              MainAuthButtonWidget(
                text: atFinishLine.value ? 'Show My Results' : 'Start',
                onTap: atFinishLine.value ? showResults : showStats,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
