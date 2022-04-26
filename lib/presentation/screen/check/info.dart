import 'package:flutter/material.dart';

import '../../../resources/colors_res.dart';
import '../../models/bike.dart';
import '../base/base_screen_state.dart';
import '../widgets/autoscroll_text.dart';

class Info extends StatefulWidget {
  final Bike _bike;

  const Info(this._bike, {Key? key}) : super(key: key);

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends BaseScreenState<Info> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: _buildContainerDecoration(),
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(left: 30, right: 30, top: 15),
        padding: const EdgeInsets.only(bottom: 15, left: 20),
        child: Column(children: [
          _buildBikeImage(),
          _buildRowContainer("Serial", "${widget._bike.serial}"),
          _buildRowContainer("Manufacturer", "${widget._bike.manufacturerName}"),
          _buildRowContainer("Status", "${widget._bike.status}"),
          _buildRowContainer("Year", "${widget._bike.year}"),
          _buildRowContainer("Location", "${widget._bike.stolenLocation}")
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
        ? Icon(Icons.insert_photo_outlined, color: ColorsRes.green, size: 125)
        : const SizedBox.shrink();
  }

  Container _buildRowContainer(String title, String value) {
    return Container(
        padding: const EdgeInsets.only(top: 10),
        child: Row(children: [_buildTitleText(title), _buildValueText(value)]));
  }

  Text _buildTitleText(String title) {
    return Text("$title: ", style: _buildTextStyle(ColorsRes.green));
  }

  Widget _buildValueText(String value) {
    Widget widget = Text(value, style: _buildTextStyle(Colors.white));
    if (value.length > 20) {
      widget = AutoScrollText(value, MediaQuery.of(context).size.width * 0.5);
    }
    return widget;
  }

  TextStyle _buildTextStyle(Color color) {
    return TextStyle(
        fontFamily: 'Roboto Thin', color: color, fontSize: 20, decoration: TextDecoration.none);
  }
}
