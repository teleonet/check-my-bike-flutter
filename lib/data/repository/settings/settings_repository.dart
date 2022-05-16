import 'package:check_my_bike_flutter/domain/entity/settings_entity.dart';

abstract class SettingsRepository {
  Future<SettingsEntity> loadFromDatabase();

  Future<void> saveToDatabase(SettingsEntity entity);

  Future<void> clearInDatabase();
}
