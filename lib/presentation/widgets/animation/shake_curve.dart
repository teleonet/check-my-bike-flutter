import 'dart:math';

import 'package:flutter/animation.dart';

class ShakeCurve extends Curve {
  final double count;

  const ShakeCurve({this.count = 3});

  @override
  double transformInternal(double t) {
    return sin(count * 2 * pi * t);
  }
}
