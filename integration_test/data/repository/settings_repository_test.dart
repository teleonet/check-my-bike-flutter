import 'dart:io';

import 'package:check_my_bike_flutter/data/data_source/database/dto/bike_db_dto.dart';
import 'package:check_my_bike_flutter/data/data_source/database/dto/common_db_dto.dart';
import 'package:check_my_bike_flutter/data/data_source/database/dto/distance_db_dto.dart';
import 'package:check_my_bike_flutter/data/data_source/database/dto/language_db_dto.dart';
import 'package:check_my_bike_flutter/data/data_source/database/dto/manufacturer_db_dto.dart';
import 'package:check_my_bike_flutter/data/repository/settings/settings_repository.dart';
import 'package:check_my_bike_flutter/data/repository/settings/settings_repository_impl.dart';
import 'package:check_my_bike_flutter/domain/entity/settings_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  SettingsRepository? _repository;

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
    _repository = SettingsRepositoryImpl();
  });

  setUp(() async {
    //empty
  });

  tearDown(() async {
    //empty
  });

  test("save and load settings", () async {
    SettingsEntity savedEntity = SettingsEntity("miles", "ml", false, "language_icon_path", "ua");
    await _repository?.saveToDatabase(savedEntity);

    SettingsEntity? loadedEntity = await _repository?.loadFromDatabase();
    expect(savedEntity.languageIconPath == loadedEntity?.languageIconPath, true);

    await _repository?.clearInDatabase();
  });

  test("load default settings from empty db", () async {
    await _repository?.clearInDatabase();

    SettingsEntity? settings = await _repository?.loadFromDatabase();
    expect(settings?.isFirstStart, true);
  });
}
