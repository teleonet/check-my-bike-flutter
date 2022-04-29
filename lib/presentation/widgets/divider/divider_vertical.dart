import 'package:flutter/cupertino.dart';

import 'base_divider.dart';

class DividerVertical extends BaseDivider {
  final double _height;

  const DividerVertical(double thickness, this._height, {Color? color, Key? key})
      : super(thickness, color: color, key: key);

  @override
  double getHeight() {
    return _height;
  }

  @override
  double getWidth() {
    return thickness;
  }
}
