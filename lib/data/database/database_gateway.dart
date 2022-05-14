import 'package:check_my_bike_flutter/data/database/dto/bike_dto.dart';
import 'package:check_my_bike_flutter/data/database/dto/language_dto.dart';
import 'package:check_my_bike_flutter/data/database/dto/manufacturer_dto.dart';
import 'package:check_my_bike_flutter/data/database/dto/settings_dto.dart';

abstract class DatabaseGateway {
  Future<SettingsDTO> loadSettings();

  Future<List<BikeDTO>> loadBikes();

  Future<List<ManufacturerDTO>> loadManufacturers();

  Future<LanguageDTO> loadLanguage();
}
