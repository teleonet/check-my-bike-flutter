import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../base/base_screen_state.dart';
import '../../../models/manufacturer.dart';
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

  @override
  Widget build(BuildContext context) {
    return _buildListView();
  }

  Widget _buildListView() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      //todo: need to find more better solution
      if (index == 0) {
        for (Widget item in getTopWidgets()) {
          return item;
        }
      }
      return _buildManufacturerItem(_manufacturers[index]);
    }, childCount: _manufacturers.length));
  }

  Widget _buildManufacturerItem(Manufacturer manufacturer) {
    String name = manufacturer.name;
    bool isFavorite = manufacturer.isFavorite;

    return ManufacturerItem(
        manufacturer,
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
