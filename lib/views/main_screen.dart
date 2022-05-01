import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gowild_mobile/constants/image_constants.dart';
import 'package:gowild_mobile/views/home.dart';
import 'package:gowild_mobile/views/profile/profile_screen.dart';
import 'package:gowild_mobile/views/profile/settings_screen.dart';
import 'package:gowild_mobile/widgets/bottom_flat_button.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedTabIndex = 0;

  _changeIndex(int index) {
    setState(() {
      _selectedTabIndex = index;
      print("index..." + index.toString());
    });
  }

  final String homeIcon =
      '${ImageAssetPath.imagePathSvg}${ImageAssetName.home}';
  final String treasureMapIcon =
      '${ImageAssetPath.imagePathSvg}${ImageAssetName.treasureMap}';
  final String directionSignIcon =
      '${ImageAssetPath.imagePathSvg}${ImageAssetName.directionSign}';
  final String profileIcon =
      '${ImageAssetPath.imagePathSvg}${ImageAssetName.profile}';

  List<Widget> _screens = [
    HomeScreen(),
    Container(),
    Container(),

    /// Dont remove this
    Container(),
    SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _screens.length,
      child: Scaffold(
        body: IndexedStack(
          index: _selectedTabIndex,
          children: _screens,
        ),
        floatingActionButton: const BottomFlatButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: _bottomNavBar(),
      ),
    );
  }

  _bottomNavBar() {
    return Container(
      height: 85,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        child: BottomNavigationBar(
          onTap: _changeIndex,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedTabIndex,
          backgroundColor: Color(0xff00755E),
          enableFeedback: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                homeIcon,
                color:
                    _selectedTabIndex == 0 ? Color(0xffE5592F) : Colors.white,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(treasureMapIcon,
                  color: _selectedTabIndex == 1
                      ? Color(0xffE5592F)
                      : Colors.white),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SizedBox.shrink(),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(directionSignIcon,
                  color: _selectedTabIndex == 3
                      ? Color(0xffE5592F)
                      : Colors.white),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(profileIcon,
                  color: _selectedTabIndex == 4
                      ? Color(0xffE5592F)
                      : Colors.white),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}