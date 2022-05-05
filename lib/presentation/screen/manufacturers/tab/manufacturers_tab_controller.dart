import 'package:flutter/material.dart';

import '../../../../resources/colors_res.dart';
import '../../../base/base_screen_state.dart';

class ManufacturersTabController extends StatefulWidget {
  final Function(int) onClickedTab;

  const ManufacturersTabController(this.onClickedTab, {Key? key}) : super(key: key);

  @override
  ManufacturersTabControllerState createState() => ManufacturersTabControllerState();
}

class ManufacturersTabControllerState extends BaseScreenState<ManufacturersTabController> {
  List<Widget> _tabs = [];

  @override
  void initState() {
    _tabs = _buildTabs();
    super.initState();
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
        onTap: (index) => widget.onClickedTab.call(index));
  }

  TextStyle _buildTextStyle(FontWeight fontWeight) {
    return TextStyle(fontFamily: 'Roboto Thin', fontSize: 18, fontWeight: fontWeight);
  }
}
