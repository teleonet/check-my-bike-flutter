import 'dart:ui';

import 'package:check_my_bike_flutter/presentation/router/slide_right_route.dart';
import 'package:flutter/material.dart';

import '../../../../resources/colors_res.dart';
import '../../../base/base_screen_state.dart';
import '../../../widgets/autoscroll_text.dart';

class InfoSettingScreen extends StatefulWidget {
  static void show(BuildContext context) {
    Navigator.push(context, SlideRightRoute(const InfoSettingScreen()).createRoute());
  }

  const InfoSettingScreen({Key? key}) : super(key: key);

  @override
  _InfoSettingScreenState createState() => _InfoSettingScreenState();
}

class _InfoSettingScreenState extends BaseScreenState<InfoSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        decoration: _buildGradientDecoration(),
        child: Column(children: [
          _buildAppBar(),
          Container(
              decoration: _buildContainerDecoration(),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 120,
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                _buildRowContainer("Language", "PL"),
                _buildRowContainer("Build", "1.0.0"),
                _buildRowContainer("Server connection", "ok"),
                _buildRowContainer("Favorites", "27"),
                _buildRowContainer("Bikes in database", "110848")
              ]))
        ]));
  }

  BoxDecoration _buildGradientDecoration() {
    return BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ColorsRes.startGradient, ColorsRes.endGradient]));
  }

  AppBar _buildAppBar() {
    return AppBar(
      toolbarHeight: 65,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      shape: _buildAppBarBorder(),
      title: const Text("info"),
      centerTitle: true,
      iconTheme: IconThemeData(color: ColorsRes.green, size: 30),
      titleTextStyle: TextStyle(fontFamily: 'Roboto Thin', color: ColorsRes.green, fontSize: 35),
      leading: _buildIconButton(),
    );
  }

  OutlinedBorder _buildAppBarBorder() {
    return RoundedRectangleBorder(
        side: BorderSide(width: 0.15, color: ColorsRes.green),
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)));
  }

  Widget _buildIconButton() {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios, color: ColorsRes.green, size: 25.0),
        onPressed: () => Navigator.pop(context));
  }

  Decoration _buildContainerDecoration() {
    return BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: ColorsRes.green, width: 0.2),
        borderRadius: const BorderRadius.all(Radius.elliptical(10, 10)));
  }

  Container _buildRowContainer(String title, String value, {Color? valueColor}) {
    return Container(
        padding: const EdgeInsets.only(top: 10),
        child: Row(children: [_buildTitle(title), _buildValue(value, textColor: valueColor)]));
  }

  Text _buildTitle(String title) {
    return Text("$title: ", style: _buildTextStyle(ColorsRes.green));
  }

  Widget _buildValue(String value, {Color? textColor}) {
    Widget widget = _buildText(value, textColor: textColor);
    if (value.length > 20) {
      widget = _buildAutoScrollText(value, textColor: textColor);
    }
    return widget;
  }

  Widget _buildText(String value, {Color? textColor}) {
    return Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(value,
            textAlign: TextAlign.right, style: _buildTextStyle(textColor ?? Colors.white)));
  }

  TextStyle _buildTextStyle(Color color) {
    return TextStyle(
        fontFamily: 'Roboto Thin', color: color, fontSize: 20, decoration: TextDecoration.none);
  }

  Widget _buildAutoScrollText(String value, {Color? textColor}) {
    return AutoScrollText(value, MediaQuery.of(context).size.width * 0.65, textColor: textColor);
  }
}
