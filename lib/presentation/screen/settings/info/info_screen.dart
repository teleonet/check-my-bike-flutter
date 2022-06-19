import 'package:check_my_bike_flutter/presentation/router/slide_right_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../resources/colors_res.dart';

class InfoScreen extends StatefulWidget {
  static void show(BuildContext context) {
    Navigator.push(context, SlideRightRoute(const InfoScreen()).createRoute());
  }

  const InfoScreen({Key? key}) : super(key: key);

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
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
              child: Text('settings_screen.credentials'.tr(), style: _buildTextStyle()))
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
        title: Text('settings_screen.info'.tr()),
        centerTitle: true,
        iconTheme: IconThemeData(color: ColorsRes.green, size: 30),
        titleTextStyle: TextStyle(fontFamily: 'Roboto Thin', color: ColorsRes.green, fontSize: 35),
        leading: _buildIconButton());
  }

  OutlinedBorder _buildAppBarBorder() {
    Radius radius = const Radius.circular(30);
    return RoundedRectangleBorder(
        side: BorderSide(width: 0.15, color: ColorsRes.green),
        borderRadius: BorderRadius.only(bottomLeft: radius, bottomRight: radius));
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

  TextStyle _buildTextStyle() {
    return TextStyle(
        decoration: TextDecoration.none,
        fontWeight: FontWeight.bold,
        color: ColorsRes.green,
        fontFamily: 'Roboto Thin',
        fontSize: 20);
  }
}
