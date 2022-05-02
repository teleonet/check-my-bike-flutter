import 'package:check_my_bike_flutter/presentation/screen/main/main_screen.dart';
import 'package:check_my_bike_flutter/resources/colors_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const App());

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: ColorsRes.startGradient));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: _buildTheme(),
        debugShowCheckedModeBanner: false,
        title: 'Check My Bike',
        home: const MainScreen());
  }

  ThemeData _buildTheme() {
    return ThemeData(
      colorScheme:
          ColorScheme.fromSwatch().copyWith(primary: ColorsRes.green, secondary: ColorsRes.green),
    );
  }
}
