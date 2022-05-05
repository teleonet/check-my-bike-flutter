import 'package:flutter/material.dart';

import '../../../../resources/colors_res.dart';
import '../../../base/base_screen_state.dart';
import '../../../widgets/rotated_icon.dart';

class NavigationBottomBar extends StatefulWidget {
  final Function(int) _onChangedTab;

  const NavigationBottomBar(this._onChangedTab, {Key? key}) : super(key: key);

  @override
  NavigationBottomBarState createState() => NavigationBottomBarState();
}

class NavigationBottomBarState extends BaseScreenState<NavigationBottomBar>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  List<BottomNavigationBarItem> _items = [];
  int _currentIndex = 0;

  Color _navigationBarColor = Colors.transparent;

  NavigationBottomBarState() {
    _items = _buildBottomNavigationBarItems();
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItems() {
    return [
      BottomNavigationBarItem(
          icon: RotatedIcon(Icons.search, key: GlobalKey<RotatedIconState>()),
          label: 'check',
          tooltip: ""),
      BottomNavigationBarItem(
          icon: RotatedIcon(Icons.summarize, key: GlobalKey<RotatedIconState>()),
          label: 'manufacturers',
          tooltip: ""),
      BottomNavigationBarItem(
          icon: RotatedIcon(Icons.settings_outlined, key: GlobalKey<RotatedIconState>()),
          label: 'settings',
          tooltip: ""),
    ];
  }

  @override
  void initState() {
    _animationController = _buildAnimationController();
    super.initState();
  }

  AnimationController _buildAnimationController() {
    return AnimationController(
        value: 100, vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: _buildTheme(),
        child: Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            child: SizeTransition(
                sizeFactor: _animationController!,
                axisAlignment: -1.0,
                child: Stack(
                    children: [_buildActiveNavigationBarLine(), _buildBottomNavigationBar()]))));
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
            alignment: _buildNavigationLineAlignment(_currentIndex),
            child: Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              width: MediaQuery.of(context).size.width / 3.7,
              color: ColorsRes.green,
            )));
  }

  Alignment _buildNavigationLineAlignment(int index) {
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
        elevation: 0,
        backgroundColor: _navigationBarColor,
        selectedItemColor: ColorsRes.green,
        selectedIconTheme: IconThemeData(color: ColorsRes.green, size: 30),
        selectedLabelStyle: _buildTextStyle(),
        unselectedItemColor: Colors.white,
        unselectedIconTheme: const IconThemeData(color: Colors.white, size: 30),
        unselectedLabelStyle: _buildTextStyle(),
        items: _items,
        onTap: (index) => setState(() {
              _rotateIcon(_items[index].icon as RotatedIcon);
              _currentIndex = index;
              widget._onChangedTab(index);
            }));
  }

  void _rotateIcon(RotatedIcon icon) {
    (icon.key as GlobalKey<RotatedIconState>).currentState?.rotate();
  }

  TextStyle _buildTextStyle() {
    return const TextStyle(fontFamily: 'Roboto Thin', fontSize: 14);
  }

  void show() {
    _animationController?.forward();
  }

  void hide() {
    _animationController?.reverse();
  }

  void changeToOpacityColor() {
    setState(() {
      _navigationBarColor = ColorsRes.endGradientOpacity70;
    });
  }

  void changeToGradientColor() {
    setState(() {
      _navigationBarColor = ColorsRes.endGradient;
    });
  }

  void changeToTransparentColor() {
    setState(() {
      _navigationBarColor = Colors.transparent;
    });
  }
}
