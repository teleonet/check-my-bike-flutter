import 'dart:io';

import 'package:check_my_bike_flutter/data/data_source/database/database_gateway.dart';
import 'package:check_my_bike_flutter/data/data_source/database/database_gateway_impl.dart';
import 'package:check_my_bike_flutter/data/data_source/database/dto/bike_db_dto.dart';
import 'package:check_my_bike_flutter/data/data_source/database/dto/common_db_dto.dart';
import 'package:check_my_bike_flutter/data/data_source/database/dto/distance_db_dto.dart';
import 'package:check_my_bike_flutter/data/data_source/database/dto/language_db_dto.dart';
import 'package:check_my_bike_flutter/data/data_source/database/dto/manufacturer_db_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../data_utils.dart';

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
    List<BikeDbDTO> savedBikes = DataUtils.buildBikesDb();
    await _gateway?.saveBikes(savedBikes);

    List<BikeDbDTO>? loadedBikes = await _gateway?.loadBikes();

    expect(savedBikes.length == loadedBikes?.length, true);

    await _gateway?.clearBikes();
  });

  test("save and load manufacturers", () async {
    List<ManufacturerDbDTO> savedManufacturers = DataUtils.buildManufacturersDb();
    await _gateway?.saveManufacturers(savedManufacturers);

    List<ManufacturerDbDTO>? loadedManufacturers = await _gateway?.loadManufacturers();

    expect(savedManufacturers.length == loadedManufacturers?.length, true);

    await _gateway?.clearManufacturers();
  });

  test("save and load common", () async {
    await _gateway?.saveCommon(DataUtils.buildCommonDb());

    CommonDbDTO? common = await _gateway?.loadCommon();

    expect(common?.isFirstStart, false);
  });

  test("save and load language", () async {
    await _gateway?.saveLanguage(DataUtils.buildLanguageDb());

    LanguageDbDTO? language = await _gateway?.loadLanguage();

    expect(language?.name, "PL");
  });

  test("save and load distance", () async {
    await _gateway?.saveDistance(DataUtils.buildDistanceDb());

    DistanceDbDTO? distance = await _gateway?.loadDistance();

    expect(distance?.type, "ml");
  });
}
