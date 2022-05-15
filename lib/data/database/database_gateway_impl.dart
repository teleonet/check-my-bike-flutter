import 'package:check_my_bike_flutter/data/database/database_gateway.dart';
import 'package:check_my_bike_flutter/data/database/dto/bike_dto.dart';
import 'package:check_my_bike_flutter/data/database/dto/common_dto.dart';
import 'package:check_my_bike_flutter/data/database/dto/distance_dto.dart';
import 'package:check_my_bike_flutter/data/database/dto/manufacturer_dto.dart';
import 'package:hive/hive.dart';

import 'dto/language_dto.dart';

class DatabaseGatewayImpl implements DatabaseGateway {
  @override
  Future<List<BikeDTO>> loadBikes() async {
    Box<List<BikeDTO>> box = await Hive.openBox<List<BikeDTO>>((BikeDTO).toString());
    return box.get((BikeDTO).toString()) ?? [];
  }

  @override
  Future<void> saveBikes(List<BikeDTO> bikes) async {
    Box<List<BikeDTO>> box = await Hive.openBox<List<BikeDTO>>((BikeDTO).toString());
    await box.put((BikeDTO).toString(), bikes);
  }

  @override
  Future<void> clearBikes() async {
    Box<List<BikeDTO>> box = await Hive.openBox<List<BikeDTO>>((BikeDTO).toString());
    await box.clear();
  }

  @override
  Future<List<ManufacturerDTO>> loadManufacturers() async {
    Box<List<ManufacturerDTO>> box =
        await Hive.openBox<List<ManufacturerDTO>>((ManufacturerDTO).toString());
    return box.get((ManufacturerDTO).toString()) ?? [];
  }

  @override
  Future<void> saveManufacturers(List<ManufacturerDTO> manufacturers) async {
    Box<List<ManufacturerDTO>> box =
        await Hive.openBox<List<ManufacturerDTO>>((ManufacturerDTO).toString());
    await box.put((ManufacturerDTO).toString(), manufacturers);
  }

  @override
  Future<void> clearManufacturers() async {
    Box<List<ManufacturerDTO>> box =
        await Hive.openBox<List<ManufacturerDTO>>((ManufacturerDTO).toString());
    await box.clear();
  }

  @override
  Future<CommonDTO> loadCommon() async {
    Box<CommonDTO> box = await Hive.openBox<CommonDTO>((CommonDTO).toString());
    // return box.get((CommonDTO).toString());
    return box.values.single;
  }

  @override
  Future<void> saveCommon(CommonDTO common) async {
    Box<CommonDTO> box = await Hive.openBox<CommonDTO>((CommonDTO).toString());
    await box.put((CommonDTO).toString(), common);
  }

  @override
  Future<LanguageDTO> loadLanguage() async {
    Box<LanguageDTO> box = await Hive.openBox<LanguageDTO>((LanguageDTO).toString());
    return box.values.single;
  }

  @override
  Future<void> saveLanguage(LanguageDTO language) async {
    Box<LanguageDTO> box = await Hive.openBox<LanguageDTO>((LanguageDTO).toString());
    await box.put((LanguageDTO).toString(), language);
  }

  @override
  Future<DistanceDTO> loadDistance() async {
    Box<DistanceDTO> box = await Hive.openBox<DistanceDTO>((DistanceDTO).toString());
    return box.values.single;
  }

  @override
  Future<void> saveDistance(DistanceDTO distance) async {
    Box<DistanceDTO> box = await Hive.openBox<DistanceDTO>((DistanceDTO).toString());
    await box.put((DistanceDTO).toString(), distance);
  }
}
