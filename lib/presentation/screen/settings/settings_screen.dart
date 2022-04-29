import 'package:check_my_bike_flutter/presentation/dialogs/language_dialog.dart';
import 'package:check_my_bike_flutter/presentation/dialogs/yes_no_dialog.dart';
import 'package:check_my_bike_flutter/presentation/models/language.dart';
import 'package:check_my_bike_flutter/presentation/screen/settings/settings_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../resources/colors_res.dart';
import '../base/base_screen_state.dart';
import '../widgets/header.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends BaseScreenState<SettingsScreen> {
  bool _active = false;

  //todo: need move, only for development
  List<Language> _buildLanguages() {
    List<Language> languages = [];

    languages.add(const Language("ENG", 'assets/icons/ic_flag_eng.png'));
    languages.add(const Language("UA", 'assets/icons/ic_flag_ua.png'));
    languages.add(const Language("PL", 'assets/icons/ic_flag_pl.png'));

    return languages;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Header("Settings"),
          const Spacer(),
          SettingsItem(Icons.language, "language", _buildText("eng"),
              onPressed: () => _showLanguageDialog()),
          _buildPadding(),
          SettingsItem(Icons.star, "clear favorites", _buildText("18"),
              onPressed: () => _showClearFavoritesDialog()),
          _buildPadding(),
          SettingsItem(Icons.volume_up, "sounds", _buildSwitch(),
              onPressed: () => setState(() => _active = !_active)),
          _buildPadding(),
          SettingsItem(Icons.info, "info", _buildText("1.0.0"), onPressed: () {}),
          const Spacer(),
        ]));
  }

  Widget _buildPadding() {
    return const Padding(padding: EdgeInsets.only(top: 30));
  }

  Text _buildText(String title) {
    return Text(title,
        style: TextStyle(fontFamily: 'Roboto Thin', color: ColorsRes.green, fontSize: 20));
  }

  CupertinoSwitch _buildSwitch() {
    return CupertinoSwitch(
        onChanged: (active) => setState(() => _active = !_active),
        thumbColor: ColorsRes.divider,
        trackColor: ColorsRes.darkGreen,
        activeColor: ColorsRes.green,
        value: _active);
  }

  void _showLanguageDialog() {
    LanguageDialog(_buildLanguages(), _buildLanguages()[1],
            (language) => print("pressed: language ${language.name}"))
        .show(context, "Language", dismissTouchOutside: true);
  }

  void _showClearFavoritesDialog() {
    YesNoDialog(() => print("pressed: Clear favorites"))
        .show(context, "Do you want to clear all favorites ?");
  }
}
