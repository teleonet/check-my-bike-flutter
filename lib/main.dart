import 'dart:io';

import 'package:check_my_bike_flutter/presentation/screen/splash/splash_screen.dart';
import 'package:check_my_bike_flutter/resources/colors_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

import 'data/data_source/database/dto/bike_dto.dart';
import 'data/data_source/database/dto/common_dto.dart';
import 'data/data_source/database/dto/distance_dto.dart';
import 'data/data_source/database/dto/language_dto.dart';
import 'data/data_source/database/dto/manufacturer_dto.dart';

void main() {
  _initDependencies();

  runApp(const App());

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: ColorsRes.startGradient));
}

void _initDependencies() async {
  _initHive();
}

void _initHive() {
  Hive.init(Directory.current.path);

  Hive.registerAdapter(BikeDTOAdapter());
  Hive.registerAdapter(CommonDTOAdapter());
  Hive.registerAdapter(DistanceDTOAdapter());
  Hive.registerAdapter(LanguageDTOAdapter());
  Hive.registerAdapter(ManufacturerDTOAdapter());
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
