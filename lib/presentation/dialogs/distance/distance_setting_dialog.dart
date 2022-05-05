import 'package:check_my_bike_flutter/presentation/dialogs/button_dialog.dart';
import 'package:check_my_bike_flutter/presentation/models/distance.dart';
import 'package:flutter/cupertino.dart';

import 'distance_sliding.dart';

class DistanceSettingDialog extends ButtonDialog {
  final Function(DistanceType) _callback;
  final List<DistanceType> _distances;
  DistanceType _selectedDistanceType;

  DistanceSettingDialog(this._distances, this._selectedDistanceType, this._callback);

  @override
  List<Widget> getWidgets(BuildContext context) {
    return [_buildDistanceSliding(), _buildButton(context)];
  }

  Widget _buildDistanceSliding() {
    return Center(
        child: DistanceSliding(_distances, _selectedDistanceType,
            (distanceType) => _selectedDistanceType = distanceType));
  }

  Widget _buildButton(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 25),
        child: Center(
            child: buildButton("Apply", onPressed: () {
          Navigator.pop(context);
          _callback.call(_selectedDistanceType);
        })));
  }
}
