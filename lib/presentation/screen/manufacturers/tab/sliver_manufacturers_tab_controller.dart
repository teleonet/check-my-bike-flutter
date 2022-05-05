import 'package:check_my_bike_flutter/resources/colors_res.dart';
import 'package:flutter/material.dart';

import 'manufacturers_tab_controller.dart';

class SliverManufacturersTabController extends ManufacturersTabController {
  const SliverManufacturersTabController(Function(int) _onClickedTab, {Key? key})
      : super(_onClickedTab, key: key);

  @override
  SliverManufacturersTabControllerState createState() => SliverManufacturersTabControllerState();
}

class SliverManufacturersTabControllerState extends ManufacturersTabControllerState {
  Color _backgroundColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      backgroundColor: _backgroundColor,
      shadowColor: Colors.transparent,
      title: super.build(context),
    );
  }

  void changeToDefaultColor() {
    setState(() => _backgroundColor = Colors.transparent);
  }

  void changeToScrollColor() {
    setState(() => _backgroundColor = ColorsRes.darkGreyOpacity75);
  }
}
