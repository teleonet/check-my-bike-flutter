import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/manufacturer.dart';
import '../../base/base_screen_state.dart';
import '../manufacturer_item.dart';

abstract class ManufacturersBaseState<T extends StatefulWidget> extends BaseScreenState<T> {
  List<Manufacturer> _manufacturers = [];
  List<Widget> _topWidgets = [];

  ManufacturersBaseState() {
    _manufacturers = getManufacturers();
    _topWidgets = getTopWidgets();
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
              height: MediaQuery.of(context).size.height * _getHeightFactor(),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
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

  double _getHeightFactor() {
    //todo: need to find a correct solution to calculate normal height of full visible screen
    return _topWidgets.isNotEmpty ? 0.65 : 0.75;
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
