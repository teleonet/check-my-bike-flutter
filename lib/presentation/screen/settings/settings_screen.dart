import 'package:flutter/cupertino.dart';

import '../../../resources/color_res.dart';
import '../base/base_screen_state.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends BaseScreenState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Text("Settings screen",
          style: TextStyle(fontFamily: 'Roboto Thin', color: ColorRes.green, fontSize: 40)),
    );
  }
}
