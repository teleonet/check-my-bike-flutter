import 'package:check_my_bike_flutter/presentation/screen/manufacturers/base/manufacturers_base_state.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entity/manufacturer_entity.dart';

class ManufacturersFavoritesScreen extends StatefulWidget {
  const ManufacturersFavoritesScreen({Key? key}) : super(key: key);

  @override
  _ManufacturersFavoritesScreenState createState() => _ManufacturersFavoritesScreenState();
}

class _ManufacturersFavoritesScreenState
    extends ManufacturersBaseState<ManufacturersFavoritesScreen> {
  //todo: mock items, only for development
  List<ManufacturerEntity> _buildManufacturers() {
    return [
      ManufacturerEntity("Scott", "scott.com", false),
      ManufacturerEntity("Comanche", "comanche.com", true,
          imageUrl: "files.bikeindex.org/uploads/Ma/957/Nashbarcom.png"),
      ManufacturerEntity(
        "Dean",
        "dean.com",
        false,
      )
    ];
  }

  @override
  List<ManufacturerEntity> getManufacturers() {
    return _buildManufacturers();
  }

  @override
  List<Widget> getTopWidgets() {
    return [];
  }
}
