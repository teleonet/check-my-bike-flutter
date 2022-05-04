import 'package:check_my_bike_flutter/presentation/router/animated_route.dart';
import 'package:flutter/cupertino.dart';

import '../widgets/animation/fabric/animation_fabric_impl.dart';

class SlideRightRoute extends AnimatedRoute {
  SlideRightRoute(Widget screen) : super(screen);

  @override
  Widget createTransactionBuilder(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
        position: AnimationFabricImpl().createRightLeft(animation), child: child);
  }
}
