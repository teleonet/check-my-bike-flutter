import 'package:flutter/material.dart';

import '../../../../resources/colors_res.dart';

class ManufacturersTabController extends StatelessWidget {
  final Function(int) _onClickedTab;
  List<Widget> _tabs = [];
  int _currentIndex = -1;

  ManufacturersTabController(this._onClickedTab, {Key? key}) : super(key: key) {
    _tabs = _buildTabs();
  }

  List<Widget> _buildTabs() {
    return [
      _buildTabItem("All"),
      _buildTabItem("Search"),
      _buildTabItem("Favorites"),
    ];
  }

  Widget _buildTabItem(String title) {
    return SizedBox(height: 50, child: Center(child: Text(title, textAlign: TextAlign.center)));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        animationDuration: const Duration(milliseconds: 800),
        length: _tabs.length,
        child: _buildTabBar());
  }

  Widget _buildTabBar() {
    return TabBar(
        indicatorWeight: 0.5,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: ColorsRes.green,
        labelColor: ColorsRes.green,
        labelStyle: _buildTextStyle(FontWeight.bold),
        unselectedLabelStyle: _buildTextStyle(FontWeight.normal),
        tabs: _tabs,
        onTap: (index) {
          if (_currentIndex != index) {
            _onClickedTab.call(index);
            _currentIndex = index;
          }
        });
  }

  TextStyle _buildTextStyle(FontWeight fontWeight) {
    return TextStyle(fontFamily: 'Roboto Thin', fontSize: 18, fontWeight: fontWeight);
  }
}
