import 'package:check_my_bike_flutter/presentation/screen/check/check_button_item.dart';
import 'package:check_my_bike_flutter/presentation/screen/widgets/divider/divider_horizontal.dart';
import 'package:check_my_bike_flutter/presentation/screen/widgets/divider/divider_vertical.dart';
import 'package:check_my_bike_flutter/presentation/screen/widgets/header.dart';
import 'package:flutter/material.dart';

import '../base/base_screen_state.dart';

class CheckScreen extends StatefulWidget {
  const CheckScreen({Key? key}) : super(key: key);

  @override
  _CheckScreenState createState() => _CheckScreenState();
}

class _CheckScreenState extends BaseScreenState<CheckScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          const Header("Check my bike"),
          const Spacer(),
          Row(children: [
            const Spacer(),
            CheckButtonItem("serial", Icons.subject, () {
              //todo
            }),
            DividerVertical(2, 100),
            CheckButtonItem("manufacturer", Icons.settings, () {
              //todo
            }),
            const Spacer()
          ]),
          Row(children: [
            const Spacer(),
            DividerHorizontal(2, 100),
            const Spacer(),
            DividerHorizontal(2, 100),
            const Spacer(),
          ]),
          Row(children: [
            const Spacer(),
            CheckButtonItem("custom", Icons.account_tree_outlined, () {
              //todo
            }),
            DividerVertical(2, 100),
            CheckButtonItem("location", Icons.place_outlined, () {
              //todo
            }),
            const Spacer()
          ]),
          const Spacer()
        ]));
  }
}
