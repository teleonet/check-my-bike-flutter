import 'package:check_my_bike_flutter/data/repository/default/default_repository.dart';
import 'package:check_my_bike_flutter/data/repository/manufacturer/manufacturer_repository.dart';
import 'package:check_my_bike_flutter/data/repository/settings/settings_repository.dart';
import 'package:check_my_bike_flutter/domain/bloc/settings/event/load_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/settings/event/settings_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/settings/state/global_progress_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/settings/state/initial_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/settings/state/loaded_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/settings/state/settings_state.dart';
import 'package:check_my_bike_flutter/domain/entity/bike_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/common_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/distance_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/language_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/manufacturer_entity.dart';
import 'package:isolate_bloc/isolate_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../data/repository/bike/bike_repository.dart';
import 'event/save_settings_event.dart';

class SettingsBloc extends IsolateBloc<SettingsEvent, SettingsState> {
  static init(ManufacturerRepository manufacturerRepository, BikeRepository bikeRepository,
      SettingsRepository settingsRepository, DefaultRepository defaultRepository) {
    register<SettingsBloc, SettingsState>(
        create: () => SettingsBloc(
            manufacturerRepository, bikeRepository, settingsRepository, defaultRepository));
  }

  final ManufacturerRepository _manufacturerRepository;
  final BikeRepository _bikeRepository;
  final SettingsRepository _settingsRepository;
  final DefaultRepository _defaultRepository;

  SettingsBloc(this._manufacturerRepository, this._bikeRepository, this._settingsRepository,
      this._defaultRepository)
      : super(InitialState());

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is SaveSettingsEvent) {
      emit(GlobalProgressState());
      await _saveSettings(
          event.distance, event.language, CommonEntity(false), event.clearFavorites);
      emit(await _buildLoadedState());
    } else if (event is LoadEvent) {
      emit(await _buildLoadedState());
    }
  }

  Future<void> _saveSettings(DistanceEntity distance, LanguageEntity language, CommonEntity common,
      bool clearFavorites) async {
    await _settingsRepository.saveDistanceToDatabase(distance);
    await _settingsRepository.saveLanguageToDatabase(language);
    await _settingsRepository.saveCommonToDatabase(common);

    if (clearFavorites) {
      await _bikeRepository.clearInDatabase();
      await _manufacturerRepository.clearInDatabase();
    }
  }

  Future<LoadedState> _buildLoadedState() async {
    List<LanguageEntity> defaultLanguages = await _defaultRepository.loadLanguages();
    List<DistanceEntity> defaultDistances = await _defaultRepository.loadDistances();

    LanguageEntity currentLanguage = await _settingsRepository.loadLanguageFromDatabase();
    DistanceEntity currentDistance = await _settingsRepository.loadDistanceFromDatabase();
    CommonEntity common = await _settingsRepository.loadCommonFromDatabase();
    String buildNumber = await _getBuildNumber();
    int countOfFavorites = await _getCountOfFavorites();

    return LoadedState(defaultLanguages, defaultDistances, currentLanguage, currentDistance,
        common.isFirstStart, buildNumber, countOfFavorites);
  }

  Future<String> _getBuildNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    return version + "." + buildNumber;
  }

  Future<int> _getCountOfFavorites() async {
    List<BikeEntity> bikes = await _bikeRepository.loadFromDatabase();
    List<ManufacturerEntity> manufacturers = await _manufacturerRepository.loadFromDatabase();
    return bikes.length + manufacturers.length;
  }
}
