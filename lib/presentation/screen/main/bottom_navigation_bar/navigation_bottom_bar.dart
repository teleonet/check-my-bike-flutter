import 'package:flutter/material.dart';

import '../../../../resources/colors_res.dart';
import '../../../base/base_screen_state.dart';

class NavigationBottomBar extends StatefulWidget {
  final Function(int) _onChangedTab;

  const NavigationBottomBar(this._onChangedTab, {Key? key}) : super(key: key);

  @override
  NavigationBottomBarState createState() => NavigationBottomBarState();
}

class NavigationBottomBarState extends BaseScreenState<NavigationBottomBar>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  int _currentIndex = 0;

  @override
  void initState() {
    _animationController = _buildAnimationController();
    super.initState();
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
                  _buildActiveNavigationBarLine(),
                  Container(
                      margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
                      child: _buildBottomNavigationBar())
                ]))));
  }

  ThemeData _buildTheme() {
    return Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent);
  }

  Widget _buildActiveNavigationBarLine() {
    return SizedBox(
        height: 1,
        child: Align(
            alignment: _getBottomNavigationLineAlignment(_currentIndex),
            child: Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              width: MediaQuery.of(context).size.width / 3.7,
              color: ColorsRes.green,
            )));
  }

  Alignment _getBottomNavigationLineAlignment(int index) {
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

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      unselectedIconTheme: const IconThemeData(color: Colors.white, size: 30),
      unselectedLabelStyle: _buildTextStyle(),
      unselectedItemColor: Colors.white,
      selectedItemColor: ColorsRes.green,
      selectedIconTheme: IconThemeData(color: ColorsRes.green, size: 30),
      selectedLabelStyle: _buildTextStyle(),
      items: _buildBottomNavigationBarItems(),
      onTap: (index) => setState(() {
        _currentIndex = index;
        widget._onChangedTab(index);
      }),
    );
  }

  TextStyle _buildTextStyle() {
    return const TextStyle(fontFamily: 'Roboto Thin', fontSize: 14);
  }

  AnimationController _buildAnimationController() {
    return AnimationController(
        value: 100, vsync: this, duration: const Duration(milliseconds: 300));
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
