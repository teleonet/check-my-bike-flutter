import 'package:check_my_bike_flutter/presentation/base/base_screen_state.dart';
import 'package:flutter/material.dart';

import '../../../resources/colors_res.dart';

class BorderedButton extends StatefulWidget {
  final String _title;
  Function? _onPressed;

  BorderedButton(this._title, {Function? onPressed, Key? key}) : super(key: key) {
    _onPressed = onPressed;
  }

  @override
  BorderedButtonState createState() => BorderedButtonState();
}

enum Status { normal, error }

class BorderedButtonState extends BaseScreenState<BorderedButton> {
  Color _decorationColor = ColorsRes.green;

  void setButtonStatus(Status status) {
    switch (status) {
      case Status.normal:
        _decorationColor = ColorsRes.green;
        break;
      case Status.error:
        _decorationColor = Colors.red;
        break;
    }
    setState(() => {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 30, right: 30),
        decoration: _buildButtonDecoration(),
        width: MediaQuery.of(context).size.width,
        child: _buildTextButton());
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
          setButtonStatus(Status.normal);
          widget._onPressed?.call();
        },
        child: Text(widget._title,
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Roboto Thin', color: ColorsRes.green, fontSize: 20)));
  }
}
