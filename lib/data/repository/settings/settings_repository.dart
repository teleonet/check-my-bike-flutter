import 'package:check_my_bike_flutter/domain/entity/distance_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/language_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/location_entity.dart';

abstract class SettingsRepository {
  Future<LanguageEntity> loadLanguageFromDatabase();

  Future<void> saveLanguageToDatabase(LanguageEntity language);

  Future<DistanceEntity> loadDistanceFromDatabase();

  Future<void> saveDistanceToDatabase(DistanceEntity distance);

  Future<LocationEntity> loadLocationFromDatabase();

  Future<void> saveLocationToDatabase(LocationEntity location);
}
