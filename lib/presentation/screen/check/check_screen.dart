import 'package:check_my_bike_flutter/presentation/screen/check/button_item.dart';
import 'package:check_my_bike_flutter/presentation/screen/widgets/horizontal_custom_divider.dart';
import 'package:check_my_bike_flutter/presentation/screen/widgets/vertical_custom_divider.dart';
import 'package:flutter/material.dart';

import '../../../resources/color_res.dart';
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
          Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Center(
                  child: Text("Check my bike",
                      style: TextStyle(
                          fontFamily: 'Roboto Thin', color: ColorRes.green, fontSize: 40)))),
          const Spacer(),
          Row(children: [
            const Spacer(),
            ButtonItem("serial", Icons.subject, () {}),
            const VerticaCustomDivider(2, 100),
            ButtonItem("manufacturer", Icons.settings, () {}),
            Spacer()
          ]),
          Row(children: const [
            Spacer(),
            HorizontalCustomDivider(2, 100),
            Spacer(),
            HorizontalCustomDivider(2, 100),
            Spacer(),
          ]),
          Row(children: [
            const Spacer(),
            ButtonItem("custom", Icons.account_tree_outlined, () {}),
            const VerticaCustomDivider(2, 100),
            ButtonItem("location", Icons.place_outlined, () {}),
            const Spacer()
          ]),
          const Spacer()
        ]));
  }
}
