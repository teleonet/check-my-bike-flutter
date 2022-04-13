import 'package:flutter/cupertino.dart';

import '../../../resources/color_res.dart';
import '../base/base_screen_state.dart';

class DatabaseScreen extends StatefulWidget {
  const DatabaseScreen({Key? key}) : super(key: key);

  @override
  _DatabaseScreenState createState() => _DatabaseScreenState();
}

class _DatabaseScreenState extends BaseScreenState<DatabaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Text("Database screen",
          style: TextStyle(fontFamily: 'Roboto Thin', color: ColorRes.green, fontSize: 40)),
    );
  }
}
