import 'dart:ui';

import 'package:flutter/animation.dart';

abstract class AnimationFabric {
  Animation<Offset> createTopBottom(AnimationController controller);

  Animation<Offset> createLeftRight(AnimationController controller);

  Animation<Offset> createBottomTop(AnimationController controller);

  Animation<double> createShake(AnimationController controller, double shakeCount);
}
