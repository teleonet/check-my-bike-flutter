import 'dart:ui';

import 'package:flutter/animation.dart';

import '../shake_curve.dart';
import 'animation_fabric.dart';

class AnimationFabricImpl extends AnimationFabric {
  @override
  Animation<Offset> createBottomTop(Animation<double> controller) {
    return Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero).animate(controller);
  }

  @override
  Animation<Offset> createTopBottom(Animation<double> controller) {
    return Tween<Offset>(begin: const Offset(0.0, -1.0), end: Offset.zero).animate(controller);
  }

  @override
  Animation<Offset> createLeftRight(Animation<double> controller) {
    return Tween<Offset>(begin: const Offset(-1.0, 0.0), end: Offset.zero).animate(controller);
  }

  @override
  Animation<Offset> createRightLeft(Animation<double> controller) {
    return Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero).animate(controller);
  }

  @override
  Animation<double> createShake(Animation<double> controller, double shakeCount) {
    Curve curve = ShakeCurve(count: shakeCount);
    CurvedAnimation curvedAnimation = CurvedAnimation(parent: controller, curve: curve);
    return Tween(begin: 0.0, end: 1.0).animate(curvedAnimation);
  }
}
