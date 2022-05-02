import 'package:check_my_bike_flutter/presentation/dialogs/button_dialog.dart';
import 'package:flutter/cupertino.dart';

class YesNoDialog extends ButtonDialog {
  final Function _onPressed;

  YesNoDialog(this._onPressed);

  @override
  List<Widget> getWidgets(BuildContext context) {
    return [_buildButton("YES", context), const SizedBox(width: 20), _buildButton("NO", context)];
  }

  Widget _buildButton(String title, BuildContext context) {
    return buildButton(title, onPressed: () {
      Navigator.pop(context);
      _onPressed.call();
    });
  }
}
