import 'dart:io';

import 'package:check_my_bike_flutter/presentation/screen/splash/splash_screen.dart';
import 'package:check_my_bike_flutter/resources/colors_res.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'domain/dependency/dependency.dart';
import 'domain/dependency/gateway_factory/gateway_factory_impl.dart';
import 'domain/dependency/repository_factory/repository_factory_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  Directory dir = await getApplicationDocumentsDirectory();
  await Dependency.init(dir.path, GatewayFactoryImpl(), RepositoryFactoryImpl());

  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('lo'), Locale('pl')],
      path: 'assets/languages',
      fallbackLocale: const Locale('en'),
      child: const App()));

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: ColorsRes.startGradient));
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
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(primary: ColorsRes.green, secondary: ColorsRes.green));
  }
}
