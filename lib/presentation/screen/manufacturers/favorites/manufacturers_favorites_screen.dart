import 'package:check_my_bike_flutter/presentation/screen/manufacturers/base/manufacturers_base_state.dart';
import 'package:flutter/material.dart';

import '../../../models/manufacturer.dart';

class ManufacturersFavoritesScreen extends StatefulWidget {
  Function? _onTopScroll;
  Function? _onBottomScroll;

  ManufacturersFavoritesScreen({Function? onTopScroll, Function? onBottomScroll, Key? key})
      : super(key: key) {
    _onTopScroll = onTopScroll;
    _onBottomScroll = onBottomScroll;
  }

  @override
  _ManufacturersFavoritesScreenState createState() => _ManufacturersFavoritesScreenState();
}

class _ManufacturersFavoritesScreenState
    extends ManufacturersBaseState<ManufacturersFavoritesScreen> {
  //todo: mock items, only for development
  List<Manufacturer> _buildManufacturers() {
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
  List<Manufacturer> getManufacturers() {
    return _buildManufacturers();
  }

  @override
  List<Widget> getTopWidgets() {
    return [];
  }

  @override
  Function? getBottomScrollHandler() {
    return widget._onBottomScroll;
  }

  @override
  Function? getTopScrollHandler() {
    return widget._onTopScroll;
  }
}
