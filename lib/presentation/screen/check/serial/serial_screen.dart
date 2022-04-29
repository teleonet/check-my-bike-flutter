import 'package:check_my_bike_flutter/presentation/models/bike.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/details_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/info.dart';
import 'package:check_my_bike_flutter/presentation/screen/widgets/flashing_text.dart';
import 'package:check_my_bike_flutter/presentation/screen/widgets/input_form.dart';
import 'package:check_my_bike_flutter/resources/colors_res.dart';
import 'package:flutter/material.dart';

import '../../../validator/validator.dart';
import '../../widgets/flashing_text.dart';
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
  //todo: only for development
  final Bike _bike = Bike(
      410882, true, "Scott", "SWBD312L0482P", "Not Stolen", "2018 Fuji ABOSLUTE 1.1", 2021, false,
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
      Info(_bike, onInfoPressed: (bike) => DetailsScreen.show(context, bike)),
      const Padding(padding: EdgeInsets.only(top: 20)),
      _bike.stolen
          ? FlashingText("Stolen", _bike.stolen ? Colors.red : ColorsRes.green)
          : Text("Not Stolen", style: _buildTextStyle(70))
    ];
  }

  Widget _buildInputForm() {
    return InputForm("serial number", (textToSearch) {
      //todo: bloc
    }, (textForValidator) {
      return Validator.moreThenFourSymbols(textForValidator);
    }, "Please enter more then 4 symbols");
  }

  TextStyle _buildTextStyle(double fontSize) {
    return TextStyle(
        decoration: TextDecoration.none,
        fontWeight: FontWeight.bold,
        color: ColorsRes.green,
        fontFamily: 'Roboto Thin',
        fontSize: fontSize);
  }
}
