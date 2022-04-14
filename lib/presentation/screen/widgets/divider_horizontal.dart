import 'package:flutter/cupertino.dart';

import '../../../resources/color_res.dart';
import '../base/base_screen_state.dart';

class DividerHorizontal extends StatefulWidget {
  const DividerHorizontal(this._thickness, this._width, {Key? key}) : super(key: key);

  final double _thickness;
  final double _width;

  @override
  _DividerHorizontalState createState() => _DividerHorizontalState();
}

class _DividerHorizontalState extends BaseScreenState<DividerHorizontal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget._thickness,
      width: widget._width,
      color: ColorRes.divider,
    );
  }
}
