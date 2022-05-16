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
    return [];
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
