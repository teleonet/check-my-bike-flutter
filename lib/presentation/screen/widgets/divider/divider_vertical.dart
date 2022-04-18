import 'package:check_my_bike_flutter/presentation/screen/widgets/divider/base_divider.dart';
import 'package:flutter/cupertino.dart';

class DividerVertical extends BaseDivider {
  final int _height;

  const DividerVertical(thickness, this._height, {Color? color, Key? key})
      : super(thickness, color: color, key: key);

  @override
  int getHeightTemplateMethod() {
    return _height;
  }

  @override
  int getWidthTemplateMethod() {
    return thickness;
  }
}
