import 'package:flutter/cupertino.dart';

import '../../../resources/color_res.dart';
import '../base/base_screen_state.dart';

class DividerVertical extends StatefulWidget {
  const DividerVertical(this._thickness, this._height, {Key? key}) : super(key: key);

  final double _thickness;
  final double _height;

  @override
  _DividerVerticalState createState() => _DividerVerticalState();
}

class _DividerVerticalState extends BaseScreenState<DividerVertical> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget._height,
      width: widget._thickness,
      color: ColorRes.divider,
    );
  }
}
