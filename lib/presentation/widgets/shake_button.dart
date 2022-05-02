import 'dart:math';

import 'package:flutter/material.dart';

import '../../../resources/colors_res.dart';

class ShakeButton extends StatefulWidget {
  final String _title;
  Function? _onPressed;

  ShakeButton(this._title, {Function? onPressed, Key? key}) : super(key: key) {
    _onPressed = onPressed;
  }

  @override
  ShakeButtonState createState() => ShakeButtonState();
}

class ShakeButtonState extends AnimationControllerState {
  final double _shakeCount = 3;

  Color _decorationColor = ColorsRes.green;

  ShakeButtonState() : super(const Duration(milliseconds: 500));

  late final Animation<double> _sineAnimation = Tween(
    begin: 0.0,
    end: 1.0,
  ).animate(CurvedAnimation(
    parent: animationController,
    curve: SineCurve(count: _shakeCount),
  ));

  void changeToNormalState() {
    _decorationColor = ColorsRes.green;
    setState(() => {});
  }

  void changeToErrorState() {
    _decorationColor = Colors.red;
    _shake();
    setState(() => {});
  }

  @override
  void initState() {
    animationController.addStatusListener(_updateStatus);
    super.initState();
  }

  @override
  void dispose() {
    animationController.removeStatusListener(_updateStatus);
    super.dispose();
  }

  void _updateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      animationController.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _sineAnimation,
      child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: _buildButtonDecoration(),
          margin: const EdgeInsets.only(left: 30, right: 30),
          child: _buildTextButton()),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_sineAnimation.value * 10, 0),
          child: child,
        );
      },
    );
  }

  Decoration _buildButtonDecoration() {
    return BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: _decorationColor, width: 0.3),
        borderRadius: const BorderRadius.all(Radius.elliptical(10, 10)));
  }

  TextButton _buildTextButton() {
    return TextButton(
        onPressed: () {
          changeToNormalState();
          widget._onPressed?.call();
        },
        child: Text(widget._title,
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Roboto Thin', color: ColorsRes.green, fontSize: 20)));
  }

  void _shake() async {
    animationController.forward();
  }
}

abstract class AnimationControllerState extends State<ShakeButton>
    with SingleTickerProviderStateMixin {
  AnimationControllerState(this.animationDuration);

  final Duration animationDuration;
  late final animationController = AnimationController(vsync: this, duration: animationDuration);

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class SineCurve extends Curve {
  final double count;

  const SineCurve({this.count = 3});

  @override
  double transformInternal(double t) {
    return sin(count * 2 * pi * t);
  }
}
