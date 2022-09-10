import 'package:beamer/beamer.dart';
import 'package:easy_geofencing/easy_geofencing.dart';
import 'package:flutter/cupertino.dart' show CupertinoSwitch;
import 'package:flutter/material.dart' hide Route;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gowild/constants/colors.dart';
import 'package:gowild/helper/latlng_position.extensions.dart';
import 'package:gowild/helper/route.extention.dart';
import 'package:gowild/providers/current_location_provider.dart';
import 'package:gowild/providers/notification.dart';
import 'package:gowild/providers/route_provider.dart';
import 'package:gowild/services/logging.dart';
import 'package:gowild/ui/widgets/auth_widgets.dart';
import 'package:gowild/ui/widgets/custom_app_bar.dart';
import 'package:gowild_api/gowild_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    final position$ = useStream(Geolocator.getPositionStream());
    final notif = ref.read(notificationProvider);
    final currentLocation = ref.watch(currentLocationProvider);
    final cameraPosition = useState<CameraPosition>(CameraPosition(
      target: currentLocation,
      zoom: 12,
    ));
    final polyLines = useState<Set<Polyline>>({});
    final markers = useMemoized<Set<Marker>>(
        () => ({
              Marker(
                markerId: MarkerId('${route.id}-end-point'),
                position: route.toEnd(),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueViolet),
                infoWindow: InfoWindow(
                  title: 'End here',
                  snippet: route.routeName,
                ),
              ),
              Marker(
                markerId: MarkerId('${route.id}-start-point'),
                position: route.toStart(),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen),
                infoWindow: InfoWindow(
                  title: 'Start here',
                  snippet: route.routeName,
                ),
              ),
            }),
        []);

    final atFinishLine = useState(false);
    final controller = useState<GoogleMapController?>(null);
    final routeText = useState<String?>(null);

    useEffect(() {
      final ctr = controller.value;
      final pos = position$.data;
      if (ctr != null && pos != null) {
        ctr.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: pos.toLatLng(), zoom: 15),
          ),
        );
      }
      return () {};
    }, [position$, controller]);

    final onMapCreated = useCallback((GoogleMapController c) {
      controller.value = c;
    }, [controller]);

    final addMarker = useCallback(() {}, []);
    final showInAppNotification = useCallback(() {
      notif.showAndroidNotification('route-${route.id}'.hashCode, 'Go Wild Historiy',
          'You are not in the proxmity ot the starting point');
    }, []);

    final showResults = useCallback(() {
      addMarker();
    }, [currentLocation, addMarker]);

    final showStats = useCallback(() {
      addMarker();
      showInAppNotification();
    }, [addMarker]);

    useEffect(() {
      logger.d('CurrentLocation changed: $currentLocation');
      cameraPosition.value = CameraPosition(target: currentLocation, zoom: 12);
      return () {};
    }, [currentLocation]);

    final state = useState(false);

    useEffect(() {
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
                      const SizedBox(height: 10, width: 0),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: SizedBox(
                          height: 600,
                          width: double.infinity,
                          child: GoogleMap(
                            myLocationButtonEnabled: true,
                            zoomControlsEnabled: true,
                            zoomGesturesEnabled: true,
                            tiltGesturesEnabled: true,
                            initialCameraPosition: cameraPosition.value,
                            onMapCreated: onMapCreated,
                            markers: markers,
                            polylines: polyLines.value,
                            mapType: MapType.normal,
                            myLocationEnabled: true,
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
