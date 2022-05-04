import 'package:flutter/cupertino.dart';

abstract class AnimatedRoute {
  final Duration _transitionDuration = const Duration(milliseconds: 400);
  final Widget _screen;

  AnimatedRoute(this._screen);

  PageRoute createRoute() {
    return PageRouteBuilder(
        transitionDuration: _transitionDuration,
        reverseTransitionDuration: _transitionDuration,
        pageBuilder: _createPageBuilder,
        transitionsBuilder: createTransactionBuilder);
  }

  Widget _createPageBuilder(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return _screen;
  }

  @protected
  Widget createTransactionBuilder(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child);
}
