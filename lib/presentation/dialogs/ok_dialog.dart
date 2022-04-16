import 'package:check_my_bike_flutter/presentation/dialogs/button_dialog.dart';
import 'package:flutter/material.dart';

import '../../resources/color_res.dart';

class OKDialog extends ButtonDialog {
  final String _text;
  Function? _callback;

  OKDialog(this._text, {Function? callback}) {
    _callback = callback;
  }

  @override
  List<Widget> getWidgetsTemplateMethod(context) {
    List<Widget> widgets = [];

    widgets.add(Center(
        child: Text(_text,
            style: TextStyle(fontFamily: 'Roboto Thin', color: ColorRes.green, fontSize: 20))));

    widgets.add(const Padding(padding: EdgeInsets.only(top: 30)));

    widgets.add(Center(
        child: buildButton("ok", onPressed: () {
      Navigator.pop(context);
      _callback?.call();
    })));

    return widgets;
  }
}
