import 'package:check_my_bike_flutter/presentation/models/bike.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/details_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/info.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/status.dart';
import 'package:check_my_bike_flutter/presentation/screen/widgets/input_form.dart';
import 'package:flutter/material.dart';

import '../../../validator/validator.dart';
import '../base/base_check_state.dart';
import '../details_button.dart';
import '../status.dart';

class SerialScreen extends StatefulWidget {
  static show(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SerialScreen()));
  }

  const SerialScreen({Key? key}) : super(key: key);

  @override
  _SerialScreenState createState() => _SerialScreenState();
}

class _SerialScreenState extends BaseCheckState<SerialScreen> {
  //todo: only for development
  final Bike _bike = Bike(
      410882, true, "Scott", "SWBD312L0482P", "Not stolen", "2018 Fuji ABOSLUTE 1.1", 2021, false,
      largeImg: "https://bikeindex.org/bikes/410882",
      stolenLocation: "Tallahassee, FL 32303, US",
      description:
          "Big, heavy e-bike with a headlight and detachable center console, room for a second rider on the back.",
      colors: ["Silver, gray or bare metal", "silver"]);

  _SerialScreenState() : super("serial");

  @override
  List<Widget> getWidgets() {
    return [
      _buildInputForm(),
      Info(_bike),
      Status(_bike.stolen),
      _bike.stolen ? _buildDetailsButton() : const SizedBox.shrink()
    ];
  }

  Widget _buildInputForm() {
    return InputForm("serial number", (textToSearch) {
      //todo: bloc
    }, (textForValidator) {
      return Validator.moreThenFourSymbols(textForValidator);
    }, "Please enter more then 4 symbols");
  }

  Widget _buildDetailsButton() {
    return DetailsButton(onPressed: () => DetailsScreen.show(context, _bike));
  }
}
