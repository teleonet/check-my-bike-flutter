import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../resources/colors_res.dart';
import '../../models/bike.dart';
import '../base/base_screen_state.dart';

class CheckInfo extends StatefulWidget {
  final Bike _bike;

  const CheckInfo(this._bike, {Key? key}) : super(key: key);

  @override
  _CheckInfoState createState() => _CheckInfoState();
}

class _CheckInfoState extends BaseScreenState<CheckInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: _buildContainerDecoration(),
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(left: 30, right: 30, top: 15),
        padding: const EdgeInsets.only(bottom: 15, left: 20),
        child: Column(children: [
          _buildBikeImage(),
          _buildRowContainer("id", "${widget._bike.id}"),
          _buildRowContainer("Manufacturer", "${widget._bike.manufacturerName}"),
          _buildRowContainer("Status", "${widget._bike.status}"),
          _buildRowContainer("Year", "${widget._bike.year}")
        ]));
  }

  Decoration _buildContainerDecoration() {
    return BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: ColorsRes.green),
        borderRadius: const BorderRadius.all(Radius.elliptical(10, 10)));
  }

  Widget _buildBikeImage() {
    return widget._bike.largeImg?.isNotEmpty
        ? Icon(Icons.insert_photo_outlined, color: ColorsRes.green, size: 125.0)
        : const SizedBox.shrink();
  }

  Container _buildRowContainer(String title, String value) {
    return Container(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Row(children: [_buildTitleText(title), _buildValueText(value)]));
  }

  Text _buildTitleText(String title) {
    return Text("$title: ", style: _buildTextStyle(ColorsRes.green));
  }

  Text _buildValueText(String value) {
    return Text(value, style: _buildTextStyle(Colors.white));
  }

  TextStyle _buildTextStyle(Color color) {
    return TextStyle(
        fontFamily: 'Roboto Thin', color: color, fontSize: 20, decoration: TextDecoration.none);
  }
}
