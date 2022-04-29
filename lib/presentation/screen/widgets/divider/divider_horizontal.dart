import 'package:check_my_bike_flutter/presentation/screen/widgets/divider/base_divider.dart';
import 'package:flutter/cupertino.dart';

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
