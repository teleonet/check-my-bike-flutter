import 'dart:ui';

import 'package:flutter/animation.dart';

abstract class AnimationFabric {
  Animation<Offset> createTopBottom(Animation<double> controller);

  Animation<Offset> createBottomTop(Animation<double> controller);

  Animation<Offset> createLeftRight(Animation<double> controller);

  Animation<Offset> createRightLeft(Animation<double> controller);

  Animation<double> createShake(Animation<double> controller, double shakeCount);
}
