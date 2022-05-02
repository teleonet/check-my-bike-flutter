import 'package:check_my_bike_flutter/presentation/ticker/provider_ticker.dart';
import 'package:flutter/material.dart';

import '../../../../resources/colors_res.dart';
import '../../../base/base_screen_state.dart';

class NavigationBottomBar extends StatefulWidget {
  final Function(int) _onTabChanged;

  const NavigationBottomBar(this._onTabChanged, {Key? key}) : super(key: key);

  @override
  NavigationBottomBarState createState() => NavigationBottomBarState();
}

class NavigationBottomBarState extends BaseScreenState<NavigationBottomBar> {
  AnimationController? _animationController;
  int _currentIndex = 0;

  NavigationBottomBarState() {
    _animationController = _buildAnimationController();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: _buildTheme(),
        child: Container(
            color: ColorsRes.endGradient,
            width: MediaQuery.of(context).size.width,
            child: SizeTransition(
                sizeFactor: _animationController!,
                axisAlignment: -1.0,
                child: Stack(children: [
                  SizedBox(
                      height: 1,
                      child: Align(
                          alignment: _getBottomNavigationLIneAlignment(_currentIndex),
                          child: Container(
                            margin: const EdgeInsets.only(left: 15, right: 15),
                            width: MediaQuery.of(context).size.width / 3.7,
                            color: ColorsRes.green,
                          ))),
                  Container(
                      margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
                      child: BottomNavigationBar(
                          currentIndex: _currentIndex,
                          onTap: (index) => setState(() {
                                _currentIndex = index;
                                widget._onTabChanged(index);
                              }),
                          elevation: 0.0,
                          backgroundColor: Colors.transparent,
                          unselectedIconTheme: const IconThemeData(color: Colors.white, size: 30),
                          unselectedLabelStyle: _buildTextStyle(),
                          unselectedItemColor: Colors.white,
                          selectedItemColor: ColorsRes.green,
                          selectedIconTheme: IconThemeData(color: ColorsRes.green, size: 30),
                          selectedLabelStyle: _buildTextStyle(),
                          items: _buildBottomNavigationBarItems()))
                ]))));
  }

  ThemeData _buildTheme() {
    return Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent);
  }

  Alignment _getBottomNavigationLIneAlignment(int index) {
    Alignment alignment = Alignment.center;
    switch (index) {
      case 0:
        alignment = Alignment.centerLeft;
        break;
      case 2:
        alignment = Alignment.centerRight;
        break;
    }
    return alignment;
  }

  TextStyle _buildTextStyle() {
    return const TextStyle(fontFamily: 'Roboto Thin', fontSize: 14);
  }

  AnimationController _buildAnimationController() {
    return AnimationController(
        value: 100, vsync: ProviderTicker(), duration: const Duration(milliseconds: 300));
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItems() {
    return const [
      BottomNavigationBarItem(icon: Icon(Icons.search), label: 'check', tooltip: ""),
      BottomNavigationBarItem(icon: Icon(Icons.summarize), label: 'manufacturers', tooltip: ""),
      BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: 'settings', tooltip: ""),
    ];
  }

  void show() {
    _animationController?.forward();
  }

  void hide() {
    _animationController?.reverse();
  }
}
