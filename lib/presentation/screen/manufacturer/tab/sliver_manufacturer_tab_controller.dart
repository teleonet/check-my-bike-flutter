import 'package:flutter/material.dart';

import 'manufacturer_tab_controller.dart';

class SliverManufacturerTabController extends ManufacturerTabController {
  SliverManufacturerTabController(Function(int index) onClickedTab, {Key? key})
      : super(onClickedTab, key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        floating: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: super.build(context));
  }
}
