import 'package:check_my_bike_flutter/domain/entity/manufacturer_entity.dart';
import 'package:check_my_bike_flutter/presentation/screen/manufacturers/base/manufacturers_base_state.dart';
import 'package:flutter/material.dart';

import '../../../validator/validator.dart';
import '../../../widgets/input_form/input_form.dart';

class ManufacturersSearchScreen extends StatefulWidget {
  const ManufacturersSearchScreen({Key? key}) : super(key: key);

  @override
  _ManufacturersSearchScreenState createState() => _ManufacturersSearchScreenState();
}

class _ManufacturersSearchScreenState extends ManufacturersBaseState<ManufacturersSearchScreen> {
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
    return [_buildInputForm()];
  }

  Widget _buildInputForm() {
    return InputForm("Manufacturer's name", (textToSearch) {
      //todo: request to search to bloc
    }, (textForValidator) {
      return Validator.moreThenOneSymbol(textForValidator);
    }, "Please enter more then 1 symbols");
  }
}
