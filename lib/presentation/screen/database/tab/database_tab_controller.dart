import 'package:check_my_bike_flutter/presentation/screen/database/tab/database_tab_item.dart';
import 'package:flutter/material.dart';

import '../../../../resources/colors_res.dart';
import '../../base/base_screen_state.dart';

class DatabaseTabController extends StatefulWidget {
  final List<Widget> _screens;

  const DatabaseTabController(this._screens, {Key? key}) : super(key: key);

  @override
  _DatabaseTabControllerState createState() => _DatabaseTabControllerState();
}

class _DatabaseTabControllerState extends BaseScreenState<DatabaseTabController> {
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
              DatabaseTabItem("All"),
              DatabaseTabItem("By name"),
            ],
          )),
      //todo: add animation
      Container(child: _currentScreen ?? widget._screens[0])
    ]);
  }
}
