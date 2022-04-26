import 'package:check_my_bike_flutter/presentation/screen/check/serial/serial_screen.dart';
import 'package:flutter/material.dart';

import '../screen/main/main_screen.dart';

const String SplashScreenRoute = '/';
const String MainScreenRoute = '/main';
const String SerialScreenRoute = '/serial';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case MainScreenRoute:
      return MaterialPageRoute(builder: (context) => const MainScreen());
    case SerialScreenRoute:
      return MaterialPageRoute(builder: (context) => const SerialScreen());
    /*case StoryScreenRoute:
      return MaterialPageRoute(builder: (context) => StoryScreen());
    case SettingsScreenRoute:
      return MaterialPageRoute(builder: (context) => SettingsScreen());*/
  }
}
