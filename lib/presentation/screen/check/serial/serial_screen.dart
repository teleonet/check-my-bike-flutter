import 'package:check_my_bike_flutter/presentation/models/bike.dart';
import 'package:check_my_bike_flutter/presentation/navigation/navigation.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/check_info.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/check_status.dart';
import 'package:check_my_bike_flutter/presentation/screen/widgets/input_form.dart';
import 'package:flutter/material.dart';

import '../../../../resources/colors_res.dart';
import '../../../validator/validator.dart';
import '../../base/base_screen_state.dart';

class SerialScreen extends StatefulWidget {
  const SerialScreen({Key? key}) : super(key: key);

  @override
  _SerialScreenState createState() => _SerialScreenState();
}

class _SerialScreenState extends BaseScreenState<SerialScreen> {
  //todo: only for development
  final Bike _bike = Bike(
      410882, true, "Scott", "SWBD312L0482P", "stolen", "2018 Fuji ABOSLUTE 1.1", 2021, true,
      largeImg: "https://bikeindex.org/bikes/410882");

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        decoration: _buildGradientDecoration(),
        child: Column(children: [
          _buildAppBar(),
          const Padding(padding: EdgeInsets.only(top: 5)),
          InputForm("serial number", (textToSearch) {
            //todo: bloc
          }, (textForValidator) {
            return Validator.moreThenFourSymbols(textForValidator);
          }, "Please enter more then 4 symbols"),
          CheckInfo(_bike),
          CheckStatus(_bike.stolen, onPressed: () => print("details pressed")),
          const Spacer()
        ]));
  }

  AppBar _buildAppBar() {
    return AppBar(
      toolbarHeight: 65,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      shape: _buildAppBarBorder(),
      title: const Text("serial"),
      centerTitle: true,
      iconTheme: IconThemeData(color: ColorsRes.green, size: 30),
      titleTextStyle: TextStyle(fontFamily: 'Roboto Thin', color: ColorsRes.green, fontSize: 35),
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: ColorsRes.green, size: 25.0),
          onPressed: () => Navigation().pop()),
    );
  }

  OutlinedBorder _buildAppBarBorder() {
    return RoundedRectangleBorder(
        side: BorderSide(width: 0.15, color: ColorsRes.green),
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)));
  }

  BoxDecoration _buildGradientDecoration() {
    return BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ColorsRes.startGradient, ColorsRes.endGradient]));
  }
}
