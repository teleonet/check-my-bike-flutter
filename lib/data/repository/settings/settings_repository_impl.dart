import 'package:check_my_bike_flutter/data/repository/settings/settings_repository.dart';
import 'package:check_my_bike_flutter/domain/entity/distance_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/language_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/location_entity.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  @override
  Future<DistanceEntity> loadDistanceFromDatabase() {
    // TODO: implement loadDistanceFromDatabase
    throw UnimplementedError();
  }

  @override
  Future<LanguageEntity> loadLanguageFromDatabase() {
    // TODO: implement loadLanguageFromDatabase
    throw UnimplementedError();
  }

  @override
  Future<LocationEntity> loadLocationFromDatabase() {
    // TODO: implement loadLocationFromDatabase
    throw UnimplementedError();
  }

  @override
  Future<void> saveDistanceToDatabase(DistanceEntity distance) {
    // TODO: implement saveDistanceToDatabase
    throw UnimplementedError();
  }

  @override
  Future<void> saveLanguageToDatabase(LanguageEntity language) {
    // TODO: implement saveLanguageToDatabase
    throw UnimplementedError();
  }

  @override
  Future<void> saveLocationToDatabase(LocationEntity location) {
    // TODO: implement saveLocationToDatabase
    throw UnimplementedError();
  }
}
