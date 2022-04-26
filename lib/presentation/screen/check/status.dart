import 'package:flutter/material.dart';

import '../../../resources/colors_res.dart';
import '../base/base_screen_state.dart';

class Status extends StatefulWidget {
  final bool _stolen;
  Function? _onPressed;

  Status(this._stolen, {Function? onPressed, Key? key}) : super(key: key) {
    _onPressed = onPressed;
  }

  @override
  _StatusState createState() => _StatusState();
}

class _StatusState extends BaseScreenState<Status> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _animationController?.repeat(reverse: true);

    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        color: Colors.transparent,
        child: Column(children: [
          _buildTextStatus(),
          widget._stolen ? _buildDetailsButton() : const SizedBox.shrink()
        ]));
  }

  Widget _buildTextStatus() {
    return widget._stolen
        ? FadeTransition(opacity: _animationController!, child: _buildText())
        : _buildText();
  }

  Text _buildText() {
    return Text(widget._stolen ? "Stolen" : "Not stolen",
        style: _buildTextStyle(widget._stolen ? 70 : 60));
  }

  TextStyle _buildTextStyle(double fontSize) {
    return TextStyle(
        decoration: TextDecoration.none,
        fontWeight: FontWeight.bold,
        color: widget._stolen ? Colors.red : ColorsRes.green,
        fontFamily: 'Roboto Thin',
        fontSize: fontSize);
  }

  Widget _buildDetailsButton() {
    return Container(
        margin: const EdgeInsets.only(left: 30, right: 30, top: 20),
        decoration: _buildButtonDecoration(),
        width: MediaQuery.of(context).size.width,
        child: _buildTextButton());
  }

  Decoration _buildButtonDecoration() {
    return BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: ColorsRes.green),
        borderRadius: const BorderRadius.all(Radius.elliptical(10, 10)));
  }

  TextButton _buildTextButton() {
    return TextButton(
      onPressed: () => widget._onPressed?.call(),
      child: Text("Details",
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'Roboto Thin', color: ColorsRes.green, fontSize: 20)),
    );
  }
}
