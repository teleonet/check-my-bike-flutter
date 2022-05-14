import 'package:check_my_bike_flutter/data/database/database_gateway.dart';
import 'package:check_my_bike_flutter/data/database/dto/bike_dto.dart';
import 'package:check_my_bike_flutter/data/database/dto/manufacturer_dto.dart';
import 'package:check_my_bike_flutter/data/database/dto/settings_dto.dart';

import 'dto/language_dto.dart';

class DatabaseGatewayImpl implements DatabaseGateway {
  @override
  Future<List<BikeDTO>> loadBikes() async {
    return [];
  }

  @override
  Future<LanguageDTO> loadLanguage() async {
    return LanguageDTO();
  }

  @override
  Future<List<ManufacturerDTO>> loadManufacturers() async {
    return [];
  }

  @override
  Future<SettingsDTO> loadSettings() async {
    return SettingsDTO();
  }
}
