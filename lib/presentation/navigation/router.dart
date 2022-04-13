import 'package:flutter/material.dart';

import '../screen/main/main_screen.dart';

const String SplashScreenRoute = '/';
const String MainScreenRoute = '/main';
const String InfoScreenRoute = '/info';
const String StoryScreenRoute = '/story';
const String SettingsScreenRoute = '/settings';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case MainScreenRoute:
      return MaterialPageRoute(builder: (context) => const MainScreen());
    /*case InfoScreenRoute:
      return MaterialPageRoute(builder: (context) => InfoScreen());
    case StoryScreenRoute:
      return MaterialPageRoute(builder: (context) => StoryScreen());
    case SettingsScreenRoute:
      return MaterialPageRoute(builder: (context) => SettingsScreen());*/
  }
}
