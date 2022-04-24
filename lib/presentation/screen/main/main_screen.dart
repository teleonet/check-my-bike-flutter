import 'package:check_my_bike_flutter/presentation/screen/main/bottom_navigation_bar/navigation_bottom_bar.dart';
import 'package:check_my_bike_flutter/presentation/screen/manufacturers/manufacturers_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/settings/settings_screen.dart';
import 'package:check_my_bike_flutter/resources/colors_res.dart';
import 'package:flutter/material.dart';

import '../base/base_screen_state.dart';
import '../check/check_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends BaseScreenState<MainScreen> {
  final _navigationBottomBarKey = GlobalKey<NavigationBottomBarState>();
  List<Widget> _screens = [];
  int _currentIndex = 0;

  _MainScreenState() {
    _screens = _buildScreens();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: _buildContainerDecoration(),
        child: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
      ),
      bottomNavigationBar: NavigationBottomBar((indexOfSelectedTab) {
        setState(() => _currentIndex = indexOfSelectedTab);
      }, key: _navigationBottomBarKey),
    );
  }

  BoxDecoration _buildContainerDecoration() {
    return BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ColorsRes.startGradient, ColorsRes.endGradient]));
  }

  List<Widget> _buildScreens() {
    return <Widget>[
      const CheckScreen(),
      ManufacturersScreen(
          onTopScroll: () => _navigationBottomBarKey.currentState?.show(),
          onBottomScroll: () => _navigationBottomBarKey.currentState?.hide(),
          onTabClicked: () => _navigationBottomBarKey.currentState?.show()),
      const SettingsScreen()
    ];
  }
}
