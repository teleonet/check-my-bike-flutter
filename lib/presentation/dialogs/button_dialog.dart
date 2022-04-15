import 'package:check_my_bike_flutter/presentation/dialogs/base_dialog.dart';
import 'package:flutter/material.dart';

import '../../resources/color_res.dart';

abstract class ButtonDialog extends BaseDialog {
  @protected
  Widget buildButton(String title, {Function? onPressed}) {
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
}
