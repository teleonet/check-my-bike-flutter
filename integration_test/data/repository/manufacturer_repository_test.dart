import 'dart:io';

import 'package:check_my_bike_flutter/data/data_source/database/dto/bike_db_dto.dart';
import 'package:check_my_bike_flutter/data/data_source/database/dto/common_db_dto.dart';
import 'package:check_my_bike_flutter/data/data_source/database/dto/distance_db_dto.dart';
import 'package:check_my_bike_flutter/data/data_source/database/dto/language_db_dto.dart';
import 'package:check_my_bike_flutter/data/data_source/database/dto/manufacturer_db_dto.dart';
import 'package:check_my_bike_flutter/data/data_source/rest/exception/rest_exception.dart';
import 'package:check_my_bike_flutter/data/repository/manufacturer/manufacturer_repository.dart';
import 'package:check_my_bike_flutter/data/repository/manufacturer/manufacturer_repository_impl.dart';
import 'package:check_my_bike_flutter/domain/entity/manufacturer_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../data_utils.dart';

void main() {
  ManufacturerRepository? _repository;

  Future<void> _initHive() async {
    Directory tempDir = await getTemporaryDirectory();
    Hive.init(tempDir.path + "/integration_test_db");

    Hive.registerAdapter(BikeDTOAdapter());
    Hive.registerAdapter(CommonDTOAdapter());
    Hive.registerAdapter(DistanceDTOAdapter());
    Hive.registerAdapter(LanguageDTOAdapter());
    Hive.registerAdapter(ManufacturerDTOAdapter());
  }

  setUpAll(() async {
    await _initHive();
    _repository = ManufacturerRepositoryImpl();
  });

  test("load all manufacturers from rest with correct query", () async {
    List<ManufacturerEntity>? manufacturers = await _repository?.loadFromRestAll(1);
    expect(manufacturers?.isNotEmpty, true);
  });

  test("load manufacturer from rest by name with correct query", () async {
    ManufacturerEntity? manufacturer = await _repository?.loadFromRestByName("Scott");
    expect(manufacturer != null, true);
  });

  test("load manufacturer from rest by name with wrong query", () async {
    try {
      await _repository?.loadFromRestByName("wrong_query");
      fail("expected exception, actual NOT exception");
    } on RestException catch (e) {
      expect(e, e);
    }
  });

  test("save manufacturers to db and load manufacturers from db", () async {
    List<ManufacturerEntity> savedManufacturers = DataUtils.buildManufacturerEntityList();
    await _repository?.saveToDatabase(savedManufacturers);

    List<ManufacturerEntity>? loadedManufacturers = await _repository?.loadFromDatabase();

    expect(savedManufacturers.length == loadedManufacturers?.length, true);

    await _repository?.clearInDatabase();
  });

  test("load manufacturers from rest and save to db", () async {
    List<ManufacturerEntity>? savedManufacturers = await _repository?.loadFromRestAll(1);
    await _repository?.saveToDatabase(savedManufacturers!);

    List<ManufacturerEntity>? loadedManufacturers = await _repository?.loadFromDatabase();

    expect(savedManufacturers?.length == loadedManufacturers?.length, true);

    await _repository?.clearInDatabase();
  });

  test("load manufacturers from empty db", () async {
    await _repository?.clearInDatabase();

    List<ManufacturerEntity>? loadedBikes = await _repository?.loadFromDatabase();

    expect(loadedBikes?.isEmpty, true);
  });
}
