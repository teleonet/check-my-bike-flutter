import 'package:check_my_bike_flutter/presentation/screen/database/tab/database_tab_controller.dart';
import 'package:check_my_bike_flutter/presentation/screen/widgets/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../base/base_screen_state.dart';
import 'all/database_all_screen.dart';
import 'by_name/database_by_name_screen.dart';

class DatabaseScreen extends StatefulWidget {
  const DatabaseScreen({Key? key}) : super(key: key);

  @override
  _DatabaseScreenState createState() => _DatabaseScreenState();
}

class _DatabaseScreenState extends BaseScreenState<DatabaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Header("Database"),
      const Padding(padding: EdgeInsets.only(top: 5)),
      DatabaseTabController(_buildScreens())
    ]);
  }

  List<Widget> _buildScreens() {
    return [const DatabaseAllScreen(), const DatabaseByNameScreen()];
  }
}
