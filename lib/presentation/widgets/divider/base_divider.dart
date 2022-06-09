import 'package:flutter/material.dart';

import '../../../resources/colors_res.dart';

abstract class BaseDivider extends StatefulWidget {
  //todo: need to refactor to more convenient pattern.
  final double _thickness;
  final Color? _color;

  double get thickness => _thickness;

  const BaseDivider(this._thickness, {Color? color, Key? key})
      : _color = color,
        super(key: key);

  double getWidth();

  double getHeight();

  @override
  _BaseDividerState createState() => _BaseDividerState();
}

class _BaseDividerState extends State<BaseDivider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.getHeight(),
      width: widget.getWidth(),
      color: _getColor(),
    );
  }

  Color _getColor() {
    return widget._color != null ? widget._color! : ColorsRes.divider;
  }
}
