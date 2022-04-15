import 'package:check_my_bike_flutter/presentation/dialogs/button_dialog.dart';
import 'package:flutter/material.dart';

class OKDialog extends ButtonDialog {
  final String _buttonTitle;
  Function? _callback;

  OKDialog(this._buttonTitle, {Function? callback}) {
    _callback = callback;
  }

  @override
  List<Widget> getWidgetsTemplateMethod(context) {
    List<Widget> widgets = [];

    widgets.add(buildButton(_buttonTitle, onPressed: () {
      Navigator.pop(context);
      _callback?.call();
    }));

    return widgets;
  }
}
