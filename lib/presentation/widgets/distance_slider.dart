import 'package:check_my_bike_flutter/domain/entity/distance_entity.dart';
import 'package:flutter/material.dart';

import '../../resources/colors_res.dart';

class DistanceSlider extends StatefulWidget {
  final Function(int) _onChanged;
  final DistanceEntity? _distance;

  const DistanceSlider(this._onChanged, this._distance, {Key? key}) : super(key: key);

  @override
  _DistanceSliderState createState() => _DistanceSliderState();
}

class _DistanceSliderState extends State<DistanceSlider> {
  double _currentValue = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        decoration: _buildContainerDecoration(),
        child: Material(
            color: Colors.transparent,
            child: Column(children: [
              Text("Around you", style: _buildTextStyle(), textAlign: TextAlign.center),
              _buildSlider(),
              Text("${_currentValue.toInt()} " + widget._distance?.title,
                  style: _buildTextStyle(), textAlign: TextAlign.center)
            ])));
  }

  Decoration _buildContainerDecoration() {
    return BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: ColorsRes.green, width: 0.3),
        borderRadius: const BorderRadius.all(Radius.elliptical(10, 10)));
  }

  TextStyle _buildTextStyle() {
    return TextStyle(
        fontFamily: 'Roboto Thin',
        color: ColorsRes.green,
        fontSize: 18,
        decoration: TextDecoration.none);
  }

  Widget _buildSlider() {
    return Slider(
        inactiveColor: Colors.white,
        activeColor: ColorsRes.green,
        thumbColor: ColorsRes.green,
        max: 20,
        value: _currentValue,
        onChangeEnd: (double value) {
          if (widget._distance?.type == "km") {
            value = _convertKmToMiles(value);
          }
          widget._onChanged.call(value.toInt());
        },
        onChanged: (double value) => setState(() => _currentValue = value));
  }

  double _convertKmToMiles(double miles) {
    const kmInOneMile = 0.62;
    return miles * kmInOneMile;
  }
}
