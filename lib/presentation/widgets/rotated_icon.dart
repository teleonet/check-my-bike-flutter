import 'dart:math';

import 'package:flutter/cupertino.dart';

class RotatedIcon extends StatefulWidget {
  final IconData _icon;
  double size;
  int duration;

  RotatedIcon(this._icon, {this.size = 20, this.duration = 500, Key? key}) : super(key: key);

  @override
  RotatedIconState createState() => RotatedIconState();
}

class RotatedIconState extends State<RotatedIcon> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController = _buildAnimationController();
    super.initState();
  }

  AnimationController _buildAnimationController() {
    return AnimationController(vsync: this, duration: Duration(milliseconds: widget.duration));
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
        child: Icon(widget._icon, size: widget.size),
        builder: (context, child) => _buildTransform(child));
  }

  Widget _buildTransform(Widget? child) {
    double angle = _animationController!.value * 2.0 * pi;
    return Transform.rotate(angle: angle, child: child);
  }

  void rotate() async {
    _animationController?.reset();
    _animationController?.forward();
  }
}
