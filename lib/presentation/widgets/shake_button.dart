import 'package:check_my_bike_flutter/presentation/widgets/animation/factory/animation_factory.dart';
import 'package:check_my_bike_flutter/presentation/widgets/animation/factory/animation_factory_impl.dart';
import 'package:flutter/material.dart';

import '../../../resources/colors_res.dart';

class ShakeButton extends StatefulWidget {
  final String _title;
  final Function? onPressed;

  const ShakeButton(this._title, {this.onPressed, Key? key}) : super(key: key);

  @override
  ShakeButtonState createState() => ShakeButtonState();
}

class ShakeButtonState extends State<ShakeButton> with SingleTickerProviderStateMixin {
  final AnimationFabric _animationFabric = AnimationFabricImpl();
  Color _decorationColor = ColorsRes.green;
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController = _buildAnimationController();
    _animationController?.addStatusListener(_animationListener);
    super.initState();
  }

  AnimationController _buildAnimationController() {
    return AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
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
        animation: _animationFabric.createShake(_animationController!, 3),
        child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: _buildButtonDecoration(),
            margin: const EdgeInsets.only(left: 30, right: 30),
            child: _buildTextButton()),
        builder: (context, child) => _buildTransform(child));
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
          setNormalState();
          widget.onPressed?.call();
        },
        child: Text(widget._title,
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Roboto Thin', color: ColorsRes.green, fontSize: 20)));
  }

  Transform _buildTransform(Widget? child) {
    double shakeCount = 3;
    Animation shakeAnimation = _animationFabric.createShake(_animationController!, shakeCount);
    Offset offset = Offset(shakeAnimation.value * 10, 0);
    return Transform.translate(offset: offset, child: child);
  }

  void setNormalState() {
    _decorationColor = ColorsRes.green;
    setState(() => {});
  }

  void setErrorState() {
    _decorationColor = Colors.red;
    _shake();
    setState(() => {});
  }

  void _shake() async {
    _animationController?.forward();
  }
}
