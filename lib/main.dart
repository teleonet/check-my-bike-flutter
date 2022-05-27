import 'dart:io';

import 'package:check_my_bike_flutter/data/repository/manufacturer/manufacturer_repository_impl.dart';
import 'package:check_my_bike_flutter/data/source/database/database_gateway.dart';
import 'package:check_my_bike_flutter/data/source/database/database_gateway_impl.dart';
import 'package:check_my_bike_flutter/data/source/rest/rest_gateway.dart';
import 'package:check_my_bike_flutter/data/source/rest/rest_gateway_impl.dart';
import 'package:check_my_bike_flutter/presentation/screen/main/main_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/splash/splash_screen.dart';
import 'package:check_my_bike_flutter/resources/colors_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isolate_bloc/isolate_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'data/repository/manufacturer/manufacturer_repository.dart';
import 'domain/bloc/manufacturer/manufacturer_bloc.dart';
import 'domain/bloc/navigation/navigation_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initDependencies();

  runApp(const App());

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: ColorsRes.startGradient));
}

Future<void> _initDependencies() async {
  Directory dir = await getApplicationDocumentsDirectory();
  await _initBlocs(dir.path);
}

Future<void> _initBlocs(String directoryPath) async {
  await initialize(() async {
    RestGateway restGateway = RestGatewayImpl();
    DatabaseGateway databaseGateway = DatabaseGatewayImpl(directoryPath);

    ManufacturerRepository manufacturerRepository =
        ManufacturerRepositoryImpl(restGateway, databaseGateway);

    ManufacturerBloc.init(manufacturerRepository);
    NavigationBloc.init();
  });
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: _buildTheme(),
        debugShowCheckedModeBanner: false,
        title: 'Check My Bike',
        home: const SplashScreen());
  }

  ThemeData _buildTheme() {
    return ThemeData(
      colorScheme:
          ColorScheme.fromSwatch().copyWith(primary: ColorsRes.green, secondary: ColorsRes.green),
    );
  }
}
