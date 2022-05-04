import 'dart:math';

import 'package:check_my_bike_flutter/presentation/base/base_screen_state.dart';
import 'package:flutter/cupertino.dart';

class RotatedIcon extends StatefulWidget {
  final IconData _icon;

  const RotatedIcon(this._icon, {Key? key}) : super(key: key);

  @override
  RotatedIconState createState() => RotatedIconState();
}

class RotatedIconState extends BaseScreenState<RotatedIcon> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController = _buildAnimationController();
    super.initState();
  }

  AnimationController _buildAnimationController() {
    return AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController!,
        child: Icon(widget._icon),
        builder: (context, child) => _buildTransform(child));
  }

  Widget _buildTransform(Widget? child) {
    return Transform.rotate(angle: _animationController!.value * 2.0 * pi, child: child);
  }

  void rotate() async {
    _animationController?.reset();
    _animationController?.forward();
  }
}
