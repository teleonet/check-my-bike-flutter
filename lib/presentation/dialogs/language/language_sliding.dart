import 'package:flutter/cupertino.dart';

import '../../../resources/colors_res.dart';
import '../../base/base_screen_state.dart';
import '../../../domain/entity/language_entity.dart';

class LanguageSliding extends StatefulWidget {
  final List<LanguageEntity> _languages;
  final LanguageEntity _selectedLanguage;
  final Function(LanguageEntity) _onChangedLanguage;
  int _currentLanguageIndex = 0;

  LanguageSliding(this._languages, this._selectedLanguage, this._onChangedLanguage, {Key? key})
      : super(key: key) {
    _currentLanguageIndex = _languages.indexWhere((item) => item.name == _selectedLanguage.name);
  }

  @override
  _LanguageSlidingState createState() => _LanguageSlidingState();
}

class _LanguageSlidingState extends BaseScreenState<LanguageSliding> {
  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl(
        backgroundColor: ColorsRes.darkGrey,
        thumbColor: ColorsRes.endGradient,
        groupValue: widget._currentLanguageIndex,
        children: _buildWidgetsMap(),
        onValueChanged: (currentLanguageIndex) {
          setState(() => widget._currentLanguageIndex = currentLanguageIndex as int);

          LanguageEntity language = widget._languages[widget._currentLanguageIndex];
          widget._onChangedLanguage.call(language);
        });
  }

  Map<int, Widget> _buildWidgetsMap() {
    Map<int, Widget> children = {};

    for (int index = 0; index < widget._languages.length; index++) {
      LanguageEntity languageItem = widget._languages[index];
      children[index] = _buildWidget(index, languageItem);
    }

    return children;
  }

  Widget _buildWidget(int index, LanguageEntity languageItem) {
    return Image.asset(
      languageItem.iconPath,
      height: 60,
      width: MediaQuery.of(context).size.width,
    );
  }
}