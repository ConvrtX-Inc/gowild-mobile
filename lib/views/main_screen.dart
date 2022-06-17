
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gowild_mobile/constants/image_constants.dart';
import 'package:gowild_mobile/views/home.dart';
import 'package:gowild_mobile/views/profile/profile_screen.dart';
import 'package:gowild_mobile/views/profile/settings_screen.dart';
import 'package:gowild_mobile/widgets/bottom_flat_button.dart';
import 'package:flutter/material.dart';
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

  final List<Widget> _screens = [
    const HomeScreen(),
    Container(),
    Container(),

    /// Dont remove this
    Container(),
    const SettingsScreen()
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
      height: 95,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        child: BottomNavigationBar(
          onTap: _changeIndex,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedTabIndex,
          backgroundColor: const Color(0xff00755E),
          enableFeedback: false,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                homeIcon,
                // width: 25,
                // height: 19,
                color: _selectedTabIndex == 0
                    ? const Color(0xffE5592F)
                    : Colors.white,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(treasureMapIcon,
                  // width: 25,
                  // height: 19,
                  color: _selectedTabIndex == 1
                      ? const Color(0xffE5592F)
                      : Colors.white),
              label: '',
            ),
            const BottomNavigationBarItem(
              icon: SizedBox.shrink(),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(directionSignIcon,
                  // width: 25,
                  // height: 19,
                  color: _selectedTabIndex == 3
                      ? const Color(0xffE5592F)
                      : Colors.white),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(profileIcon,
                  // width: 25,
                  // height: 19,
                  color: _selectedTabIndex == 4
                      ? const Color(0xffE5592F)
                      : Colors.white),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
