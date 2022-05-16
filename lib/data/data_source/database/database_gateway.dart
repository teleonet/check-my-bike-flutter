import 'dto/bike_db_dto.dart';
import 'dto/common_db_dto.dart';
import 'dto/distance_db_dto.dart';
import 'dto/language_db_dto.dart';
import 'dto/manufacturer_db_dto.dart';

abstract class DatabaseGateway {
  Future<List<BikeDbDTO>> loadBikes();

  Future<void> saveBikes(List<BikeDbDTO> bikes);

  Future<List<ManufacturerDbDTO>> loadManufacturers();

  Future<void> saveManufacturers(List<ManufacturerDbDTO> manufacturers);

  Future<LanguageDbDTO> loadLanguage();

  Future<void> saveLanguage(LanguageDbDTO language);

  Future<DistanceDbDTO> loadDistance();

  Future<void> saveDistance(DistanceDbDTO distance);

  Future<CommonDbDTO> loadCommon();

  Future<void> saveCommon(CommonDbDTO common);

  Future<void> clearManufacturers();

  Future<void> clearBikes();
}
