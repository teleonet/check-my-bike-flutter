import 'package:check_my_bike_flutter/presentation/dialogs/button_dialog.dart';
import 'package:flutter/cupertino.dart';

import '../../extensions/base_extensions.dart';
import '../screen/settings/language_sliding.dart';

class LanguageDialog extends ButtonDialog {
  Language? _selectedLanguage;
  final Function(Language) _callback;

  LanguageDialog(this._callback);

  @override
  List<Widget> getWidgetsTemplateMethod(BuildContext context) {
    List<Widget> widgets = [];

    widgets.add(Center(child: LanguageSliding((language) {
      _selectedLanguage = language;
    })));

    widgets.add(const Padding(padding: EdgeInsets.only(top: 30)));

    widgets.add(Center(
        child: buildButton("Apply", onPressed: () {
      Navigator.pop(context);
      _selectedLanguage.isNotNull<Language>((value) => _callback.call(value));
    })));

    return widgets;
  }
}
