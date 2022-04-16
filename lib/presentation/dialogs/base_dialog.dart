import 'package:flutter/material.dart';

import '../../resources/colors_res.dart';

abstract class BaseDialog {
  List<Widget> getWidgetsTemplateMethod(BuildContext context);

  void show(BuildContext context, String title, {bool dismissTouchOutside = false}) {
    List<Widget> widgets = getWidgetsTemplateMethod(context);

    Widget dialog = _build(widgets, title);

    showDialog(
        barrierDismissible: dismissTouchOutside,
        context: context,
        builder: (_) {
          return dialog;
        });
  }

  Widget _build(List<Widget> widgets, String title) {
    return AlertDialog(
      title: _buildTitle(title),
      titlePadding: const EdgeInsets.only(top: 30),
      shape: _buildShapeBorder(),
      backgroundColor: ColorsRes.endGradient,
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.only(top: 20, bottom: 30),
      actions: widgets,
    );
  }

  Widget _buildTitle(String title) {
    return Text(title,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'Roboto Thin',
            color: ColorsRes.green,
            fontSize: 20,
            fontWeight: FontWeight.bold));
  }

  ShapeBorder _buildShapeBorder() {
    return RoundedRectangleBorder(
        side: BorderSide(width: 0.3, color: ColorsRes.green),
        borderRadius: const BorderRadius.all(Radius.circular(10)));
  }
}
