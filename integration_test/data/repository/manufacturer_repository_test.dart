@Timeout(Duration(seconds: 60))
import 'dart:io';

import 'package:check_my_bike_flutter/data/data_source/database/database_gateway.dart';
import 'package:check_my_bike_flutter/data/data_source/database/database_gateway_impl.dart';
import 'package:check_my_bike_flutter/data/data_source/rest/exception/rest_exception.dart';
import 'package:check_my_bike_flutter/data/data_source/rest/rest_gateway.dart';
import 'package:check_my_bike_flutter/data/data_source/rest/rest_gateway_impl.dart';
import 'package:check_my_bike_flutter/data/repository/manufacturer/manufacturer_repository.dart';
import 'package:check_my_bike_flutter/data/repository/manufacturer/manufacturer_repository_impl.dart';
import 'package:check_my_bike_flutter/domain/entity/manufacturer_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';

import '../data_utils.dart';

void main() {
  ManufacturerRepository? _repository;

  setUpAll(() async {
    Directory tempDir = await getTemporaryDirectory();
    DatabaseGateway databaseGateway = DatabaseGatewayImpl(tempDir.path + "/integration_test_db");
    RestGateway restGateway = RestGatewayImpl();
    _repository = ManufacturerRepositoryImpl(restGateway, databaseGateway);
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
