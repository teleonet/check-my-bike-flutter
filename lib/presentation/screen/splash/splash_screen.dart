import 'dart:async';
import 'dart:ui';

import 'package:check_my_bike_flutter/presentation/screen/main/main_screen.dart';
import 'package:flutter/material.dart';

import '../../../resources/colors_res.dart';
import '../../base/base_screen_state.dart';
import '../../widgets/animation/fabric/animation_fabric.dart';

class SplashScreen extends StatefulWidget {
  static show(BuildContext context, AnimationFabric animationFabric) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreen(animationFabric)));
  }

  final AnimationFabric _animationFabric;

  const SplashScreen(this._animationFabric, {Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseScreenState<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController = _buildAnimationController();
    _animationController?.addStatusListener(_animationListener);
    _animationController?.forward();

    super.initState();
  }

  AnimationController _buildAnimationController() {
    return AnimationController(vsync: this, duration: const Duration(milliseconds: 1250));
  }

  @override
  void dispose() {
    _animationController?.removeStatusListener(_animationListener);
    _animationController?.dispose();

    super.dispose();
  }

  void _animationListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      Timer(const Duration(microseconds: 100), () => MainScreen.show(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(alignment: Alignment.center, children: <Widget>[
          _buildBackgroundImage(),
          _buildBlurFilter(),
          Positioned.fill(
              bottom: 120,
              child: _buildAnimatedText(
                  widget._animationFabric.createTopBottom(_animationController!), "Check")),
          _buildAnimatedText(widget._animationFabric.createLeftRight(_animationController!), "my"),
          Positioned.fill(
              top: 150,
              child: _buildAnimatedText(
                  widget._animationFabric.createBottomTop(_animationController!), "bike"))
        ]));
  }

  Widget _buildBackgroundImage() {
    return Image.asset(
      'assets/images/splash_bg.jpg',
      height: double.infinity,
      width: double.infinity,
      fit: BoxFit.fitHeight,
    );
  }

  Widget _buildBlurFilter() {
    return BackdropFilter(
      child: Container(
        color: Colors.black12,
      ),
      filter: ImageFilter.blur(sigmaY: 3, sigmaX: 3),
    );
  }

  Widget _buildAnimatedText(Animation<Offset> animation, String text) {
    return SlideTransition(
      position: animation,
      child: Center(child: Text(text, style: _buildTextStyle())),
    );
  }

  TextStyle _buildTextStyle() {
    return TextStyle(
        fontFamily: 'Roboto Thin',
        color: ColorsRes.greenOpacity70,
        fontSize: 85,
        shadows: [Shadow(color: ColorsRes.greenOpacity70, blurRadius: 10)],
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.none);
  }
}
