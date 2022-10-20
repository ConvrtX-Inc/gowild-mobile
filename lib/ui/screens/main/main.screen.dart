import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gowild/constants/image_constants.dart';
import 'package:gowild/ui/screens/main/home.screen.dart';
import 'package:gowild/ui/screens/profile/settings.screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final List<Widget> _screens = [
  const HomeScreen(),
  Container(),
  Container(),
  Container(),
  const SettingsScreen()
];
const String homeIcon = '${ImageAssetPath.imagePathSvg}${ImageAssetName.home}';
const String treasureMapIcon =
    '${ImageAssetPath.imagePathSvg}${ImageAssetName.treasureMap}';
const String directionSignIcon =
    '${ImageAssetPath.imagePathSvg}${ImageAssetName.directionSign}';
const String profileIcon =
    '${ImageAssetPath.imagePathSvg}${ImageAssetName.profile}';
const cameraFlat = '${ImageAssetPath.imagePathSvg}${ImageAssetName.cameraFlat}';

class MainScreen extends HookConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTabIndex = useState(0);
    final onIdxChanged = useCallback((int idx) {
      selectedTabIndex.value = idx;
    }, []);

    return DefaultTabController(
      length: _screens.length,
      child: Scaffold(
        body: IndexedStack(
          index: selectedTabIndex.value,
          children: _screens,
        ),
        floatingActionButton: const BottomFlatButtonWidget(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: MainBottomNavigationWidget(
          onTap: onIdxChanged,
          selectedIndex: selectedTabIndex.value,
        ),
      ),
    );
  }
}

class MainBottomNavigationWidget extends StatelessWidget {
  final ValueChanged<int> onTap;
  final int selectedIndex;

  const MainBottomNavigationWidget({
    super.key,
    required this.onTap,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      child: BottomNavigationBar(
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        backgroundColor: const Color(0xff00755E),
        enableFeedback: false,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          _CustomBottomNavigationBarItem(
            icon: BottomNavIconWidget(
              iconPath: homeIcon,
              isFocus: selectedIndex == 0,
            ),
          ),
          _CustomBottomNavigationBarItem(
            icon: BottomNavIconWidget(
              iconPath: treasureMapIcon,
              isFocus: selectedIndex == 1,
            ),
          ),
          const BottomNavigationBarItem(
            icon: SizedBox.shrink(),
            label: '',
          ),
          _CustomBottomNavigationBarItem(
            icon: BottomNavIconWidget(
              iconPath: directionSignIcon,
              isFocus: selectedIndex == 3,
            ),
          ),
          _CustomBottomNavigationBarItem(
            icon: BottomNavIconWidget(
              iconPath: profileIcon,
              isFocus: selectedIndex == 4,
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomBottomNavigationBarItem extends BottomNavigationBarItem {
  _CustomBottomNavigationBarItem({required super.icon, super.label = ''});
}

class BottomNavIconWidget extends StatelessWidget {
  final String iconPath;
  final bool isFocus;

  const BottomNavIconWidget({
    super.key,
    required this.iconPath,
    required this.isFocus,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconPath,
      color: isFocus ? const Color(0xffE5592F) : Colors.white,
      placeholderBuilder: (context) => const Icon(Icons.add),
    );
  }
}

class BottomFlatButtonWidget extends StatelessWidget {
  const BottomFlatButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      width: 68,
      child: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: () {},
        child: Container(
          height: 70,
          width: 70,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment(0.7, -0.5),
              end: Alignment(0.6, 0.5),
              colors: [
                Color(0xFFFA7C47),
                Color(0xFFE4572E),
              ],
            ),
          ),
          child: UnconstrainedBox(
            child: SvgPicture.asset(
              cameraFlat,
            ),
          ),
        ),
      ),
    );
  }
}
