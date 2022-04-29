import 'package:flutter/cupertino.dart';

import 'base_divider.dart';

class DividerHorizontal extends BaseDivider {
  final double _width;

  const DividerHorizontal(double thickness, this._width, {Color? color, Key? key})
      : super(thickness, color: color, key: key);

  @override
  double getHeight() {
    return thickness;
  }

  @override
  double getWidth() {
    return _width;
  }
}
