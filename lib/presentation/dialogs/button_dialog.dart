import 'package:flutter/material.dart';

import '../../resources/color_res.dart';
import '../screen/settings/language_sliding.dart';

class ButtonDialog {
  //todo: need to refactor in pattern "template method"

  ButtonDialog._();

  static showLanguages(BuildContext context, String title, Function(Language? language) onPressed) {
    Language? selectedLanguage;

    List<Widget> widgets = [];

    widgets.add(Center(child: LanguageSliding((language) {
      selectedLanguage = language;
    })));

    widgets.add(const Padding(padding: EdgeInsets.only(top: 30)));

    widgets.add(Center(
        child: _buildButton("Apply", onPressed: () {
      onPressed.call(selectedLanguage);
      Navigator.pop(context);
    })));

    show(context, title, widgets);
  }

  static showYesNo(BuildContext context, String title, Function onYesPressed) {
    showTwoButtons(context, title, "yes", "no", onLeftPressed: onYesPressed);
  }

  static showOk(BuildContext context, String title) {
    showOneButton(context, title, "ok");
  }

  static showTwoButtons(
      BuildContext context, String title, String leftButtonTitle, String rightButtonTitle,
      {Function? onLeftPressed,
      Function? onRightPressed,
      bool autoDismiss = false,
      bool leftPressedDismiss = true,
      bool rightPressedDismiss = true}) {
    List<Widget> actionWidgets = [];

    actionWidgets.add(_buildButton(leftButtonTitle, onPressed: () {
      if (leftPressedDismiss) {
        Navigator.pop(context);
      }
      onLeftPressed?.call();
    }));

    actionWidgets.add(const SizedBox(width: 20));

    actionWidgets.add(_buildButton(rightButtonTitle, onPressed: () {
      if (rightPressedDismiss) {
        Navigator.pop(context);
      }
      onRightPressed?.call();
    }));

    show(context, title, actionWidgets, autoDismiss: autoDismiss);
  }

  static showOneButton(BuildContext context, String title, String buttonTitle,
      {Function? onPressed, bool autoDismiss = false, bool pressedDismiss = true}) {
    List<Widget> actionWidgets = [];

    actionWidgets.add(_buildButton(buttonTitle, onPressed: () {
      if (pressedDismiss) {
        Navigator.pop(context);
      }
      onPressed?.call();
    }));

    show(context, title, actionWidgets);
  }

  static Widget _buildButton(String title, {Function? onPressed}) {
    return OutlinedButton(
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.fromLTRB(15, 10, 15, 10)),
          side: MaterialStateProperty.all(
              BorderSide(color: ColorRes.green, width: 0.3, style: BorderStyle.solid))),
      onPressed: () => onPressed?.call(),
      child: Text(title,
          style: TextStyle(
              fontFamily: 'Roboto Thin',
              color: ColorRes.green,
              fontSize: 20,
              fontWeight: FontWeight.bold)),
    );
  }

  static show(BuildContext context, String title, List<Widget> actionsWidgets,
      {bool autoDismiss = false}) {
    showDialog(
        barrierDismissible: autoDismiss,
        context: context,
        builder: (_) {
          return AlertDialog(
            title: _buildTitle(title),
            titlePadding: const EdgeInsets.only(top: 30),
            shape: _buildShapeBorder(),
            backgroundColor: ColorRes.endGradient,
            actionsAlignment: MainAxisAlignment.center,
            actionsPadding: const EdgeInsets.only(top: 20, bottom: 30),
            actions: actionsWidgets,
          );
        });
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

  static ShapeBorder _buildShapeBorder() {
    return RoundedRectangleBorder(
        side: BorderSide(width: 0.3, color: ColorRes.green),
        borderRadius: const BorderRadius.all(Radius.circular(10)));
  }
}
