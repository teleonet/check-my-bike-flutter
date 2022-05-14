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
    return [
      ManufacturerEntity("Scott", "scott.com", false),
      ManufacturerEntity("Comanche", "comanche.com", true,
          imageUrl: "files.bikeindex.org/uploads/Ma/957/Nashbarcom.png"),
      ManufacturerEntity(
        "Dean",
        "dean.com",
        false,
      ),
      ManufacturerEntity("Nashbar", "nashbar.com", false),
      ManufacturerEntity("National", "national.com", true),
      ManufacturerEntity("Nakto", "nakto.com", false),
      ManufacturerEntity("NEMO", "nemo.com", false,
          imageUrl: "files.bikeindex.org/uploads/Ma/957/Nashbarcom.png"),
      ManufacturerEntity("Harry Quinn", "harry-quinn.com", false),
      ManufacturerEntity("Hasa", "hasa.com", true),
      ManufacturerEntity("Head", "head.com", true),
      ManufacturerEntity("Heritage", "heritage.com", false,
          imageUrl: "files.bikeindex.org/uploads/Ma/957/Nashbarcom.png"),
      ManufacturerEntity("Hoffman", "hoffman.com", true,
          imageUrl: "files.bikeindex.org/uploads/Ma/957/Nashbarcom.png"),
      ManufacturerEntity("Ideal Bikes", "ideal-bikes.com", false),
      ManufacturerEntity("Iron Horse Bikes", "iron-horse-bikes.com", false),
      ManufacturerEntity("Jetson", "jetson.com", true),
      ManufacturerEntity("K2", "k2.com", true),
      ManufacturerEntity("Kelly", "kelly.com", true,
          imageUrl: "files.bikeindex.org/uploads/Ma/957/Nashbarcom.png"),
      ManufacturerEntity("Kestrel", "kestrel.com", false),
      ManufacturerEntity("Kinesis", "kinesis.com", false),
      ManufacturerEntity("Koga-Miyata", "koga-miyata.com", false),
      ManufacturerEntity("Last item", "last item in list", true)
    ];
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
