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

  void _initHive(String directoryPath) {
    Hive.init(directoryPath);
    Hive.registerAdapter(BikeDTOAdapter());
    Hive.registerAdapter(CommonDTOAdapter());
    Hive.registerAdapter(DistanceDTOAdapter());
    Hive.registerAdapter(LanguageDTOAdapter());
    Hive.registerAdapter(ManufacturerDTOAdapter());
  }

  @override
  Future<List<BikeDbDTO>> loadBikes() async {
    Box<List<BikeDbDTO>> box = await Hive.openBox<List<BikeDbDTO>>((BikeDbDTO).toString());
    return box.get((BikeDbDTO).toString()) ?? [];
  }

  @override
  Future<void> saveBikes(List<BikeDbDTO> bikes) async {
    Box<List<BikeDbDTO>> box = await Hive.openBox<List<BikeDbDTO>>((BikeDbDTO).toString());
    await box.put((BikeDbDTO).toString(), bikes);
  }

  @override
  Future<void> clearBikes() async {
    Box<List<BikeDbDTO>> box = await Hive.openBox<List<BikeDbDTO>>((BikeDbDTO).toString());
    await box.clear();
  }

  @override
  Future<List<ManufacturerDbDTO>> loadManufacturers() async {
    Box<List<ManufacturerDbDTO>> box =
        await Hive.openBox<List<ManufacturerDbDTO>>((ManufacturerDbDTO).toString());
    return box.get((ManufacturerDbDTO).toString()) ?? [];
  }

  @override
  Future<void> saveManufacturers(List<ManufacturerDbDTO> manufacturers) async {
    Box<List<ManufacturerDbDTO>> box =
        await Hive.openBox<List<ManufacturerDbDTO>>((ManufacturerDbDTO).toString());
    await box.put((ManufacturerDbDTO).toString(), manufacturers);
  }

  @override
  Future<void> clearManufacturers() async {
    Box<List<ManufacturerDbDTO>> box =
        await Hive.openBox<List<ManufacturerDbDTO>>((ManufacturerDbDTO).toString());
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
