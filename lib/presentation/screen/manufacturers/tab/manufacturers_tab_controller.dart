import 'package:flutter/material.dart';

import '../../../../resources/colors_res.dart';
import '../../base/base_screen_state.dart';
import 'manufacturers_tab_item.dart';

//todo: need to add swipe effect for change tabs logic
class ManufacturersTabController extends StatefulWidget {
  final List<Widget> _screens;

  const ManufacturersTabController(this._screens, {Key? key}) : super(key: key);

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
            labelStyle: const TextStyle(
                fontFamily: 'Roboto Thin', fontSize: 18, fontWeight: FontWeight.bold),
            unselectedLabelStyle: const TextStyle(fontFamily: 'Roboto Thin', fontSize: 18),
            onTap: (index) {
              setState(() {
                _currentScreen = widget._screens[index];
              });
            },
            tabs: const <Widget>[
              ManufacturersTabItem("All"),
              ManufacturersTabItem("Search"),
              ManufacturersTabItem("Favorites"),
            ],
          )),
      //todo: add animation
      Container(child: _currentScreen ?? widget._screens[0])
    ]);
  }
}
