import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:gowild/constants/image_constants.dart';
import 'package:gowild/helper/location.dart';
import 'package:gowild/helper/route.extention.dart';
import 'package:gowild/providers/current_location_provider.dart';
import 'package:gowild/providers/current_user.dart';
import 'package:gowild/providers/route_provider.dart';
import 'package:gowild/services/logging.dart';
import 'package:gowild/ui/widgets/sample_avatar.dart';
import 'package:gowild/ui/widgets/star_rating.dart';
import 'package:gowild_api/gowild_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

const nameList = ['ROUTES'];

const profileImagePlaceholder =
    '${ImageAssetPath.imagePathPng}${ImageAssetName.profilePlaceHolder}';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      determinePosition();
    }, []);

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/home_bcg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            'GOOD AFTERNOON,',
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                        ],
                      ),
                      const _RowNameAndAvatarWidget(),
                      const SizedBox(
                        height: 20,
                      ),
                      const _SearchTextFieldWidget(),
                      const SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return ExpandableListViewWidget(
                            title: nameList[index],
                          );
                        },
                        itemCount: nameList.length,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class _SearchTextFieldWidget extends HookConsumerWidget {
  const _SearchTextFieldWidget({
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
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 20.0, top: 20.0),
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

class _RowNameAndAvatarWidget extends HookConsumerWidget {
  const _RowNameAndAvatarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final user = ref.watch(currentUserProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          user?.username ?? '',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        Container(
          width: 70,
          height: 70,
          decoration: const BoxDecoration(
            color: Colors.white, // border color
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(2), // border width
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
        ),
      ],
    );
  }
}

class _AdventureCardWidget extends HookWidget {
  const _AdventureCardWidget({super.key});

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
              height: 550,
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
                                fontWeight: FontWeight.w500)),
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

  const ExpandableListViewWidget({required this.title, super.key});

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
                      fontSize: 14),
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
                    }),
              ],
            ),
          ),
          ExpandableContainer(
            expanded: expandFlag.value,
            expandedHeight: MediaQuery.of(context).size.height / 1.65,
            child: const SizedBox(
              child: MapWidget(),
            ),
          )
        ],
      ),
    );
  }
}

class SlidingPanelWidget extends HookWidget {
  const SlidingPanelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        // width: 200,
        child: SlidingUpPanel(
          minHeight: MediaQuery.of(context).size.height * 0.05,
          panelBuilder: (sc) => PanelWidget(
            scrollController: sc,
          ),
          body: Container(
            height: 550,
            // width: 200,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            child: const SizedBox(
              // width: 200,
              child: MyGoogleMap(),
            ),
          ),
          maxHeight: MediaQuery.of(context).size.height / 2,
          backdropEnabled: true,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
          parallaxEnabled: true,
          parallaxOffset: .5,
          color: Colors.white,
        ),
      ),
    );
  }
}

class MapWidget extends HookWidget {
  const MapWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Container(
              height: 650,
              width: size.width - 64,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
              child: const SlidingPanelWidget(),
            ),
          ),
        ],
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
    final currentLocation = ref.read(currentLocationProvider);

    final zoomLevel = useState(10.0);
    final cameraPosition = useState<CameraPosition>(CameraPosition(
      target: currentLocation,
      zoom: zoomLevel.value,
    ));

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

    final findRoutes = useMemoized(
        () => routeApi
            .getManyBaseRouteControllerRoute()
            .then((value) => value.data),
        []);

    final routes$ = useFuture(findRoutes);

    final polyLines = useState<Set<Polyline>>({});
    final markers = useState<Set<Marker>>({});

    useEffect(() {
      if (routes$.hasData) {
        logger.d('now has data');
        final resultData = routes$.data!;
        if (resultData.data.isEmpty) {
          return null;
        }

        for (final route in resultData.data) {
          final start = route.toStart();
          final end = route.toStop();

          final polylinePoints = PolylinePoints();
          polylinePoints
              .getRouteBetweenCoordinates(
            'AIzaSyCgUycdQ8C8cnGaYTPymLvIzidBENWVicU',
            start.toPoint(),
            end.toPoint(),
          )
              .then((value) {
            // polylines.value = polylines.value..add(value.points)
            logger.i('Coords: $value');
          });
        }
      } else {
        logger.d('has no data');
      }
      return null;
    }, [routes$.hasData]);

    if (!routes$.hasData) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Flexible(
            child: Stack(
              children: [
                GoogleMap(
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: true,
                  zoomGesturesEnabled: true,
                  tiltGesturesEnabled: false,
                  initialCameraPosition: cameraPosition.value,
                  onMapCreated: onMapCreated,
                  markers: markers.value,
                  polylines: polyLines.value,
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                ),
                const _MapOverlayButtonWidget(),
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
          ),
        ],
      ),
    );
  }
}

class _MapOverlayButtonWidget extends HookWidget {
  const _MapOverlayButtonWidget({super.key});

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
  final ScrollController scrollController;

  const PanelWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeApi = ref.watch(routeApiProvider);
    final findRoutes = useMemoized(
        () => routeApi
            .getManyBaseRouteControllerRoute()
            .then((value) => value.data),
        []);
    final routes$ = useFuture(findRoutes);

    if (!routes$.hasData) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final resultData = routes$.data!;
    final data = resultData.data;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Icon(Icons.arrow_upward_rounded),
              Text('Suggested Routes'),
            ],
          ),
          ListView.builder(
            itemCount: data.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final route = data[index];
              return GestureDetector(
                onTap: () {
                  context.beamToNamed('/main/try-routes/${route.id}');
                },
                child:
                    FoundRouteRow(isFirstContainer: index == 0, route: route),
              );
            },
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            controller: scrollController,
          ),
        ],
      ),
    );
  }
}

class FoundRouteRow extends HookWidget {
  final Route route;
  final bool isFirstContainer;

  const FoundRouteRow({
    super.key,
    required this.route,
    this.isFirstContainer = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: isFirstContainer ? 50 : 65),
      // padding: const EdgeInsets.only(left: 10, right: 30),
      width: isFirstContainer ? 190 : 300,
      // height: isFirstContainer ? 300 : 10,
      decoration: BoxDecoration(
        color: isFirstContainer ? Colors.orange : Colors.transparent,
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0),
        ),
        border: Border.all(
          color: const Color(0xffDFDFDF),
          width: 1,
        ),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        const SizedBox(
          height: 5,
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          height: 90,
          child: _SmallMapWidget(
            height: isFirstContainer ? 320 : 90,
            route: route,
          ),
        ),
        _RouteContainer(route: route),
      ]),
    );
  }
}

class _SmallMapWidget extends HookWidget {
  final double height;
  final Route route;

  const _SmallMapWidget({
    required this.height,
    required this.route,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Image.network(route.imgUrl),
    );
  }
}

class _RouteContainer extends HookWidget {
  final Route route;

  const _RouteContainer({
    required this.route,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 120),
            child: Text(route.routeName,
                style: const TextStyle(
                    color: Color(0xff18243C),
                    fontSize: 14,
                    fontWeight: FontWeight.w500)),
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
              const Text('1.7 Miles',
                  style: TextStyle(
                      color: Color(0xff18243C),
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
              const SizedBox(
                width: 10,
              ),
              Row(
                children: const [
                  Icon(
                    Icons.timer,
                    color: Colors.grey,
                  ),
                  Text('1 hr 30 mins',
                      style: TextStyle(
                          color: Color(0xff18243C),
                          fontSize: 14,
                          fontWeight: FontWeight.w500))
                ],
              ),
              const SizedBox(height: 0, width: 8),
              Row(
                children: const [
                  Text('500m',
                      style: TextStyle(
                          color: Color(0xff18243C),
                          fontSize: 14,
                          fontWeight: FontWeight.w500))
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
