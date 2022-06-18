import 'package:check_my_bike_flutter/data/repository/bike/bike_repository.dart';
import 'package:check_my_bike_flutter/data/repository/default/default_repository.dart';
import 'package:check_my_bike_flutter/data/repository/manufacturer/manufacturer_repository.dart';
import 'package:check_my_bike_flutter/data/repository/settings/settings_repository.dart';
import 'package:check_my_bike_flutter/data/source/database/database_gateway.dart';
import 'package:check_my_bike_flutter/data/source/rest/rest_gateway.dart';

abstract class RepositoryFactory {
  ManufacturerRepository createManufacturer(
      RestGateway restGateway, DatabaseGateway databaseGateway);

  BikeRepository createBike(RestGateway restGateway, DatabaseGateway databaseGateway);

  DefaultRepository createDefault();

  SettingsRepository createSettings(DatabaseGateway databaseGateway);
}
