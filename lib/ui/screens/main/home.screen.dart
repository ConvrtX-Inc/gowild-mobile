import 'dart:math' as math;

import 'package:beamer/beamer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:gowild/constants/image_constants.dart';
import 'package:gowild/helper/logging.dart';
import 'package:gowild/helper/maps_utils.dart';
import 'package:gowild/helper/poly_lines.dart';
import 'package:gowild/helper/route.extention.dart';
import 'package:gowild/providers/current_location_provider.dart';
import 'package:gowild/providers/current_user.dart';
import 'package:gowild/providers/route_provider.dart';
import 'package:gowild/ui/widgets/sample_avatar.dart';
import 'package:gowild/ui/widgets/star_rating.dart';
import 'package:gowild_api/gowild_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:uuid/uuid.dart';

const nameList = ['ROUTES'];

const profileImagePlaceholder =
    '${ImageAssetPath.imagePathPng}${ImageAssetName.profilePlaceHolder}';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/home_bcg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            physics: const NeverScrollableScrollPhysics(),
            children: [
              const Text(
                'GOOD AFTERNOON,',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              const RowNameAndAvatarWidget(),
              const SizedBox(
                height: 24,
              ),
              const SearchTextFieldWidget(),
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: const [
                  ExpandableListViewWidget(
                    title: 'ROUTES',
                    child: RoutesWidget(),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoutesWidget extends HookConsumerWidget {
  const RoutesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(24.0),
        ),
      ),
      child: const SlidingPanelWidget(),
    );
  }
}

class SearchTextFieldWidget extends HookConsumerWidget {
  const SearchTextFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xff3B352F),
        hintText: 'Search for trail or activity',
        hintStyle: const TextStyle(
          color: Colors.white30,
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.white,
          size: 34,
        ),
        contentPadding: const EdgeInsets.all(16.0),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xff3B352F),
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xff3B352F),
          ),
          borderRadius: BorderRadius.circular(25.7),
        ),
      ),
    );
  }
}

class RowNameAndAvatarWidget extends HookConsumerWidget {
  const RowNameAndAvatarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final user = ref.watch(currentUserProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          user?.firstName ?? user?.lastName ?? user?.username ?? '',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        Container(
          width: 64,
          height: 64,
          decoration: const BoxDecoration(
            color: Colors.white, // border color
            shape: BoxShape.circle,
          ),
          child: GestureDetector(
            onTap: () {
              Beamer.of(context).beamToNamed('/main/general-profile');
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.amber,
                image: user?.picture != null
                    ? DecorationImage(
                        image: NetworkImage(user!.picture!),
                        fit: BoxFit.cover,
                      )
                    : const DecorationImage(
                        image: AssetImage(profileImagePlaceholder),
                      ),
              ),
              child: Container(), // inner content
            ),
          ),
        ),
      ],
    );
  }
}

class AdventureCardWidget extends HookWidget {
  const AdventureCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final rating = useState(3.0);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Container(
              height: 100,
              width: 300,
              // padding: const EdgeInsets.all(20),
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
                  Container(
                    height: 200,
                    width: 300,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYXY4S9RadUIoLeALlV19A3ov3f9FDj7sfDw&usqp=CAU'),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: Text('THRILL SEEKERS ATTRACTIONS IN HOUSTON',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff18243C),
                            )),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StarRating(
                              rating: rating.value,
                              color: const Color(0xffF6B100),
                              onRatingChanged: (r) => rating.value = r,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  'Visit',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Container(
                                  width: 30,
                                  decoration: const BoxDecoration(
                                    color: Color(0xff55755D),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2)),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '75k',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: Text('100,000 miles',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600)),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: Text(
                          'Bacon ipsum dolor amet turducken chicken meatball, kielbasa fatback ham ball tip corned beef hamburger drumstick pork belly alcatra meatloaf.',
                          style: TextStyle(
                              color: Color(0xff18243C),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                top: 10, left: 20, right: 20),
                            height: 90,
                            width: 250,
                            child: ListView.separated(
                              itemCount: 4,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  width: 10,
                                );
                              },
                              itemBuilder: (_, i) => const SampleAvatar(),
                              scrollDirection: Axis.horizontal,
                              physics: const NeverScrollableScrollPhysics(),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExpandableListViewWidget extends HookWidget {
  final String title;
  final Widget child;

  const ExpandableListViewWidget({
    required this.title,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final expandFlag = useState(false);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                IconButton(
                  icon: Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        expandFlag.value
                            ? Icons.keyboard_arrow_right
                            : Icons.keyboard_arrow_down,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  ),
                  onPressed: () {
                    expandFlag.value = !expandFlag.value;
                  },
                ),
              ],
            ),
          ),
          ExpandableContainer(
            expanded: expandFlag.value,
            expandedHeight: MediaQuery.of(context).size.height * .6,
            child: child,
          )
        ],
      ),
    );
  }
}

class SlidingPanelWidget extends HookWidget {
  const SlidingPanelWidget({super.key});

  Widget _floatingCollapsed() {
    return Container(
      margin: const EdgeInsets.only(right: 48),
      decoration: const BoxDecoration(
        // color: Colors.blueGrey,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24.0),
        ),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          Icon(Icons.arrow_upward_rounded),
          Text('Suggested Routes'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(24.0),
      child: SlidingUpPanel(
        minHeight: MediaQuery.of(context).size.height * 0.05,
        maxHeight: MediaQuery.of(context).size.height * 2,
        panel: const PanelWidget(),
        collapsed: _floatingCollapsed(),
        body: SizedBox(
          height: size.height * .64,
          child: const MyGoogleMap(),
        ),
        backdropEnabled: true,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        parallaxEnabled: true,
        parallaxOffset: .5,
        color: Colors.white,
      ),
    );
  }
}

class ExpandableContainer extends StatelessWidget {
  final bool expanded;
  final double collapsedHeight;
  final double expandedHeight;
  final Widget child;

  const ExpandableContainer({
    Key? key,
    required this.child,
    this.collapsedHeight = 0.0,
    this.expandedHeight = 620,
    this.expanded = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: screenWidth,
      height: expanded ? collapsedHeight : expandedHeight,
      child: Container(
        child: child,
      ),
    );
  }
}

class MyGoogleMap extends HookConsumerWidget {
  const MyGoogleMap({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final routeApi = ref.watch(routeApiProvider);
    final currentLocation = ref.watch(currentLocationProvider);

    final cameraPosition = useState<CameraPosition>(
        CameraPosition(target: currentLocation, zoom: 12));

    // Maps controllers
    final controller = useState<GoogleMapController?>(null);
    final onMapCreated = useCallback((GoogleMapController c) {
      controller.value = c;
    }, [controller]);
    final zoomIn = useCallback(() {
      final ct = controller.value;
      if (ct != null) {
        ct.moveCamera(CameraUpdate.zoomIn());
      }
    }, [controller]);
    final zoomMinus = useCallback(() {
      final ct = controller.value;
      if (ct != null) {
        ct.moveCamera(CameraUpdate.zoomOut());
      }
    }, [controller]);

    useEffect(() {
      logger.d(
          'currentLocation changed: $currentLocation # ${controller.value != null}');
      if (controller.value != null) {
        controller.value!
            .animateCamera(CameraUpdate.newLatLng(currentLocation));
      }
      return () {};
    }, [currentLocation, controller]);

    // Get routes
    final findRoutes = useMemoized(
        () => routeApi
            .getManyBaseRouteControllerRoute()
            .then((value) => value.data),
        []);
    final routes$ = useFuture(findRoutes);

    final polyLinesMap = useState<Map<PolylineId, Polyline>>({});
    final markersMap = useState<Map<MarkerId, Marker>>({});

    // Plot route
    void findDirection(Route route) async {
      try {
        final points = await findPolyLines(route);
        final id = PolylineId('poly-line-${route.id}');
        final polyline = Polyline(
          polylineId: id,
          points: [route.start!.toPoint(), ...points, route.end!.toPoint()],
          color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
              .withOpacity(1.0),
        );
        polyLinesMap.value = {...polyLinesMap.value, id: polyline};
      } catch (e) {
        logger.e('Could not find direction for route#${route.id}: $e');
      }
    }

    void addMarker(Route route) async {
      final bytes = await getBytesFromAsset(
        'assets/images/pngs/location_point.png',
        128,
      );
      final startPoint = Marker(
        markerId: MarkerId(
            '${route.id}-${route.start!.toPoint().toString()}-${const Uuid().v4()}'),
        position: route.start!.toPoint(),
        icon: BitmapDescriptor.fromBytes(bytes),
        infoWindow: InfoWindow(
          title: route.title,
        ),
      );
      final endPoint = Marker(
        markerId: MarkerId(
            '${route.id}-${route.end!.toPoint().toString()}-${const Uuid().v4()}'),
        position: route.end!.toPoint(),
        icon: BitmapDescriptor.fromBytes(bytes),
        infoWindow: InfoWindow(
          title: route.title,
        ),
      );
      markersMap.value = {
        ...markersMap.value,
        endPoint.markerId: endPoint,
        startPoint.markerId: startPoint,
      };
    }

    void plotRoute(Route route) {
      findDirection(route);
      addMarker(route);
    }

    useEffect(() {
      if (routes$.hasData) {
        logger.d('now has data');
        final resultData = routes$.data!;
        if (resultData.data.isEmpty) {
          return null;
        }

        resultData.data.forEach(plotRoute);
      } else {
        logger.d('has no data');
      }
      return null;
    }, [routes$.hasData]);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          GoogleMap(
            myLocationButtonEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            tiltGesturesEnabled: false,
            initialCameraPosition: cameraPosition.value,
            onMapCreated: onMapCreated,
            markers: markersMap.value.values.toSet(),
            polylines: polyLinesMap.value.values.toSet(),
            mapType: MapType.normal,
            myLocationEnabled: true,
            // https://stackoverflow.com/questions/60054311/googlemap-and-listview-on-the-same-sreen
            gestureRecognizers: {}..add(Factory<EagerGestureRecognizer>(
                () => EagerGestureRecognizer())),
          ),
          const MapOverlayButtonWidget(),
          Positioned(
            top: 100,
            right: 45,
            child: InkWell(
              onTap: zoomIn,
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                    shape: BoxShape.rectangle, color: Color(0xffC4C4C4)),
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Positioned(
            top: 150,
            right: 45,
            child: InkWell(
              onTap: zoomMinus,
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                    shape: BoxShape.rectangle, color: Color(0xffC4C4C4)),
                child: const Icon(
                  Icons.remove,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MapOverlayButtonWidget extends HookWidget {
  const MapOverlayButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      right: 40,
      child: Container(
        width: 40,
        height: 40,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: IconButton(
          icon: const Icon(
            Icons.map,
            color: Colors.black,
          ),
          onPressed: () {
            context.beamToNamed('/main/map-overlay');
          },
        ),
      ),
    );
  }
}

class PanelWidget extends HookConsumerWidget {
  const PanelWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeApi = ref.watch(routeApiProvider);
    final findRoutes = useMemoized(
      () => routeApi
          .getManyBaseRouteControllerRoute()
          .then((value) => value.data),
      [],
    );
    final routes$ = useFuture(findRoutes);
    final data = routes$.data?.data.toList() ?? [];

    return SingleChildScrollView(
      padding: const EdgeInsets.only(right: 56, left: 8),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 64),
          if (!routes$.hasData)
            const Center(
              child: CircularProgressIndicator(),
            ),
          for (final route in data) FoundRouteRow(route: route),
        ],
      ),
    );
  }
}

class FoundRouteRow extends HookWidget {
  final Route route;

  const FoundRouteRow({
    super.key,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.beamToNamed(
          '/main/try-routes/${route.id}',
          popToNamed: '/main',
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(12.0),
          ),
          border: Border.all(
            color: const Color(0xffDFDFDF),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
              height: 90,
              child: SmallMapWidget(
                route: route,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    route.title ?? '',
                    style: const TextStyle(
                      color: Color(0xff18243C),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.grey,
                      ),
                      const Text(
                        '1.7 Miles',
                        style: TextStyle(
                            color: Color(0xff18243C),
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.timer,
                            color: Colors.grey,
                          ),
                          Text(
                            '1 hr 30 mins',
                            style: TextStyle(
                              color: Color(0xff18243C),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 0, width: 8),
                      Row(
                        children: const [
                          Text(
                            '500m',
                            style: TextStyle(
                                color: Color(0xff18243C),
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SmallMapWidget extends HookWidget {
  final Route route;

  const SmallMapWidget({
    required this.route,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withAlpha(50),
        ),
        child: route.picture != null
            ? Image.network(route.picture!.path)
            : Container(),
      ),
    );
  }
}
