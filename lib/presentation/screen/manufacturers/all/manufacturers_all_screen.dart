import 'package:flutter/material.dart';

import '../../../../domain/entity/manufacturer_entity.dart';
import '../base/manufacturers_base_state.dart';

class ManufacturersAllScreen extends StatefulWidget {
  const ManufacturersAllScreen({Key? key}) : super(key: key);

  @override
  _ManufacturersAllScreenState createState() => _ManufacturersAllScreenState();
}

class _ManufacturersAllScreenState extends ManufacturersBaseState<ManufacturersAllScreen> {
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

  @override
  Function? getTopScrollHandler() {
    // return widget.onScrollTop?.call();
  }

  @override
  Function? getBottomScrollHandler() {
    // return widget.onScrollBottom?.call();
  }
}
