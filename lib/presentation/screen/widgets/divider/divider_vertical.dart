import 'package:check_my_bike_flutter/presentation/screen/widgets/divider/base_divider.dart';
import 'package:flutter/cupertino.dart';

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
