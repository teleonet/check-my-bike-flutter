import 'package:check_my_bike_flutter/domain/bloc/settings/event/settings_event.dart';
import 'package:check_my_bike_flutter/domain/entity/language_entity.dart';

class ChangeLanguageEvent extends SettingsEvent {
  final LanguageEntity _language;

  get language => _language;

  ChangeLanguageEvent(this._language);
}
