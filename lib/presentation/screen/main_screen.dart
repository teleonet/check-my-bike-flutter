import 'package:check_my_bike_flutter/resources/color.dart';
import 'package:flutter/material.dart';

import 'base/base_screen_state.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends BaseScreenState<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorRes.blue,
        body: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: const Center(child: Text("check my bike"))));
  }
}
