import 'dart:ui';

import 'package:check_my_bike_flutter/presentation/dialogs/language_dialog.dart';
import 'package:check_my_bike_flutter/presentation/dialogs/yes_no_dialog.dart';
import 'package:check_my_bike_flutter/presentation/screen/settings/settings_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../resources/color_res.dart';
import '../base/base_screen_state.dart';
import '../widgets/header.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends BaseScreenState<SettingsScreen> {
  bool _active = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Header("Settings"),
          const Spacer(),
          SettingsItem(
              Icons.language,
              "language",
              Text("eng",
                  style: TextStyle(fontFamily: 'Roboto Thin', color: ColorRes.green, fontSize: 20)),
              () => LanguageDialog((language) => print("pressed: language ${language.name}"))
                  .show(context, "Language")),
          const Padding(padding: EdgeInsets.only(top: 30)),
          SettingsItem(
              Icons.star,
              "clear favorites",
              Text("18",
                  style: TextStyle(fontFamily: 'Roboto Thin', color: ColorRes.green, fontSize: 20)),
              () => YesNoDialog(() => print("pressed: Clear favorites"))
                  .show(context, "Do you want to clear?")),
          const Padding(padding: EdgeInsets.only(top: 30)),
          SettingsItem(
              Icons.volume_up,
              "sounds",
              CupertinoSwitch(
                  onChanged: (active) {
                    setState(() {
                      _active = !_active;
                    });
                  },
                  thumbColor: ColorRes.divider,
                  trackColor: ColorRes.darkGreen,
                  activeColor: ColorRes.green,
                  value: _active),
              () => setState(() {
                    _active = !_active;
                  })),
          const Spacer(),
          Center(
              child: Text("build 1.0.0",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Roboto Thin', color: ColorRes.startGradient, fontSize: 10))),
        ]));
  }
}
