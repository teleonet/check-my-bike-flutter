import 'package:flutter/material.dart';

import '../base/base_screen_state.dart';

class FlashingText extends StatefulWidget {
  final String _text;
  final Color _color;
  final double fontSize;

  const FlashingText(this._text, this._color, {this.fontSize = 70, Key? key}) : super(key: key);

  @override
  _FlashingTextState createState() => _FlashingTextState();
}

class _FlashingTextState extends BaseScreenState<FlashingText> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController = _buildAnimationController();
    _animationController?.repeat(reverse: true);
    super.initState();
  }

  AnimationController _buildAnimationController() {
    return AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: _animationController!, child: Text(widget._text, style: _buildTextStyle()));
  }

  TextStyle _buildTextStyle() {
    return TextStyle(
        decoration: TextDecoration.none,
        fontWeight: FontWeight.bold,
        color: widget._color,
        fontFamily: 'Roboto Thin',
        fontSize: widget.fontSize);
  }
}
