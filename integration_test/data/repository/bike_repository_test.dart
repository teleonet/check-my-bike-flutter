import 'dart:io';

import 'package:check_my_bike_flutter/data/data_source/database/dto/bike_db_dto.dart';
import 'package:check_my_bike_flutter/data/data_source/database/dto/common_db_dto.dart';
import 'package:check_my_bike_flutter/data/data_source/database/dto/distance_db_dto.dart';
import 'package:check_my_bike_flutter/data/data_source/database/dto/language_db_dto.dart';
import 'package:check_my_bike_flutter/data/data_source/database/dto/manufacturer_db_dto.dart';
import 'package:check_my_bike_flutter/data/repository/bike/bike_repository.dart';
import 'package:check_my_bike_flutter/data/repository/bike/bike_repository_impl.dart';
import 'package:check_my_bike_flutter/domain/entity/bike_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../data_utils.dart';

void main() {
  BikeRepository? _repository;

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
    _repository = BikeRepositoryImpl();
  });

  setUp(() async {
    //empty
  });

  tearDown(() async {
    //empty
  });

  test("load bikes by serial with correct query", () async {
    List<BikeEntity>? bikes = await _repository?.loadFromRestBySerial("11981L5n20", 1);
    expect(bikes?.isNotEmpty, true);
  });

  test("load bikes by serial with wrong query", () async {
    List<BikeEntity>? bikes = await _repository?.loadFromRestBySerial("wrong_serial", 1);
    expect(bikes?.isEmpty, true);
  });

  test("load bikes by serial with empty query", () async {
    List<BikeEntity>? bikes = await _repository?.loadFromRestBySerial("", 1);
    expect(bikes?.isNotEmpty, true);
  });

  test("load bikes by custom parameter", () async {
    List<BikeEntity>? bikes = await _repository?.loadFromRestByCustomParameter("Scott", 1);
    expect(bikes?.isNotEmpty, true);
  });

  test("load bikes by custom parameter with empty query", () async {
    List<BikeEntity>? bikes = await _repository?.loadFromRestByCustomParameter("", 1);
    expect(bikes?.isNotEmpty, true);
  });

  test("load bikes by location with correct query", () async {
    List<BikeEntity>? bikes = await _repository?.loadFromRestByLocation(52.22, 21.00, 1, 1);
    expect(bikes?[0].stolenLocation?.contains("PL"), true);
  });

  test("load bikes by location with wrong query", () async {
    List<BikeEntity>? bikes = await _repository?.loadFromRestByLocation(50, 50, 1, 1);
    expect(bikes?.isEmpty, true);
  });

  test("save and load bikes", () async {
    List<BikeEntity> savedBikes = DataUtils.buildBikeEntityList();
    await _repository?.saveToDatabase(savedBikes);

    List<BikeEntity>? loadedBikes = await _repository?.loadFromDatabase();

    expect(savedBikes.length == loadedBikes?.length, true);

    await _repository?.clearInDatabase();
  });

  test("load bikes from empty db", () async {
    await _repository?.clearInDatabase();

    List<BikeEntity>? loadedBikes = await _repository?.loadFromDatabase();

    expect(loadedBikes?.isEmpty, true);
  });
}
