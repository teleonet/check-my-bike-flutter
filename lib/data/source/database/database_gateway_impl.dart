import 'package:hive/hive.dart';

import 'database_gateway.dart';
import 'dto/bike_db_dto.dart';
import 'dto/common_db_dto.dart';
import 'dto/distance_db_dto.dart';
import 'dto/language_db_dto.dart';
import 'dto/manufacturer_db_dto.dart';

class DatabaseGatewayImpl implements DatabaseGateway {
  DatabaseGatewayImpl(String directoryPath) {
    _initHive(directoryPath);
  }

  void _initHive(String directoryPath) async {
    Hive.init(directoryPath);
    Hive.registerAdapter(BikeDTOAdapter());
    Hive.registerAdapter(CommonDTOAdapter());
    Hive.registerAdapter(DistanceDTOAdapter());
    Hive.registerAdapter(LanguageDTOAdapter());
    Hive.registerAdapter(ManufacturerDTOAdapter());
  }

  @override
  Future<List<BikeDbDTO>> loadBikes() async {
    Box<BikeDbDTO> box = await Hive.openBox((BikeDbDTO).toString());
    return box.values.toList().cast();
  }

  @override
  Future<void> saveBikes(List<BikeDbDTO> bikes) async {
    Box<BikeDbDTO> box = await Hive.openBox((BikeDbDTO).toString());
    for (var element in bikes) {
      await box.put(element.id, element);
    }
  }

  @override
  Future<void> deleteBikes(List<BikeDbDTO> bikes) async {
    Box<BikeDbDTO> box = await Hive.openBox((BikeDbDTO).toString());
    for (var element in bikes) {
      await box.delete(element.id);
    }
  }

  @override
  Future<void> clearBikes() async {
    Box<BikeDbDTO> box = await Hive.openBox((BikeDbDTO).toString());
    await box.clear();
  }

  @override
  Future<List<ManufacturerDbDTO>> loadManufacturers() async {
    Box<ManufacturerDbDTO> box = await Hive.openBox((ManufacturerDbDTO).toString());
    return box.values.toList().cast();
  }

  @override
  Future<void> saveManufacturers(List<ManufacturerDbDTO> manufacturers) async {
    Box<ManufacturerDbDTO> box = await Hive.openBox((ManufacturerDbDTO).toString());
    for (var element in manufacturers) {
      await box.put(element.name, element);
    }
  }

  @override
  Future<void> deleteManufacturers(List<ManufacturerDbDTO> manufacturers) async {
    Box<ManufacturerDbDTO> box = await Hive.openBox((ManufacturerDbDTO).toString());
    for (var element in manufacturers) {
      await box.delete(element.name);
    }
  }

  @override
  Future<void> clearManufacturers() async {
    Box<ManufacturerDbDTO> box = await Hive.openBox((ManufacturerDbDTO).toString());
    await box.clear();
  }

  @override
  Future<CommonDbDTO?> loadCommon() async {
    Box<CommonDbDTO> box = await Hive.openBox<CommonDbDTO>((CommonDbDTO).toString());
    return box.values.isNotEmpty ? box.values.single : null;
  }

  @override
  Future<void> saveCommon(CommonDbDTO common) async {
    Box<CommonDbDTO> box = await Hive.openBox<CommonDbDTO>((CommonDbDTO).toString());
    await box.put((CommonDbDTO).toString(), common);
  }

  @override
  Future<void> clearCommon() async {
    Box<CommonDbDTO> box = await Hive.openBox<CommonDbDTO>((CommonDbDTO).toString());
    await box.clear();
  }

  @override
  Future<LanguageDbDTO?> loadLanguage() async {
    Box<LanguageDbDTO> box = await Hive.openBox<LanguageDbDTO>((LanguageDbDTO).toString());
    return box.values.isNotEmpty ? box.values.single : null;
  }

  @override
  Future<void> saveLanguage(LanguageDbDTO language) async {
    Box<LanguageDbDTO> box = await Hive.openBox<LanguageDbDTO>((LanguageDbDTO).toString());
    await box.put((LanguageDbDTO).toString(), language);
  }

  @override
  Future<void> clearLanguage() async {
    Box<LanguageDbDTO> box = await Hive.openBox<LanguageDbDTO>((LanguageDbDTO).toString());
    box.clear();
  }

  @override
  Future<DistanceDbDTO?> loadDistance() async {
    Box<DistanceDbDTO> box = await Hive.openBox<DistanceDbDTO>((DistanceDbDTO).toString());
    return box.values.isNotEmpty ? box.values.single : null;
  }

  @override
  Future<void> saveDistance(DistanceDbDTO distance) async {
    Box<DistanceDbDTO> box = await Hive.openBox<DistanceDbDTO>((DistanceDbDTO).toString());
    await box.put((DistanceDbDTO).toString(), distance);
  }

  @override
  Future<void> clearDistance() async {
    Box<DistanceDbDTO> box = await Hive.openBox<DistanceDbDTO>((DistanceDbDTO).toString());
    await box.clear();
  }
}
