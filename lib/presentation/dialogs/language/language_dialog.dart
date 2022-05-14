import 'package:check_my_bike_flutter/presentation/dialogs/button_dialog.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/entity/language_entity.dart';
import 'language_sliding.dart';

class LanguageDialog extends ButtonDialog {
  final Function(LanguageEntity) _callback;
  final List<LanguageEntity> _languages;
  LanguageEntity _selectedLanguage;

  LanguageDialog(this._languages, this._selectedLanguage, this._callback);

  @override
  List<Widget> getWidgets(BuildContext context) {
    return [_buildLanguageSliding(), _buildButton(context)];
  }

  Widget _buildLanguageSliding() {
    return Center(
        child: LanguageSliding(
            _languages, _selectedLanguage, (language) => _selectedLanguage = language));
  }

  Widget _buildButton(BuildContext context) {
    return Center(
        child: buildButton("Apply", onPressed: () {
      Navigator.pop(context);
      _callback.call(_selectedLanguage);
    }));
  }
}
