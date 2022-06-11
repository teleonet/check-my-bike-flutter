import 'package:flutter/cupertino.dart';

import '../../../domain/entity/language_entity.dart';
import '../../../resources/colors_res.dart';

class LanguageSliding extends StatefulWidget {
  final List<LanguageEntity> _languages;
  final LanguageEntity _selectedLanguage;
  final Function(LanguageEntity) _onChangedLanguage;
  int _currentIndex = 0;

  LanguageSliding(this._languages, this._selectedLanguage, this._onChangedLanguage, {Key? key})
      : super(key: key) {
    _currentIndex = _getCurrentIndex();
  }

  int _getCurrentIndex() {
    int currentIndex = 0;
    for (int index = 0; index < _languages.length; index++) {
      if (_languages[index].name == _selectedLanguage.name) {
        currentIndex = index;
        break;
      }
    }
    return currentIndex;
  }

  @override
  _LanguageSlidingState createState() => _LanguageSlidingState();
}

class _LanguageSlidingState extends State<LanguageSliding> {
  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl(
        backgroundColor: ColorsRes.darkGrey,
        thumbColor: ColorsRes.endGradient,
        groupValue: widget._currentIndex,
        children: _buildWidgetsMap(),
        onValueChanged: (currentLanguageIndex) {
          setState(() => widget._currentIndex = currentLanguageIndex as int);

          LanguageEntity language = widget._languages[widget._currentIndex];
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
