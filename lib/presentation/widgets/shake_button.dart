import 'package:check_my_bike_flutter/presentation/widgets/animation/shake_curve.dart';
import 'package:flutter/material.dart';

import '../../../resources/colors_res.dart';
import '../base/base_screen_state.dart';

class ShakeButton extends StatefulWidget {
  final String _title;
  final Function? onPressed;

  const ShakeButton(this._title, {this.onPressed, Key? key}) : super(key: key);

  @override
  ShakeButtonState createState() => ShakeButtonState();
}

class ShakeButtonState extends BaseScreenState<ShakeButton> with SingleTickerProviderStateMixin {
  final double _shakeCount = 3;
  final Duration duration = const Duration(milliseconds: 500);
  Color _decorationColor = ColorsRes.green;
  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    _animationController = _buildAnimationController();
    _animation = _buildAnimation();
    _animationController?.addStatusListener(_animationListener);
    super.initState();
  }

  AnimationController _buildAnimationController() {
    return AnimationController(vsync: this, duration: duration);
  }

  Animation<double> _buildAnimation() {
    Tween<double> tween = Tween(begin: 0.0, end: 1.0);
    Curve curve = ShakeCurve(count: _shakeCount);
    CurvedAnimation curvedAnimation = CurvedAnimation(parent: _animationController!, curve: curve);
    return tween.animate(curvedAnimation);
  }

  @override
  void dispose() {
    _animationController?.removeStatusListener(_animationListener);
    _animationController?.dispose();
    super.dispose();
  }

  void _animationListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _animationController?.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation!,
      child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: _buildButtonDecoration(),
          margin: const EdgeInsets.only(left: 30, right: 30),
          child: _buildTextButton()),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_animation!.value * 10, 0),
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
          widget.onPressed?.call();
        },
        child: Text(widget._title,
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Roboto Thin', color: ColorsRes.green, fontSize: 20)));
  }

  void changeToNormalState() {
    _decorationColor = ColorsRes.green;
    setState(() => {});
  }

  void changeToErrorState() {
    _decorationColor = Colors.red;
    _shake();
    setState(() => {});
  }

  void _shake() async {
    _animationController?.forward();
  }
}
