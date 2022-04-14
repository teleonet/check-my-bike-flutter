import 'package:flutter/material.dart';

import '../../resources/color_res.dart';

class TwoButtonsDialog {
  TwoButtonsDialog._();

  static show(BuildContext context, String title,
      {Function? onLeftPressed,
      Function? onRightPressed,
      bool autoDismiss = false,
      bool leftPressedClose = true,
      bool rightPressedClose = true}) {
    showDialog(
        barrierDismissible: autoDismiss,
        context: context,
        builder: (_) {
          return AlertDialog(
            title: _buildTitle(title),
            titlePadding: const EdgeInsets.only(top: 30),
            shape: _buildBorder(),
            backgroundColor: ColorRes.endGradient,
            actionsAlignment: MainAxisAlignment.center,
            actionsPadding: const EdgeInsets.only(top: 20, bottom: 30),
            actions: <Widget>[
              _buildButton("yes", onPressed: () {
                if (leftPressedClose) {
                  Navigator.pop(context);
                }
                onLeftPressed?.call();
              }),
              const SizedBox(width: 20),
              _buildButton("no", onPressed: () {
                if (rightPressedClose) {
                  Navigator.pop(context);
                }
                onRightPressed?.call();
              }),
            ],
          );
        });
  }

  static Widget _buildButton(String title, {Function? onPressed}) {
    return OutlinedButton(
      style: ButtonStyle(
          padding:
              MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.only(top: 10, bottom: 10)),
          side: MaterialStateProperty.all(
              BorderSide(color: ColorRes.green, width: 0.3, style: BorderStyle.solid))),
      onPressed: () => onPressed?.call(),
      child: Text(title,
          style: TextStyle(fontFamily: 'Roboto Thin', color: ColorRes.green, fontSize: 20)),
    );
  }

  static Widget _buildTitle(String title) {
    return Text(title,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'Roboto Thin',
            color: ColorRes.green,
            fontSize: 20,
            fontWeight: FontWeight.bold));
  }

  static ShapeBorder _buildBorder() {
    return RoundedRectangleBorder(
        side: BorderSide(width: 0.3, color: ColorRes.green),
        borderRadius: const BorderRadius.all(Radius.circular(10)));
  }
}
