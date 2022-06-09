import 'package:check_my_bike_flutter/data/mapper/common_mapper.dart';
import 'package:check_my_bike_flutter/data/mapper/distance_mapper.dart';
import 'package:check_my_bike_flutter/data/mapper/language_mapper.dart';
import 'package:check_my_bike_flutter/data/repository/settings/settings_repository.dart';
import 'package:check_my_bike_flutter/data/source/database/dto/common_db_dto.dart';
import 'package:check_my_bike_flutter/data/source/database/dto/language_db_dto.dart';
import 'package:check_my_bike_flutter/domain/entity/common_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/distance_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/language_entity.dart';

import '../../source/database/database_gateway.dart';
import '../../source/database/dto/distance_db_dto.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final DatabaseGateway _databaseGateway;

  SettingsRepositoryImpl(this._databaseGateway);

  @override
  Future<DistanceEntity> loadDistanceFromDatabase() async {
    DistanceDbDTO? dto = await _databaseGateway.loadDistance();
    return DistanceMapper.dtoToEntity(dto);
  }

  @override
  Future<LanguageEntity> loadLanguageFromDatabase() async {
    LanguageDbDTO? dto = await _databaseGateway.loadLanguage();
    return LanguageMapper.dtoToEntity(dto);
  }

  @override
  Future<void> saveDistanceToDatabase(DistanceEntity entity) async {
    DistanceDbDTO dto = DistanceMapper.entityToDto(entity);
    await _databaseGateway.saveDistance(dto);
  }

  @override
  Future<void> saveLanguageToDatabase(LanguageEntity entity) async {
    LanguageDbDTO dto = LanguageMapper.entityToDto(entity);
    await _databaseGateway.saveLanguage(dto);
  }

  @override
  Future<CommonEntity> loadCommonFromDatabase() async {
    CommonDbDTO? dto = await _databaseGateway.loadCommon();
    return CommonMapper.dtoToEntity(dto);
  }

  @override
  Future<void> saveCommonToDatabase(CommonEntity entity) async {
    CommonDbDTO dto = CommonMapper.entityToDto(entity);
    await _databaseGateway.saveCommon(dto);
  }

  @override
  Future<void> clearInDatabase() async {
    await _databaseGateway.clearCommon();
    await _databaseGateway.clearLanguage();
    await _databaseGateway.clearDistance();
  }
}
