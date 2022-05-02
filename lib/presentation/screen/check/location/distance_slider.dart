import 'dart:ui';

import 'package:check_my_bike_flutter/presentation/base/base_screen_state.dart';
import 'package:flutter/material.dart';

import '../../../../resources/colors_res.dart';

class DistanceSlider extends StatefulWidget {
  final Function(int) _onChanged;

  const DistanceSlider(this._onChanged, {Key? key}) : super(key: key);

  @override
  _DistanceSliderState createState() => _DistanceSliderState();
}

class _DistanceSliderState extends BaseScreenState<DistanceSlider> {
  double _currentValue = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 30, right: 30),
        padding: const EdgeInsets.only(top: 3, bottom: 3),
        decoration: _buildContainerDecoration(),
        child: Material(
            color: Colors.transparent,
            child: Column(children: [
              Text("Distance around",
                  style: _buildTextStyle(fontSize: 18), textAlign: TextAlign.center),
              SizedBox(
                  height: 30,
                  child: Slider(
                      inactiveColor: Colors.white,
                      activeColor: ColorsRes.green,
                      thumbColor: ColorsRes.green,
                      max: 20,
                      value: _currentValue,
                      onChangeEnd: (double value) => widget._onChanged.call(value.toInt()),
                      onChanged: (double value) => setState(() => _currentValue = value))),
              Text("${_currentValue.toInt()} miles",
                  textAlign: TextAlign.center, style: _buildTextStyle())
            ])));
  }

  Decoration _buildContainerDecoration() {
    return BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: ColorsRes.green, width: 0.3),
        borderRadius: const BorderRadius.all(Radius.elliptical(10, 10)));
  }

  TextStyle _buildTextStyle({double? fontSize}) {
    return TextStyle(
        fontFamily: 'Roboto Thin',
        color: ColorsRes.green,
        fontSize: fontSize ?? 15,
        decoration: TextDecoration.none);
  }
}
