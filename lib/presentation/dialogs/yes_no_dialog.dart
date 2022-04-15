import 'package:check_my_bike_flutter/presentation/dialogs/button_dialog.dart';
import 'package:flutter/cupertino.dart';

class YesNoDialog extends ButtonDialog {
  final Function _onPressed;

  YesNoDialog(this._onPressed);

  @override
  List<Widget> getWidgetsTemplateMethod(BuildContext context) {
    List<Widget> widgets = [];

    widgets.add(buildButton("YES", onPressed: () {
      Navigator.pop(context);
      _onPressed.call();
    }));

    widgets.add(const SizedBox(width: 20));

    widgets.add(buildButton("NO", onPressed: () => Navigator.pop(context)));

    return widgets;
  }
}
