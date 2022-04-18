import 'package:flutter/cupertino.dart';

import '../../../../resources/colors_res.dart';
import '../../base/base_screen_state.dart';

abstract class BaseDivider extends StatefulWidget {
  //todo: need to refactor to more convenient pattern.
  final int _thickness;
  final Color? _color;

  get thickness => _thickness;

  const BaseDivider(this._thickness, {Color? color, Key? key})
      : _color = color,
        super(key: key);

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
      color: _getColor(),
    );
  }

  Color _getColor() {
    return widget._color != null ? widget._color! : ColorsRes.divider;
  }
}
