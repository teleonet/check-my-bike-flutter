import 'dart:io';

import 'package:check_my_bike_flutter/data/repository/bike/bike_repository.dart';
import 'package:check_my_bike_flutter/data/repository/bike/bike_repository_impl.dart';
import 'package:check_my_bike_flutter/data/repository/default/default_repository.dart';
import 'package:check_my_bike_flutter/data/repository/default/default_repository_impl.dart';
import 'package:check_my_bike_flutter/data/repository/manufacturer/manufacturer_repository_impl.dart';
import 'package:check_my_bike_flutter/data/repository/settings/settings_repository.dart';
import 'package:check_my_bike_flutter/data/repository/settings/settings_repository_impl.dart';
import 'package:check_my_bike_flutter/data/source/database/database_gateway.dart';
import 'package:check_my_bike_flutter/data/source/database/database_gateway_impl.dart';
import 'package:check_my_bike_flutter/data/source/rest/rest_gateway.dart';
import 'package:check_my_bike_flutter/data/source/rest/rest_gateway_impl.dart';
import 'package:check_my_bike_flutter/domain/bloc/bike/bike_bloc.dart';
import 'package:check_my_bike_flutter/domain/bloc/settings/settings_bloc.dart';
import 'package:check_my_bike_flutter/presentation/screen/splash/splash_screen.dart';
import 'package:check_my_bike_flutter/resources/colors_res.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isolate_bloc/isolate_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'data/repository/manufacturer/manufacturer_repository.dart';
import 'domain/bloc/manufacturer/manufacturer_bloc.dart';
import 'domain/bloc/navigation/navigation_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await _initDependencies();

  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ua'), Locale('pl')],
      path: 'assets/langs',
      fallbackLocale: const Locale('en'),
      child: const App()));

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: ColorsRes.startGradient));
}

Future<void> _initDependencies() async {
  Directory dir = await getApplicationDocumentsDirectory();
  await _initBlocs(dir.path);
}

Future<void> _initBlocs(String directoryPath) async {
  // TODO: need move to package like DI
  await initialize(() async {
    RestGateway restGateway = RestGatewayImpl();
    DatabaseGateway databaseGateway = DatabaseGatewayImpl(directoryPath);

    ManufacturerRepository manufacturerRepository =
        ManufacturerRepositoryImpl(restGateway, databaseGateway);
    BikeRepository bikeRepository = BikeRepositoryImpl(restGateway, databaseGateway);
    SettingsRepository settingsRepository = SettingsRepositoryImpl(databaseGateway);
    DefaultRepository defaultRepository = DefaultRepositoryImpl();

    ManufacturerBloc.init(manufacturerRepository);
    NavigationBloc.init(settingsRepository);
    BikeBloc.init(bikeRepository);
    SettingsBloc.init(
        manufacturerRepository, bikeRepository, settingsRepository, defaultRepository);
  });
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
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
