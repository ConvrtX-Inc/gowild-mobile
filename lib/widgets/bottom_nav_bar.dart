import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gowild_mobile/constants/image_constants.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        child: Flexible(
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
                  width: 18,
                  height: 10,
                  color:
                      _selectedTabIndex == 0 ? Color(0xffE5592F) : Colors.white,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(treasureMapIcon,
                    width: 18,
                    height: 10,
                    color: _selectedTabIndex == 1
                        ? Color(0xffE5592F)
                        : Colors.white),
                label: '',
              ),
              // BottomNavigationBarItem(

              //   icon: SizedBox.shrink(

              //   ),

              //   label: '',
              // ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(directionSignIcon,
                    width: 18,
                    height: 10,
                    color: _selectedTabIndex == 3
                        ? Color(0xffE5592F)
                        : Colors.white),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(profileIcon,
                    width: 18,
                    height: 10,
                    color: _selectedTabIndex == 4
                        ? Color(0xffE5592F)
                        : Colors.white),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
