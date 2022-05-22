import 'package:check_my_bike_flutter/data/data_source/database/dto/common_db_dto.dart';
import 'package:check_my_bike_flutter/data/data_source/database/dto/language_db_dto.dart';
import 'package:check_my_bike_flutter/data/mapper/settings_mapper.dart';
import 'package:check_my_bike_flutter/data/repository/settings/settings_repository.dart';
import 'package:check_my_bike_flutter/domain/entity/settings_entity.dart';

import '../../data_source/database/database_gateway.dart';
import '../../data_source/database/dto/distance_db_dto.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final DatabaseGateway _databaseGateway;

  SettingsRepositoryImpl(this._databaseGateway);

  @override
  Future<SettingsEntity> loadFromDatabase() async {
    DistanceDbDTO? distance = await _databaseGateway.loadDistance();
    CommonDbDTO? common = await _databaseGateway.loadCommon();
    LanguageDbDTO? language = await _databaseGateway.loadLanguage();

    return SettingsMapper.databaseToEntity(distance, common, language);
  }

  @override
  Future<void> saveToDatabase(SettingsEntity entity) async {
    await _databaseGateway.saveDistance(SettingsMapper.entityToDistanceDatabase(entity));
    await _databaseGateway.saveCommon(SettingsMapper.entityToCommonDatabase(entity));
    await _databaseGateway.saveLanguage(SettingsMapper.entityToLanguageDatabase(entity));
  }

  @override
  Future<void> clearInDatabase() async {
    await _databaseGateway.clearCommon();
    await _databaseGateway.clearLanguage();
    await _databaseGateway.clearDistance();
  }
}
