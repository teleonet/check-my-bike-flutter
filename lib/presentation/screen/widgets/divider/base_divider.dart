import 'package:flutter/cupertino.dart';

import '../../../../resources/colors_res.dart';
import '../../base/base_screen_state.dart';

abstract class BaseDivider extends StatefulWidget {
  final int _thickness;

  get thickness => _thickness;

  const BaseDivider(this._thickness, {Key? key}) : super(key: key);

  int getWidthTemplateMethod();

  int getHeightTemplateMethod();

  @override
  _BaseDividerState createState() => _BaseDividerState();
}

class _BaseDividerState extends BaseScreenState<BaseDivider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.getHeightTemplateMethod().toDouble(),
      width: widget.getWidthTemplateMethod().toDouble(),
      color: ColorsRes.divider,
    );
  }
}
