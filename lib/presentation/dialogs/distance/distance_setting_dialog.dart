import 'package:check_my_bike_flutter/domain/entity/distance_entity.dart';
import 'package:check_my_bike_flutter/presentation/dialogs/button_dialog.dart';
import 'package:flutter/cupertino.dart';

import 'distance_sliding.dart';

class DistanceSettingDialog extends ButtonDialog {
  final Function(DistanceEntity) _callback;
  final List<DistanceEntity> _distances;
  DistanceEntity _selectedDistance;

  DistanceSettingDialog(this._distances, this._selectedDistance, this._callback);

  @override
  List<Widget> getWidgets(BuildContext context) {
    return [_buildDistanceSliding(), _buildButton(context)];
  }

  Widget _buildDistanceSliding() {
    return Container(
        child: Center(
            child: DistanceSliding(_distances, _selectedDistance,
                (distanceType) => _selectedDistance = distanceType)));
  }

  Widget _buildButton(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 25),
        child: Center(
            child: buildButton("Apply", onPressed: () {
          Navigator.pop(context);
          _callback.call(_selectedDistance);
        })));
  }
}
