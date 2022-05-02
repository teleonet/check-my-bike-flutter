import 'package:check_my_bike_flutter/presentation/models/bike.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/base/base_check_state.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/details/details_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/info/info.dart';
import 'package:flutter/material.dart';

import '../../../validator/validator.dart';
import '../../../widgets/input_form/input_form.dart';

class CustomScreen extends StatefulWidget {
  static show(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomScreen()));
  }

  const CustomScreen({Key? key}) : super(key: key);

  @override
  _CustomScreenState createState() => _CustomScreenState();
}

class _CustomScreenState extends BaseCheckState<CustomScreen> {
  List<Bike> _bikes = [];

  _CustomScreenState() : super("custom") {
    _bikes = _buildBikes();
  }

  //todo: only for development
  List<Bike> _buildBikes() {
    return [
      Bike(410882, true, "Scott", "SWBD312L0482P", "stolen", "2018 Fuji ABOSLUTE 1.1", 2021, true,
          largeImg: "https://bikeindex.org/bikes/410882",
          stolenLocation: "Tallahassee, FL 32303, US",
          description:
              "Big, heavy e-bike with a headlight and detachable center console, room for a second rider on the back.",
          colors: ["Silver, gray or bare metal", "silver"]),
      Bike(410882, true, "Commanche", "SWBD312L0482P", "stolen", "2021 Fuji ABOSLUTE 1.1", 2021,
          true,
          largeImg: "https://bikeindex.org/bikes/410882",
          stolenLocation: "USA, FL 32303, US",
          description:
              "Big, heavy e-bike with a headlight and detachable center console, room for a second rider on the back.",
          colors: ["Silver, gray or bare metal", "silver"]),
      Bike(410882, true, "Commanche", "SWBD312L0482P", "stolen", "2021 Fuji ABOSLUTE 1.1", 2021,
          true,
          largeImg: "https://bikeindex.org/bikes/410882",
          stolenLocation: "USA, FL 32303, US",
          description:
              "Big, heavy e-bike with a headlight and detachable center console, room for a second rider on the back.",
          colors: ["Silver, gray or bare metal", "silver"]),
      Bike(410882, true, "Commanche", "SWBD312L0482P", "stolen", "2021 Fuji ABOSLUTE 1.1", 2021,
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
    return InputForm("custom parameter", (textToSearch) {
      //todo: bloc
    }, (textForValidator) {
      return Validator.moreThenTwoSymbols(textForValidator);
    }, "Please enter more then 2 symbols");
  }

  Widget _buildListView() {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        height: MediaQuery.of(context).size.height * 0.7,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: _bikes.length,
          itemBuilder: (context, index) => _buildInfoItem(_bikes[index]),
        ));
  }

  Widget _buildInfoItem(Bike bike) {
    return InfoItem(bike,
        onPressedInfo: (bike) => DetailsScreen.show(context, bike), onPressedFavorite: (bike) {});
  }
}
