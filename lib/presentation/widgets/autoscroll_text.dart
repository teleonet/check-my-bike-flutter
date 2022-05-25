import 'dart:async';

import 'package:flutter/material.dart';

import '../base/base_screen_state.dart';

class AutoScrollText extends StatefulWidget {
  final String _text;
  final double _width;
  final double? fontSize;
  final Color? textColor;
  final TextStyle? textStyle;

  const AutoScrollText(this._text, this._width,
      {this.fontSize, this.textColor, this.textStyle, Key? key})
      : super(key: key);

  @override
  _AutoScrollTextState createState() => _AutoScrollTextState();
}

class _AutoScrollTextState extends BaseScreenState<AutoScrollText> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scroll());
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget._width,
        child: SingleChildScrollView(
          child: Text(widget._text, style: widget.textStyle ?? _buildTextStyle()),
          scrollDirection: Axis.horizontal,
          controller: scrollController,
        ));
  }

  TextStyle _buildTextStyle() {
    return TextStyle(
        fontFamily: 'Roboto Thin',
        color: widget.textColor ?? Colors.white,
        fontSize: widget.fontSize ?? 20,
        decoration: TextDecoration.none);
  }

  void _scroll() async {
    while (scrollController.hasClients) {
      await _scrollToRight();
      await _scrollTolLeft();
    }
  }

  Future<void> _scrollToRight() async {
    return _scrollTo(scrollController.position.maxScrollExtent);
  }

  Future<void> _scrollTolLeft() async {
    return _scrollTo(0.0);
  }

  Future<void> _scrollTo(double offset) async {
    await Future.delayed(const Duration(milliseconds: 1500));

    if (scrollController.hasClients) {
      return scrollController.animateTo(offset,
          duration: const Duration(milliseconds: 1500), curve: Curves.easeOut);
    }
  }
}
