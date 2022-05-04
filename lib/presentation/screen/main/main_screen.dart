import 'package:check_my_bike_flutter/presentation/screen/manufacturers/manufacturers_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/settings/settings_screen.dart';
import 'package:check_my_bike_flutter/resources/colors_res.dart';
import 'package:flutter/material.dart';

import '../../base/base_screen_state.dart';
import '../../router/slide_right_route.dart';
import '../check/check_screen.dart';
import 'navigation_bottom_bar/navigation_bottom_bar.dart';

class MainScreen extends StatefulWidget {
  static show(BuildContext context) {
    Navigator.push(context, SlideRightRoute(const MainScreen()).createRoute());
  }

  static showAndClearStack(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context, SlideRightRoute(const MainScreen()).createRoute(), (_) => false);
  }

  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends BaseScreenState<MainScreen> {
  final GlobalKey<NavigationBottomBarState> _navigationBottomBarKey =
      GlobalKey<NavigationBottomBarState>();
  List<Widget> _screens = [];
  int _currentIndex = 0;

  _MainScreenState() {
    _screens = _buildScreens();
  }

  List<Widget> _buildScreens() {
    return [
      const CheckScreen(),
      ManufacturersScreen(
          onScrollTop: () => _navigationBottomBarKey.currentState?.show(),
          onScrollBottom: () => _navigationBottomBarKey.currentState?.hide(),
          onClickedTab: () => _navigationBottomBarKey.currentState?.show()),
      const SettingsScreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: _buildContainerDecoration(),
          child: IndexedStack(index: _currentIndex, children: _screens),
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
    return NavigationBottomBar((tabIndex) => setState(() => _currentIndex = tabIndex),
        key: _navigationBottomBarKey);
  }
}
