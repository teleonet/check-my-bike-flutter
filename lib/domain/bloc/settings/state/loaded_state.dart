import 'package:check_my_bike_flutter/domain/bloc/settings/state/settings_state.dart';
import 'package:check_my_bike_flutter/domain/entity/distance_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/language_entity.dart';

class LoadedState extends SettingsState {
  final List<LanguageEntity> _languages;

  get languages => _languages;

  final List<DistanceEntity> _distances;

  get distances => _distances;

  final LanguageEntity _currentLanguage;

  get currentLanguage => _currentLanguage;

  final DistanceEntity _currentDistance;

  get currentDistance => _currentDistance;

  final bool _isFirstStart;

  get isFirstStart => _isFirstStart;

  final bool _isAvailableServer;

  get isAvailableServer => _isAvailableServer;

  final String _buildNumber;

  get buildNumber => _buildNumber;

  final int _countOfFavorites;

  get countOfFavorites => _countOfFavorites;

  LoadedState(this._languages, this._distances, this._currentLanguage, this._currentDistance,
      this._isFirstStart, this._isAvailableServer, this._buildNumber, this._countOfFavorites);
}
