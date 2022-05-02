import 'dart:ui';

import 'package:check_my_bike_flutter/presentation/dialogs/button_dialog.dart';
import 'package:flutter/material.dart';

class OKDialog extends ButtonDialog {
  final String _text;
  Function? _callback;

  OKDialog(this._text, {Function? callback}) {
    _callback = callback;
  }

  @override
  List<Widget> getWidgets(context) {
    return [_buildText(), _buildButton(context)];
  }

  Widget _buildText() {
    return Center(child: Text(_text, style: buildTextStyle(fontWeight: FontWeight.normal)));
  }

  Widget _buildButton(BuildContext context) {
    return Center(
        child: buildButton("ok", onPressed: () {
      Navigator.pop(context);
      _callback?.call();
    }));
  }
}
