import 'package:flutter/material.dart';

import '../../../../resources/colors_res.dart';
import '../../../base/base_screen_state.dart';
import 'manufacturers_tab_item.dart';

//todo: need to add swipe effect for change tabs logic
class ManufacturersTabController extends StatefulWidget {
  final List<Widget> _screens;
  final Function? onClickedTab;

  const ManufacturersTabController(this._screens, {this.onClickedTab, Key? key}) : super(key: key);

  @override
  _ManufacturersTabControllerState createState() => _ManufacturersTabControllerState();
}

class _ManufacturersTabControllerState extends BaseScreenState<ManufacturersTabController> {
  Widget? _currentScreen;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      DefaultTabController(
          initialIndex: 0,
          length: widget._screens.length,
          child: TabBar(
              indicatorWeight: 0.5,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: ColorsRes.green,
              labelColor: ColorsRes.green,
              labelStyle: _buildTextStyle(FontWeight.bold),
              unselectedLabelStyle: _buildTextStyle(FontWeight.normal),
              tabs: _buildTabs(),
              onTap: (index) {
                widget.onClickedTab?.call();
                setState(() => _currentScreen = widget._screens[index]);
              })),
      //todo: add animation
      Container(child: _currentScreen ?? widget._screens[0])
    ]);
  }

  TextStyle _buildTextStyle(FontWeight fontWeight) {
    return TextStyle(fontFamily: 'Roboto Thin', fontSize: 18, fontWeight: fontWeight);
  }

  List<Widget> _buildTabs() {
    return [
      const ManufacturersTabItem("All"),
      const ManufacturersTabItem("Search"),
      const ManufacturersTabItem("Favorites"),
    ];
  }
}
