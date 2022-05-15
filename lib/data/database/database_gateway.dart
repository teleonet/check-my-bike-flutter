import 'package:check_my_bike_flutter/data/database/dto/bike_dto.dart';
import 'package:check_my_bike_flutter/data/database/dto/common_dto.dart';
import 'package:check_my_bike_flutter/data/database/dto/distance_dto.dart';
import 'package:check_my_bike_flutter/data/database/dto/language_dto.dart';
import 'package:check_my_bike_flutter/data/database/dto/manufacturer_dto.dart';

abstract class DatabaseGateway {
  Future<List<BikeDTO>> loadBikes();

  Future<void> saveBikes(List<BikeDTO> bikes);

  Future<List<ManufacturerDTO>> loadManufacturers();

  Future<void> saveManufacturers(List<ManufacturerDTO> manufacturers);

  Future<LanguageDTO> loadLanguage();

  Future<void> saveLanguage(LanguageDTO language);

  Future<DistanceDTO> loadDistance();

  Future<void> saveDistance(DistanceDTO distance);

  Future<CommonDTO> loadCommon();

  Future<void> saveCommon(CommonDTO common);

  Future<void> clearManufacturers();

  Future<void> clearBikes();
}
