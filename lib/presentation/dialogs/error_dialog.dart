import 'package:check_my_bike_flutter/presentation/dialogs/button_dialog.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends ButtonDialog {
  static bool _isShowing = false;

  static bool isNotShowing() => !_isShowing;

  final String _text;
  final Function? onPressedOk;

  ErrorDialog(this._text, {this.onPressedOk}) {
    ErrorDialog._isShowing = true;
  }

  @override
  List<Widget> getWidgets(context) {
    return [_buildText(), _buildButton(context)];
  }

  Widget _buildText() {
    return Center(
        child: Text(_text,
            textAlign: TextAlign.center, style: buildTextStyle(fontWeight: FontWeight.normal)));
  }

  Widget _buildButton(BuildContext context) {
    return Center(
        child: buildButton("ok", onPressed: () {
      ErrorDialog._isShowing = false;
      Navigator.pop(context);
      onPressedOk?.call();
    }));
  }
}
