import 'dart:io';

import 'package:check_my_bike_flutter/data/repository/settings/settings_repository.dart';
import 'package:check_my_bike_flutter/data/repository/settings/settings_repository_impl.dart';
import 'package:check_my_bike_flutter/data/source/database/database_gateway.dart';
import 'package:check_my_bike_flutter/data/source/database/database_gateway_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  SettingsRepository? _repository;

  setUpAll(() async {
    Directory tempDir = await getTemporaryDirectory();
    DatabaseGateway databaseGateway = DatabaseGatewayImpl(tempDir.path + "/integration_test_db");
    _repository = SettingsRepositoryImpl(databaseGateway);
  });

  /*test("save setting to db and load from db", () async {
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
  });*/
}
