import 'package:check_my_bike_flutter/domain/dependency/repository_factory/repository_factory.dart';
import 'package:isolate_bloc/isolate_bloc.dart';

import '../../data/repository/bike/bike_repository.dart';
import '../../data/repository/default/default_repository.dart';
import '../../data/repository/manufacturer/manufacturer_repository.dart';
import '../../data/repository/settings/settings_repository.dart';
import '../../data/source/database/database_gateway.dart';
import '../../data/source/rest/rest_gateway.dart';
import '../bloc/bike/bike_bloc.dart';
import '../bloc/manufacturer/manufacturer_bloc.dart';
import '../bloc/navigation/navigation_bloc.dart';
import '../bloc/settings/settings_bloc.dart';
import 'gateway_factory/gateway_factory.dart';

class Dependency {
  Dependency._();

  static Future<void> init(String directoryPath, GatewayFactory gatewayFactory,
      RepositoryFactory repositoryFactory) async {
    await initialize(() async {
      DatabaseGateway databaseGateway = gatewayFactory.createDatabase(directoryPath);
      RestGateway restGateway = gatewayFactory.createRest();

      ManufacturerRepository manufacturerRepository =
          repositoryFactory.createManufacturer(restGateway, databaseGateway);
      BikeRepository bikeRepository = repositoryFactory.createBike(restGateway, databaseGateway);
      SettingsRepository settingsRepository = repositoryFactory.createSettings(databaseGateway);
      DefaultRepository defaultRepository = repositoryFactory.createDefault();

      ManufacturerBloc.init(manufacturerRepository);
      NavigationBloc.init(settingsRepository);
      BikeBloc.init(bikeRepository);
      SettingsBloc.init(
          manufacturerRepository, bikeRepository, settingsRepository, defaultRepository);
    });
  }
}
