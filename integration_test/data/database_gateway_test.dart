import 'dart:io';

import 'package:check_my_bike_flutter/data/database/database_gateway.dart';
import 'package:check_my_bike_flutter/data/database/database_gateway_impl.dart';
import 'package:check_my_bike_flutter/data/database/dto/bike_dto.dart';
import 'package:check_my_bike_flutter/data/database/dto/common_dto.dart';
import 'package:check_my_bike_flutter/data/database/dto/distance_dto.dart';
import 'package:check_my_bike_flutter/data/database/dto/language_dto.dart';
import 'package:check_my_bike_flutter/data/database/dto/manufacturer_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'gateway_utils.dart';

void main() async {
  DatabaseGateway? _gateway;

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
    _gateway = DatabaseGatewayImpl();
  });

  setUp(() async {
    //empty
  });

  tearDown(() async {
    //empty
  });

  test("save and load bikes", () async {
    List<BikeDTO> savedBikes = GatewayUtils.buildBikes();
    await _gateway?.saveBikes(savedBikes);

    Iterable<BikeDTO>? loadedBikes = await _gateway?.loadBikes();

    expect(savedBikes.length == loadedBikes?.length, true);

    await _gateway?.clearBikes();
  });

  test("save and load manufacturers", () async {
    List<ManufacturerDTO> savedManufacturers = GatewayUtils.buildManufacturers();
    await _gateway?.saveManufacturers(savedManufacturers);

    Iterable<ManufacturerDTO>? loadedManufacturers = await _gateway?.loadManufacturers();

    expect(savedManufacturers.length == loadedManufacturers?.length, true);

    await _gateway?.clearManufacturers();
  });
}
