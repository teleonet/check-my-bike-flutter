import 'package:check_my_bike_flutter/presentation/screen/database/all/database_all.dart';
import 'package:check_my_bike_flutter/presentation/screen/database/by_name/database_by_name.dart';
import 'package:check_my_bike_flutter/presentation/screen/database/tab/database_tab_item.dart';
import 'package:flutter/material.dart';

import '../../../../resources/colors_res.dart';
import '../../base/base_screen_state.dart';

class DatabaseTabController extends StatefulWidget {
  const DatabaseTabController({Key? key}) : super(key: key);

  @override
  _DatabaseTabControllerState createState() => _DatabaseTabControllerState();
}

class _DatabaseTabControllerState extends BaseScreenState<DatabaseTabController> {
  final List<Widget> _widgets = [const DatabaseAll(), const DatabaseByName()];

  //todo: need refactor to get current widget from list instead of init one more widget
  Widget _currentWidget = const DatabaseAll();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      DefaultTabController(
          length: _widgets.length,
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
                _currentWidget = _widgets[index];
              });
            },
            tabs: const <Widget>[
              DatabaseTabItem("All"),
              DatabaseTabItem("By name"),
            ],
          )),
      Container(child: _currentWidget)
    ]);
  }
}
