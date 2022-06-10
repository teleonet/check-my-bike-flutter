import 'package:check_my_bike_flutter/presentation/dialogs/button_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class YesNoDialog extends ButtonDialog {
  final Function _pressedYes;
  final Function _pressedNo;

  YesNoDialog(this._pressedYes, this._pressedNo);

  @override
  List<Widget> getWidgets(BuildContext context) {
    return [
      _buildYesButton('common.yes'.tr(), context),
      const SizedBox(width: 20),
      _buildNoButton('common.no'.tr(), context)
    ];
  }

  Widget _buildYesButton(String title, BuildContext context) {
    return _buildButton(title, context, _pressedYes);
  }

  Widget _buildNoButton(String title, BuildContext context) {
    return _buildButton(title, context, _pressedNo);
  }

  Widget _buildButton(String title, BuildContext context, Function _onPressed) {
    return buildButton(title, onPressed: () {
      Navigator.pop(context);
      _onPressed.call();
    });
  }
}
