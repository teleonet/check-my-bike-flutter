import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/manufacturer.dart';
import '../../base/base_screen_state.dart';
import '../manufacturer_item.dart';

class ManufacturersFavoritesScreen extends StatefulWidget {
  const ManufacturersFavoritesScreen({Key? key}) : super(key: key);

  @override
  _ManufacturersFavoritesScreenState createState() => _ManufacturersFavoritesScreenState();
}

class _ManufacturersFavoritesScreenState extends BaseScreenState<ManufacturersFavoritesScreen> {
  List<Manufacturer>? _items;

  _ManufacturersFavoritesScreenState() {
    _items = _buildItems();
  }

  //todo: mock items, only for development
  List<Manufacturer> _buildItems() {
    return [
      Manufacturer("Scott", "scott.com", false),
      Manufacturer("Comanche", "comanche.com", true,
          imageUrl: "files.bikeindex.org/uploads/Ma/957/Nashbarcom.png"),
      Manufacturer(
        "Dean",
        "dean.com",
        false,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 15),
        height: MediaQuery.of(context).size.height - 250,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          physics: const ScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: _items?.length,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.transparent,
              child: Center(
                  child: ManufacturerItem(
                      _items![index],
                      (manufacturer) => print(
                          "pressed: ${manufacturer.name}, favorite: ${manufacturer.favorite}"),
                      (manufacturer) => _openURL(manufacturer.companyUrl))),
            );
          },
        ));
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
