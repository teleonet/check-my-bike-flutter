import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/manufacturer.dart';
import '../../base/base_screen_state.dart';
import '../manufacturer_item.dart';

abstract class ManufacturersBaseState<T extends StatefulWidget> extends BaseScreenState<T> {
  List<Manufacturer> _manufacturers = [];

  ManufacturersBaseState() {
    _manufacturers = getManufacturers();
  }

  @protected
  List<Manufacturer> getManufacturers();

  @protected
  List<Widget> getTopWidgets();

  @protected
  Function? getTopScrollHandler();

  @protected
  Function? getBottomScrollHandler();

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Column(children: getTopWidgets()),
      NotificationListener<UserScrollNotification>(
          onNotification: (notification) => _handleScrollAndCallHandler(notification),
          child: Container(
              margin: const EdgeInsets.only(top: 15),
              height: MediaQuery.of(context).size.height * 0.75,
              child: ListView.builder(
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: _manufacturers.length,
                itemBuilder: (context, index) {
                  return _buildItem(index);
                },
              )))
    ]);
  }

  bool _handleScrollAndCallHandler(UserScrollNotification scroll) {
    if (scroll.direction == ScrollDirection.forward) {
      getTopScrollHandler()?.call();
    }
    if (scroll.direction == ScrollDirection.reverse) {
      getBottomScrollHandler()?.call();
    }
    return false;
  }

  Widget _buildItem(int index) {
    Manufacturer manufacturer = _manufacturers[index];
    String name = manufacturer.name;
    bool isFavorite = manufacturer.isFavorite;

    return ManufacturerItem(
        _manufacturers[index],
        (manufacturer) => print("Favorite pressed: $name status: $isFavorite"),
        (manufacturer) => onItemClicked(manufacturer));
  }

  @protected
  void onItemClicked(Manufacturer manufacturer) {
    _openURL(manufacturer.companyUrl);
  }

  void _openURL(String url) async {
    try {
      //todo: need add parameters for Android and IOS => https://pub.dev/packages/url_launcher
      await launch(url);
    } on MissingPluginException catch (e) {
      print("ERROR: $e");
    }
  }
}
