import 'dto/bike_db_dto.dart';
import 'dto/common_db_dto.dart';
import 'dto/distance_db_dto.dart';
import 'dto/language_db_dto.dart';
import 'dto/manufacturer_db_dto.dart';

abstract class DatabaseGateway {
  Future<List<BikeDbDTO>> loadBikes();

  Future<void> saveBikes(List<BikeDbDTO> bikes);

  Future<void> deleteBikes(List<BikeDbDTO> bikes);

  Future<void> clearBikes();

  Future<List<ManufacturerDbDTO>> loadManufacturers();

  Future<void> saveManufacturers(List<ManufacturerDbDTO> manufacturers);

  Future<void> deleteManufacturers(List<ManufacturerDbDTO> manufacturers);

  Future<void> clearManufacturers();

  Future<LanguageDbDTO?> loadLanguage();

  Future<void> saveLanguage(LanguageDbDTO language);

  Future<void> clearLanguage();

  Future<DistanceDbDTO?> loadDistance();

  Future<void> saveDistance(DistanceDbDTO distance);

  Future<void> clearDistance();

  Future<CommonDbDTO?> loadCommon();

  Future<void> saveCommon(CommonDbDTO common);

  Future<void> clearCommon();
}
