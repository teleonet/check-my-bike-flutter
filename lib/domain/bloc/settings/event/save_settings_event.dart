import 'package:check_my_bike_flutter/domain/bloc/settings/event/settings_event.dart';
import 'package:check_my_bike_flutter/domain/entity/distance_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/language_entity.dart';

class SaveSettingsEvent extends SettingsEvent {
  final LanguageEntity _language;

  get language => _language;

  final DistanceEntity _distance;

  get distance => _distance;

  final bool _clearFavorites;

  get clearFavorites => _clearFavorites;

  SaveSettingsEvent(this._language, this._distance, this._clearFavorites);
}
