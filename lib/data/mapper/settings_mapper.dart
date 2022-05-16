import 'package:check_my_bike_flutter/data/data_source/database/dto/common_db_dto.dart';
import 'package:check_my_bike_flutter/data/data_source/database/dto/distance_db_dto.dart';
import 'package:check_my_bike_flutter/data/data_source/database/dto/language_db_dto.dart';
import 'package:check_my_bike_flutter/domain/entity/settings_entity.dart';

class SettingsMapper {
  SettingsMapper._();

  static DistanceDbDTO entityToDistanceDatabase(SettingsEntity entity) {
    DistanceDbDTO dto = DistanceDbDTO();
    dto.type = entity.distanceType;
    dto.title = entity.distanceTitle;

    return dto;
  }

  static CommonDbDTO entityToCommonDatabase(SettingsEntity entity) {
    CommonDbDTO dto = CommonDbDTO();
    dto.isFirstStart = entity.isFirstStart;

    return dto;
  }

  static LanguageDbDTO entityToLanguageDatabase(SettingsEntity entity) {
    LanguageDbDTO dto = LanguageDbDTO();
    dto.name = entity.languageName;
    dto.iconPath = entity.languageIconPath;

    return dto;
  }

  static SettingsEntity databaseToEntity(
      DistanceDbDTO? distance, CommonDbDTO? common, LanguageDbDTO? language) {
    return SettingsEntity(
      distance?.title ?? "kilometers",
      distance?.type ?? "km",
      common?.isFirstStart ?? true,
      language?.iconPath,
      language?.name ?? "eng",
    );
  }
}
