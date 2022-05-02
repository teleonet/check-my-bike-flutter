import 'package:check_my_bike_flutter/presentation/models/manufacturer.dart';
import 'package:check_my_bike_flutter/presentation/screen/manufacturers/base/manufacturers_base_state.dart';
import 'package:flutter/material.dart';

import '../../../validator/validator.dart';
import '../../../widgets/input_form/input_form.dart';

class ManufacturersSearchScreen extends StatefulWidget {
  final Function? onScrollTop;
  final Function? onScrollBottom;

  const ManufacturersSearchScreen({this.onScrollTop, this.onScrollBottom, Key? key})
      : super(key: key);

  @override
  _ManufacturersSearchScreenState createState() => _ManufacturersSearchScreenState();
}

class _ManufacturersSearchScreenState extends ManufacturersBaseState<ManufacturersSearchScreen> {
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
      ),
      Manufacturer("Nashbar", "nashbar.com", false),
      Manufacturer("National", "national.com", true),
      Manufacturer("Nakto", "nakto.com", false),
      Manufacturer("NEMO", "nemo.com", false,
          imageUrl: "files.bikeindex.org/uploads/Ma/957/Nashbarcom.png"),
      Manufacturer("Harry Quinn", "harry-quinn.com", false),
      Manufacturer("Hasa", "hasa.com", true),
      Manufacturer("Head", "head.com", true),
      Manufacturer("Heritage", "heritage.com", false,
          imageUrl: "files.bikeindex.org/uploads/Ma/957/Nashbarcom.png"),
      Manufacturer("Hoffman", "hoffman.com", true,
          imageUrl: "files.bikeindex.org/uploads/Ma/957/Nashbarcom.png"),
      Manufacturer("Ideal Bikes", "ideal-bikes.com", false),
      Manufacturer("Iron Horse Bikes", "iron-horse-bikes.com", false),
      Manufacturer("Jetson", "jetson.com", true),
      Manufacturer("K2", "k2.com", true),
      Manufacturer("Kelly", "kelly.com", true,
          imageUrl: "files.bikeindex.org/uploads/Ma/957/Nashbarcom.png"),
      Manufacturer("Kestrel", "kestrel.com", false),
      Manufacturer("Kinesis", "kinesis.com", false),
      Manufacturer("Koga-Miyata", "koga-miyata.com", false)
    ];
  }

  @override
  List<Manufacturer> getManufacturers() {
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

  @override
  Function? getTopScrollHandler() {
    return widget.onScrollTop?.call();
  }

  @override
  Function? getBottomScrollHandler() {
    return widget.onScrollBottom?.call();
  }
}
