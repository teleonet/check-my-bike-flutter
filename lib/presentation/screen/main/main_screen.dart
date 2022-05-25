import 'package:check_my_bike_flutter/presentation/screen/manufacturers/manufacturers_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/settings/settings_screen.dart';
import 'package:check_my_bike_flutter/resources/colors_res.dart';
import 'package:flutter/material.dart';

import '../../router/slide_right_route.dart';
import '../check/check_screen.dart';
import 'navigation_bottom_bar/navigation_bottom_bar.dart';

class MainScreen extends StatelessWidget {
  static showAndClearStack(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context, SlideRightRoute(const MainScreen()).createRoute(), (_) => false);
  }

  // final GlobalKey<NavigationBottomBarState> _bottomBarKey = GlobalKey<NavigationBottomBarState>();

  const MainScreen({Key? key}) : super(key: key);

  // List<Widget> _screens = [];
  // int _currentIndex = 0;

  /*_MainScreenState() {
    _screens = _buildScreens();
  }*/

  List<Widget> _buildScreens() {
    return [
      const CheckScreen(),
      ManufacturersScreen(
          onScrollTop: () {
            // _bottomBarKey.currentState?.show();
            // _bottomBarKey.currentState?.changeToOpacityColor();
          },
          onScrollBottom: () => {} /*_bottomBarKey.currentState?.hide()*/,
          onScrolledTop: () => {} /*_bottomBarKey.currentState?.changeToGradientColor()*/,
          onClickedTab: () => {} /*_bottomBarKey.currentState?.show()*/),
      const SettingsScreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: _buildContainerDecoration(),
          child: IndexedStack(index: /*_currentIndex*/ 0, children: /* _screens*/ const [CheckScreen()]),
        ),
        bottomNavigationBar: _buildNavigationBottomBar());
  }

  BoxDecoration _buildContainerDecoration() {
    return BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ColorsRes.startGradient, ColorsRes.endGradient]));
  }

  NavigationBottomBar _buildNavigationBottomBar() {
    return NavigationBottomBar(
      (tabIndex) {
        /*if (_screens[tabIndex] is ManufacturersScreen) {
        // _bottomBarKey.currentState?.changeToGradientColor();
      } else {
        // _bottomBarKey.currentState?.changeToTransparentColor();
      }
      setState(() => _currentIndex = tabIndex);*/
      }, /*key: _bottomBarKey*/
    );
  }
}
