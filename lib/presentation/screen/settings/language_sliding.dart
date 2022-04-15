import 'package:flutter/cupertino.dart';

import '../../../resources/color_res.dart';
import '../base/base_screen_state.dart';

class LanguageSliding extends StatefulWidget {
  const LanguageSliding(this._callback, {Key? key}) : super(key: key);

  final Function(Language) _callback;

  @override
  _LanguageSlidingState createState() => _LanguageSlidingState();
}

class _LanguageSlidingState extends BaseScreenState<LanguageSliding> {
  int _currentLanguageIndex = 0;
  final List<Language> _languages = [];

  _LanguageSlidingState() {
    _buildLanguages();
  }

  void _buildLanguages() {
    _languages.add(const Language("ENG", 'assets/icons/ic_flag_eng.png'));
    _languages.add(const Language("UA", 'assets/icons/ic_flag_ua.png'));
    _languages.add(const Language("PL", 'assets/icons/ic_flag_pl.png'));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl(
        backgroundColor: ColorRes.dartGrey,
        thumbColor: ColorRes.endGradient,
        groupValue: _currentLanguageIndex,
        children: _buildWidgetMap(),
        onValueChanged: (currentLanguageIndex) {
          setState(() => _currentLanguageIndex = currentLanguageIndex as int);

          Language language = _languages[_currentLanguageIndex];
          widget._callback.call(language);
        });
  }

  Map<int, Widget> _buildWidgetMap() {
    Map<int, Widget> children = {};

    for (int index = 0; index < _languages.length; index++) {
      Language languageItem = _languages[index];
      children[index] = _buildLanguageWidget(index, languageItem);
    }

    return children;
  }

  Widget _buildLanguageWidget(int index, Language languageItem) {
    return Image.asset(
      languageItem._iconPath,
      height: 60,
      width: MediaQuery.of(context).size.width,
    );
  }
}

class Language {
  const Language(this._name, this._iconPath);

  final String _iconPath;

  get iconPath => _iconPath;

  final String _name;

  get name => _name;
}
