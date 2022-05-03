import 'dart:ui';

import 'package:flutter/material.dart';

import '../../base/base_screen_state.dart';

class SplashScreen extends StatefulWidget {
  static show(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SplashScreen()));
  }

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseScreenState<SplashScreen> {
  _SplashScreenState() {
    showMainScreen();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[_buildBackgroundImage(), _buildBlurFilter()],
      ),
    );
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

  void showMainScreen() {
    // Timer(const Duration(seconds: 3), () => MainScreen.show(context));
  }
}
