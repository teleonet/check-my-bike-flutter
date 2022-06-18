import 'package:check_my_bike_flutter/data/source/database/database_gateway.dart';
import 'package:check_my_bike_flutter/data/source/rest/rest_gateway.dart';

abstract class GatewayFactory {
  RestGateway createRest();

  DatabaseGateway createDatabase(String directoryPath);
}
