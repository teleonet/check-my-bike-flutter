import 'package:check_my_bike_flutter/domain/entity/common_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/distance_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/language_entity.dart';

abstract class SettingsRepository {
  Future<DistanceEntity> loadDistanceFromDatabase();

  Future<void> saveDistanceToDatabase(DistanceEntity entity);

  Future<LanguageEntity> loadLanguageFromDatabase();

  Future<void> saveLanguageToDatabase(LanguageEntity entity);

  Future<CommonEntity> loadCommonFromDatabase();

  Future<void> saveCommonToDatabase(CommonEntity entity);

  Future<void> clearInDatabase();
}
