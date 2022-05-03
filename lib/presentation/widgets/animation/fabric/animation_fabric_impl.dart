import 'dart:ui';

import 'package:flutter/animation.dart';

import 'animation_fabric.dart';

class AnimationFabricImpl extends AnimationFabric {
  static const Offset _defaultOffset = Offset(0.0, 0.0);

  @override
  Animation<Offset> createBottomTop(AnimationController controller) {
    return Tween<Offset>(begin: const Offset(0.0, 1.0), end: _defaultOffset).animate(controller);
  }

  @override
  Animation<Offset> createLeftRight(AnimationController controller) {
    return Tween<Offset>(begin: const Offset(-1.0, 0.0), end: _defaultOffset).animate(controller);
  }

  @override
  Animation<Offset> createTopBottom(AnimationController controller) {
    return Tween<Offset>(begin: const Offset(0.0, -1.0), end: _defaultOffset).animate(controller);
  }
}
