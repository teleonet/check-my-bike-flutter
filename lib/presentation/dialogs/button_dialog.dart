import 'package:check_my_bike_flutter/presentation/dialogs/base_dialog.dart';
import 'package:flutter/material.dart';

import '../../resources/colors_res.dart';

abstract class ButtonDialog extends BaseDialog {
  @protected
  Widget buildButton(String title, {Function? onPressed}) {
    return OutlinedButton(
        style: _buildStyle(),
        onPressed: () => onPressed?.call(),
        child: Text(title, style: buildTextStyle()));
  }

  ButtonStyle _buildStyle() {
    return ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.fromLTRB(15, 10, 15, 10)),
        side: MaterialStateProperty.all(_buildBorderSide()));
  }

  BorderSide _buildBorderSide() {
    return BorderSide(color: ColorsRes.green, width: 0.3, style: BorderStyle.solid);
  }

  @protected
  TextStyle buildTextStyle({FontWeight fontWeight = FontWeight.bold}) {
    return TextStyle(
        fontFamily: 'Roboto Thin', color: ColorsRes.green, fontSize: 20, fontWeight: fontWeight);
  }
}
