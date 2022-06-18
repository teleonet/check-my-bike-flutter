import 'package:check_my_bike_flutter/data/source/database/database_gateway.dart';
import 'package:check_my_bike_flutter/data/source/database/database_gateway_impl.dart';
import 'package:check_my_bike_flutter/data/source/rest/rest_gateway.dart';
import 'package:check_my_bike_flutter/data/source/rest/rest_gateway_impl.dart';

import 'gateway_factory.dart';

class GatewayFactoryImpl implements GatewayFactory {
  @override
  DatabaseGateway createDatabase(String directoryPath) {
    return DatabaseGatewayImpl(directoryPath);
  }

  @override
  RestGateway createRest() {
    return RestGatewayImpl();
  }
}
