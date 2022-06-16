import 'package:check_my_bike_flutter/domain/entity/distance_entity.dart';
import 'package:check_my_bike_flutter/presentation/dialogs/button_dialog.dart';
import 'package:flutter/material.dart';

import '../../widgets/distance_slider.dart';

class DistanceDialog extends ButtonDialog {
  final Function(int) _onChooseDistance;
  final DistanceEntity _distance;
  int _defaultDistance = 1;

  DistanceDialog(this._onChooseDistance, this._distance);

  @override
  List<Widget> getWidgets(context) {
    return [
      _buildSlider(),
      const Padding(padding: EdgeInsets.only(top: 30)),
      _buildButton(context)
    ];
  }

  Widget _buildSlider() {
    return DistanceSlider((value) => _defaultDistance = value, _distance);
  }

  Widget _buildButton(BuildContext context) {
    return Center(
        child: buildButton("ok", onPressed: () {
      Navigator.pop(context);
      _onChooseDistance.call(_defaultDistance);
    }));
  }
}
