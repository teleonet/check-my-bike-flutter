@Timeout(Duration(seconds: 60))
import 'dart:io';

import 'package:check_my_bike_flutter/data/data_source/database/database_gateway.dart';
import 'package:check_my_bike_flutter/data/data_source/database/database_gateway_impl.dart';
import 'package:check_my_bike_flutter/data/data_source/rest/rest_gateway.dart';
import 'package:check_my_bike_flutter/data/data_source/rest/rest_gateway_impl.dart';
import 'package:check_my_bike_flutter/data/repository/bike/bike_repository.dart';
import 'package:check_my_bike_flutter/data/repository/bike/bike_repository_impl.dart';
import 'package:check_my_bike_flutter/domain/entity/bike_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/location_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';

import '../data_utils.dart';

void main() {
  BikeRepository? _repository;

  setUpAll(() async {
    Directory tempDir = await getTemporaryDirectory();
    DatabaseGateway databaseGateway = DatabaseGatewayImpl(tempDir.path + "/integration_test_db");
    RestGateway restGateway = RestGatewayImpl();
    _repository = BikeRepositoryImpl(restGateway, databaseGateway);
  });

  test("load bikes from rest by serial with correct query", () async {
    List<BikeEntity>? bikes = await _repository?.loadFromRestBySerial("11981L5n20", 1);
    expect(bikes?.isNotEmpty, true);
  });

  test("load bikes from rest by serial with wrong query", () async {
    List<BikeEntity>? bikes = await _repository?.loadFromRestBySerial("wrong_serial", 1);
    expect(bikes?.isEmpty, true);
  });

  test("load bikes from rest by serial with empty query", () async {
    List<BikeEntity>? bikes = await _repository?.loadFromRestBySerial("", 1);
    expect(bikes?.isNotEmpty, true);
  });

  test("load bikes from rest by custom parameter", () async {
    List<BikeEntity>? bikes = await _repository?.loadFromRestByCustomParameter("Scott", 1);
    expect(bikes?.isNotEmpty, true);
  });

  test("load bikes from rest by custom parameter with empty query", () async {
    List<BikeEntity>? bikes = await _repository?.loadFromRestByCustomParameter("", 1);
    expect(bikes?.isNotEmpty, true);
  });

  test("load bikes from rest by location with correct location", () async {
    List<BikeEntity>? bikes =
        await _repository?.loadFromRestByLocation(LocationEntity(52.22, 21.00), 1, 1);
    expect(bikes?[0].stolenLocation?.contains("PL"), true);
  });

  test("load bikes from rest by location with wrong location", () async {
    List<BikeEntity>? bikes =
        await _repository?.loadFromRestByLocation(LocationEntity(50, 50), 1, 1);
    expect(bikes?.isEmpty, true);
  });

  test("save bikes to db and load from db", () async {
    List<BikeEntity> savedBikes = DataUtils.buildBikeEntityList();
    await _repository?.saveToDatabase(savedBikes);

    List<BikeEntity>? loadedBikes = await _repository?.loadFromDatabase();

    expect(savedBikes.length == loadedBikes?.length, true);

    await _repository?.clearInDatabase();
  });

  test("load bikes from rest and save to db", () async {
    List<BikeEntity>? savedBikes = await _repository?.loadFromRestByManufacturer("scott", 1);
    await _repository?.saveToDatabase(savedBikes!);

    List<BikeEntity>? loadedBikes = await _repository?.loadFromDatabase();

    expect(savedBikes?.length == loadedBikes?.length, true);

    await _repository?.clearInDatabase();
  });

  test("load bikes from empty db", () async {
    await _repository?.clearInDatabase();

    List<BikeEntity>? loadedBikes = await _repository?.loadFromDatabase();

    expect(loadedBikes?.isEmpty, true);
  });
}
