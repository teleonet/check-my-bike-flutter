import 'package:check_my_bike_flutter/domain/bloc/settings/event/load_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/settings/settings_bloc.dart';
import 'package:check_my_bike_flutter/domain/bloc/settings/state/initial_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/settings/state/loaded_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/settings/state/settings_state.dart';
import 'package:check_my_bike_flutter/domain/entity/distance_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/language_entity.dart';
import 'package:check_my_bike_flutter/presentation/dialogs/distance/distance_setting_dialog.dart';
import 'package:check_my_bike_flutter/presentation/dialogs/language/language_dialog.dart';
import 'package:check_my_bike_flutter/presentation/dialogs/yes_no_dialog.dart';
import 'package:check_my_bike_flutter/presentation/screen/settings/info/info_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/settings/settings_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:isolate_bloc/isolate_bloc.dart';

import '../../../domain/bloc/settings/event/save_settings_event.dart';
import '../../../domain/bloc/settings/state/global_progress_state.dart';
import '../../../resources/colors_res.dart';
import '../../widgets/header.dart';

class SettingsScreen extends StatelessWidget {
  List<LanguageEntity> _languages = [];
  List<DistanceEntity> _distances = [];
  LanguageEntity? _currentLanguage;
  DistanceEntity? _currentDistance;
  int _favoritesCount = 0;
  bool _clearFavorites = false;
  String? _buildNumber = "";

  @override
  Widget build(BuildContext context) {
    return IsolateBlocProvider<SettingsBloc, SettingsState>(
        child: IsolateBlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      state is InitialState ? _loadSettings(context) : null;
      if (state is LoadedState) {
        _languages = state.languages;
        _distances = state.distances;
        _currentLanguage = state.currentLanguage;
        _currentDistance = state.currentDistance;
        _favoritesCount = state.countOfFavorites;
        _buildNumber = state.buildNumber;
      }
      return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Header('settings_screen.settings'.tr()),
            const Spacer(),
            state is InitialState || state is GlobalProgressState
                ? _buildGlobalProgressIndicator(context)
                : Column(children: [
                    SettingsItem(Icons.language, 'settings_screen.language'.tr(),
                        _buildText(_currentLanguage?.name ?? ""),
                        onPressed: () => _showLanguageDialog(context)),
                    _buildPadding(),
                    SettingsItem(Icons.star, 'settings_screen.clear_favorites'.tr(),
                        _buildText(_favoritesCount.toString()),
                        onPressed: () =>
                            _favoritesCount > 0 ? _showClearFavoritesDialog(context) : null),
                    _buildPadding(),
                    SettingsItem(
                        Icons.info, 'settings_screen.info'.tr(), _buildText(_buildNumber ?? ""),
                        onPressed: () => InfoScreen.show(context)),
                    _buildPadding(),
                    SettingsItem(Icons.sync_alt, 'settings_screen.distance'.tr(),
                        _buildText(_currentDistance?.type ?? ""),
                        onPressed: () => _showDistanceTypeDialog(context))
                  ]),
            const Spacer()
          ]));
    }, buildWhen: (prev, next) {
      return next is LoadedState || next is GlobalProgressState;
    }));
  }

  Widget _buildGlobalProgressIndicator(BuildContext context) {
    return Transform.scale(
        scale: 2, child: const Center(child: CircularProgressIndicator(strokeWidth: 0.4)));
  }

  Widget _buildPadding() {
    return const Padding(padding: EdgeInsets.only(top: 30));
  }

  Text _buildText(String title) {
    return Text(title,
        style: TextStyle(fontFamily: 'Roboto Thin', color: ColorsRes.green, fontSize: 20));
  }

  void _showLanguageDialog(BuildContext context) {
    LanguageDialog(_languages, _currentLanguage!, (language) {
      String languageName = language.name!.replaceAll('ua', 'lo');
      if (_currentLanguage?.name != language.name) {
        context.setLocale(Locale(languageName));
      }
      _currentLanguage = language;
      _saveSettings(context);
    }).show(context, 'settings_screen.language'.tr(), dismissTouchOutside: true);
  }

  void _showClearFavoritesDialog(BuildContext context) {
    YesNoDialog(() {
      _clearFavorites = true;
      _saveSettings(context);
    }, () {})
        .show(context, 'settings_screen.ask_clear_favorites'.tr());
  }

  void _showDistanceTypeDialog(BuildContext context) {
    DistanceSettingDialog(_distances, _currentDistance!, (distance) {
      _currentDistance = distance;
      _saveSettings(context);
    }).show(context, 'settings_screen.distance'.tr());
  }

  void _saveSettings(BuildContext context) {
    context
        .isolateBloc<SettingsBloc, SettingsState>()
        .add(SaveSettingsEvent(_currentLanguage!, _currentDistance!, _clearFavorites));
  }

  void _loadSettings(BuildContext context) {
    context.isolateBloc<SettingsBloc, SettingsState>().add(LoadEvent());
  }
}
