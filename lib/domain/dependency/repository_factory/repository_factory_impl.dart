import 'package:check_my_bike_flutter/data/repository/bike/bike_repository.dart';
import 'package:check_my_bike_flutter/data/repository/bike/bike_repository_impl.dart';
import 'package:check_my_bike_flutter/data/repository/default/default_repository.dart';
import 'package:check_my_bike_flutter/data/repository/default/default_repository_impl.dart';
import 'package:check_my_bike_flutter/data/repository/manufacturer/manufacturer_repository.dart';
import 'package:check_my_bike_flutter/data/repository/manufacturer/manufacturer_repository_impl.dart';
import 'package:check_my_bike_flutter/data/repository/settings/settings_repository.dart';
import 'package:check_my_bike_flutter/data/repository/settings/settings_repository_impl.dart';
import 'package:check_my_bike_flutter/data/source/database/database_gateway.dart';
import 'package:check_my_bike_flutter/data/source/rest/rest_gateway.dart';
import 'package:check_my_bike_flutter/domain/dependency/repository_factory/repository_factory.dart';

class RepositoryFactoryImpl implements RepositoryFactory {
  @override
  BikeRepository createBike(RestGateway restGateway, DatabaseGateway databaseGateway) {
    return BikeRepositoryImpl(restGateway, databaseGateway);
  }

  @override
  DefaultRepository createDefault() {
    return DefaultRepositoryImpl();
  }

  @override
  ManufacturerRepository createManufacturer(
      RestGateway restGateway, DatabaseGateway databaseGateway) {
    return ManufacturerRepositoryImpl(restGateway, databaseGateway);
  }

  @override
  SettingsRepository createSettings(DatabaseGateway databaseGateway) {
    return SettingsRepositoryImpl(databaseGateway);
  }
}
