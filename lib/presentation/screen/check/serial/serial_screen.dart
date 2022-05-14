import 'package:check_my_bike_flutter/domain/entity/bike_enitiy.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/details/details_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/info/info_item_with_status.dart';
import 'package:flutter/material.dart';

import '../../../validator/validator.dart';
import '../../../widgets/input_form/input_form.dart';
import '../base/base_check_state.dart';

class SerialScreen extends StatefulWidget {
  static show(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SerialScreen()));
  }

  const SerialScreen({Key? key}) : super(key: key);

  @override
  _SerialScreenState createState() => _SerialScreenState();
}

class _SerialScreenState extends BaseCheckState<SerialScreen> {
  List<BikeEntity> _bikes = [];

  _SerialScreenState() : super("serial") {
    _bikes = _buildBikes();
  }

  List<BikeEntity> _buildBikes() {
    return [
      BikeEntity(410882, true, "Scott", "SWBD312L0482P", "stolen", "2018 Fuji ABOSLUTE 1.1", 2021, true,
          largeImg: "https://bikeindex.org/bikes/410882",
          stolenLocation: "Tallahassee, FL 32303, US",
          description:
              "Big, heavy e-bike with a headlight and detachable center console, room for a second rider on the back.",
          colors: ["Silver, gray or bare metal", "silver"]),
      BikeEntity(410882, true, "Commanche", "SWBD312L0482P", "stolen", "2021 Fuji ABOSLUTE 1.1", 2021,
          true,
          largeImg: "https://bikeindex.org/bikes/410882",
          stolenLocation: "USA, FL 32303, US",
          description:
              "Big, heavy e-bike with a headlight and detachable center console, room for a second rider on the back.",
          colors: ["Silver, gray or bare metal", "silver"]),
      BikeEntity(410882, true, "Commanche", "SWBD312L0482P", "stolen", "2021 Fuji ABOSLUTE 1.1", 2021,
          true,
          largeImg: "https://bikeindex.org/bikes/410882",
          stolenLocation: "USA, FL 32303, US",
          description:
              "Big, heavy e-bike with a headlight and detachable center console, room for a second rider on the back.",
          colors: ["Silver, gray or bare metal", "silver"]),
      BikeEntity(410882, true, "Commanche", "SWBD312L0482P", "stolen", "2021 Fuji ABOSLUTE 1.1", 2021,
          true,
          largeImg: "https://bikeindex.org/bikes/410882",
          stolenLocation: "USA, FL 32303, US",
          description:
              "Big, heavy e-bike with a headlight and detachable center console, room for a second rider on the back.",
          colors: ["Silver, gray or bare metal", "silver"])
    ];
  }

  @override
  List<Widget> getWidgets() {
    return [_buildInputForm(), _buildListView()];
  }

  Widget _buildInputForm() {
    return SliverToBoxAdapter(
        child: InputForm("serial number", (textToSearch) {
      //todo: bloc
    }, (textForValidator) {
      return Validator.moreThenFourSymbols(textForValidator);
    }, "Please enter more then 4 symbols"));
  }

  Widget _buildListView() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return _buildInfoItemWithStatus(_bikes[index]);
    }, childCount: _bikes.length));
  }

  Widget _buildInfoItemWithStatus(BikeEntity bike) {
    return SizedBox(
        height: 415,
        child: InfoItemWithStatus(bike,
            onPressedInfo: (bike) => DetailsScreen.show(context, bike),
            onPressedFavorite: (bike) {}));
  }
}
