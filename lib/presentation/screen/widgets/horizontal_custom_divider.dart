import 'package:flutter/cupertino.dart';

import '../../../resources/color_res.dart';
import '../base/base_screen_state.dart';

class HorizontalCustomDivider extends StatefulWidget {
  const HorizontalCustomDivider(this._thickness, this._width, {Key? key}) : super(key: key);

  final double _thickness;
  final double _width;

  @override
  _HorizontalCustomDividerState createState() => _HorizontalCustomDividerState();
}

class _HorizontalCustomDividerState extends BaseScreenState<HorizontalCustomDivider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget._thickness,
      width: widget._width,
      color: ColorRes.divider,
    );
  }
}
