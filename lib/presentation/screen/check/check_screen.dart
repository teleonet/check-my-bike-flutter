import 'package:check_my_bike_flutter/presentation/screen/check/button_item/check_button_item.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/custom/custom_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/location/location_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/serial/serial_screen.dart';
import 'package:flutter/material.dart';

import '../../base/base_screen_state.dart';
import '../../widgets/divider/divider_horizontal.dart';
import '../../widgets/divider/divider_vertical.dart';
import '../../widgets/header.dart';
import 'manufacturer/manufacturer_screen.dart';

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
          const Header("Check"),
          const Spacer(),
          Row(children: [
            const Spacer(),
            CheckButtonItem("serial", Icons.subject, () => SerialScreen.show(context)),
            const DividerVertical(2, 100),
            CheckButtonItem("manufacturer", Icons.settings, () => ManufacturerScreen.show(context)),
            const Spacer()
          ]),
          Row(children: const [
            Spacer(),
            DividerHorizontal(2, 100),
            Spacer(),
            DividerHorizontal(2, 100),
            Spacer(),
          ]),
          Row(children: [
            const Spacer(),
            CheckButtonItem(
                "custom", Icons.account_tree_outlined, () => CustomScreen.show(context)),
            const DividerVertical(2, 100),
            CheckButtonItem("location", Icons.place_outlined, () => LocationScreen.show(context)),
            const Spacer()
          ]),
          const Spacer()
        ]));
  }
}
