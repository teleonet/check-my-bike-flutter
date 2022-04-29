import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../resources/colors_res.dart';
import '../base/base_screen_state.dart';

class DetailsButton extends StatefulWidget {
  Function? _onPressed;

  DetailsButton({Function? onPressed, Key? key}) : super(key: key) {
    _onPressed = onPressed;
  }

  @override
  _DetailsButtonState createState() => _DetailsButtonState();
}

class _DetailsButtonState extends BaseScreenState<DetailsButton> {
  @override
  Widget build(BuildContext context) {
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
