import 'package:flutter/material.dart';

import '../../../models/manufacturer.dart';
import '../base/manufacturers_base_state.dart';

class ManufacturersAllScreen extends StatefulWidget {
  final Function? onScrollTop;
  final Function? onScrollBottom;

  const ManufacturersAllScreen({this.onScrollTop, this.onScrollBottom, Key? key}) : super(key: key);

  @override
  _ManufacturersAllScreenState createState() => _ManufacturersAllScreenState();
}

class _ManufacturersAllScreenState extends ManufacturersBaseState<ManufacturersAllScreen> {
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
    return [];
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
