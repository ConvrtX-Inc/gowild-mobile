import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:gowild/constants/image_constants.dart';
import 'package:gowild/helper/location.dart';
import 'package:gowild/helper/route_extention.dart';
import 'package:gowild/providers/current_user.dart';
import 'package:gowild/providers/route_provider.dart';
import 'package:gowild/services/logging.dart';
import 'package:gowild/ui/widgets/sample_avatar.dart';
import 'package:gowild/ui/widgets/star_rating.dart';
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
                      const RowNameAndAvatarWidget(),
                      const SizedBox(
                        height: 20,
                      ),
                      // buildSearchTextField(),
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
                Beamer.of(context).beamToNamed('/main/profile');
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

class AdventureCard extends HookWidget {
  const AdventureCard({super.key});

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
              child: MapWidget(
                child: SlidingPanelWidget(),
              ),
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
      child: SizedBox(
        // width: 418,
        child: SlidingUpPanel(
          minHeight: 80,
          isDraggable: false,
          panelBuilder: (sc) => Container(),
          collapsed: Container(
            // padding: EdgeInsets.all(14),
            decoration: const BoxDecoration(color: Colors.white),
            child: GestureDetector(
              onTap: () {},
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.keyboard_arrow_up),
                      SizedBox(
                        width: 30,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Suggested Routes',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        width: 12,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          body: const SizedBox(
            width: 200,
            child: MyGoogleMap(),
          ),
          maxHeight: MediaQuery.of(context).size.height / 3,
          backdropEnabled: true,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
          parallaxEnabled: false,
          parallaxOffset: 0.0,
          color: Colors.white,
        ),
      ),
    );
  }
}

class MapWidget extends HookWidget {
  final Widget child;

  const MapWidget({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        // height: MediaQuery.of(context).size.height / 2,

        width: 420,
        decoration: const BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        child: child,
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
    final controller = useState<GoogleMapController?>(null);
    final onMapCreated = useCallback((GoogleMapController c) {
      controller.value = c;
    }, [controller]);

    final zoomAdd = useCallback(() {}, []);
    final zoomMinus = useCallback(() {}, []);

    final routeApi = ref.watch(routeApiProvider);
    final findRoutes = useMemoized(
        () => routeApi
            .getManyBaseRouteControllerRoute()
            .then((value) => value.data),
        []);
    final routes$ = useFuture(findRoutes);
    final start = useState<LatLng?>(null);
    final end = useState<LatLng?>(null);

    useEffect(() {
      if (routes$.hasData) {
        logger.d('has route data');
        final resultData = routes$.data!;
        final data = resultData.data.first;

        start.value = data.toStart();
        end.value = data.toStop();

        final polylinePoints = PolylinePoints();
        polylinePoints
            .getRouteBetweenCoordinates(
          'AIzaSyCgUycdQ8C8cnGaYTPymLvIzidBENWVicU',
          start.value.toPoint()!,
          end.value.toPoint()!,
        )
            .then((result) {
          logger.d('poins: ${result.points}');
        });
      } else {
        logger.d('has no data');
      }
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
                GoogleMapsWidget(
                  sourceLatLng: start.value!,
                  destinationLatLng: end.value!,
                  tiltGesturesEnabled: true,
                  compassEnabled: true,
                  zoomGesturesEnabled: true,
                  myLocationEnabled: true,
                  mapType: MapType.hybrid,
                  onMapCreated: onMapCreated,
                  apiKey: '',
                ),
                const _MapOverlayButtonWidget(),
                Positioned(
                  top: 100,
                  right: 45,
                  child: InkWell(
                    onTap: () => zoomAdd(),
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
                    onTap: () => zoomMinus(),
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
