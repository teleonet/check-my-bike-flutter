import 'package:check_my_bike_flutter/resources/colors_res.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/entity/distance_entity.dart';
import '../../../resources/colors_res.dart';

class DistanceSliding extends StatefulWidget {
  final List<DistanceEntity> _types;
  final DistanceEntity _selectedType;
  final Function(DistanceEntity) _onChangedType;
  int _currentDistanceIndex = 0;

  DistanceSliding(this._types, this._selectedType, this._onChangedType, {Key? key})
      : super(key: key) {
    _currentDistanceIndex = _types.indexWhere((item) => item.title == _selectedType.title);
  }

  @override
  _DistanceSlidingState createState() => _DistanceSlidingState();
}

class _DistanceSlidingState extends State<DistanceSliding> {
  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl(
        backgroundColor: ColorsRes.darkGrey,
        thumbColor: ColorsRes.endGradient,
        groupValue: widget._currentDistanceIndex,
        children: _buildWidgetsMap(),
        onValueChanged: (currentLanguageIndex) {
          setState(() => widget._currentDistanceIndex = currentLanguageIndex as int);

          DistanceEntity distanceType = widget._types[widget._currentDistanceIndex];
          widget._onChangedType.call(distanceType);
        });
  }

  Map<int, Widget> _buildWidgetsMap() {
    Map<int, Widget> children = {};

    for (int index = 0; index < widget._types.length; index++) {
      DistanceEntity distanceType = widget._types[index];
      children[index] = _buildWidget(index, distanceType);
    }

    return children;
  }

  Widget _buildWidget(int index, DistanceEntity distanceItem) {
    return SizedBox(
        height: 50, child: Center(child: Text(distanceItem.title, style: _buildTextStyle())));
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
