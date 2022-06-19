import 'package:flutter/material.dart';

import '../../../resources/colors_res.dart';

abstract class BaseDivider extends StatelessWidget {
  final Color? color;

  final double _thickness;

  double get thickness => _thickness;

  const BaseDivider(this._thickness, {this.color, Key? key}) : super(key: key);

  @protected
  double getWidth();

  @protected
  double getHeight();

  @override
  Widget build(BuildContext context) {
    return Container(height: getHeight(), width: getWidth(), color: _getColor());
  }

  Color _getColor() {
    return color != null ? color! : ColorsRes.divider;
  }
}
