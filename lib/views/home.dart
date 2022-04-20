import 'package:draggable_widget/draggable_widget.dart';
import 'package:flutter/material.dart';

import 'package:gowild_mobile/constants/colors.dart';
import 'package:gowild_mobile/widgets/bottom_flat_button.dart';
import 'package:gowild_mobile/widgets/bottom_nav_bar.dart';

import '../widgets/expandable_listview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List nameList = ['ROUTES', 'NEARBY ADVENTURES', 'GO WILD FEED'];
  final dragController = DragController();
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
        extendBody: true,
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        floatingActionButton: const BottomFlatButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const BottomNavBar(),
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
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              'GOOD AFTERNOON,',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'JENNYLYN',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                            Container(
                              width: 70,
                              height: 70,
                              decoration: const BoxDecoration(
                                color: Colors.white, // border color
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.all(2), // border width
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.amber,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTo2pMgqzy7f2CLXEVRNian-4UiqfJKfmPK3w&usqp=CAU'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  child: Container(), // inner content
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          onChanged: (value) {
                            // Method For Searching
                          },
                          controller: _searchController,
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
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 20.0, top: 20.0),
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
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return ExpandableListView(title: nameList[index]);
                          },
                          itemCount: nameList.length,
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          DraggableWidget(
            bottomMargin: 80,
            topMargin: 80,
            intialVisibility: true,
            horizontalSpace: 20,
            shadowBorderRadius: 50,
            child: Container(
              height: 64,
              width: 64,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: const Icon(
                Icons.border_color_sharp,
                color: Colors.white,
              ),
            ),
            initialPosition: AnchoringPosition.topRight,
            dragController: dragController,
          ),
        ]),
      ),
    );
  }
}
