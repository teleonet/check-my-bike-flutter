import 'package:check_my_bike_flutter/domain/bloc/navigation/state/navigation_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/navigation/state/show_screen_state.dart';
import 'package:check_my_bike_flutter/presentation/screen/settings/settings_screen.dart';
import 'package:check_my_bike_flutter/resources/colors_res.dart';
import 'package:flutter/material.dart';
import 'package:isolate_bloc/isolate_bloc.dart';

import '../../../domain/bloc/navigation/navigation_bloc.dart';
import '../../router/slide_right_route.dart';
import '../check/check_screen.dart';
import '../check/manufacturer/manufacturer_screen.dart';
import 'navigation_bottom_bar/navigation_bottom_bar.dart';

class MainScreen extends StatelessWidget {
  static showAndClearStack(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context, SlideRightRoute(MainScreen()).createRoute(), (_) => false);
  }

  Widget _currentScreen = const CheckScreen();
  MainScreenType _currentScreenType = MainScreenType.check;

  MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IsolateBlocProvider<NavigationBloc, NavigationState>(
        child: Scaffold(
            extendBody: true,
            bottomNavigationBar: const NavigationBottomBar(),
            body: Container(
                width: MediaQuery.of(context).size.width,
                decoration: _buildContainerDecoration(),
                child:
                    IsolateBlocBuilder<NavigationBloc, NavigationState>(builder: (context, state) {
                  return _buildScreen((state as ShowScreenState).screen);
                }, buildWhen: (prev, next) {
                  return next is ShowScreenState;
                }))));
  }

  BoxDecoration _buildContainerDecoration() {
    return BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ColorsRes.startGradient, ColorsRes.endGradient]));
  }

  Widget _buildScreen(MainScreenType screen) {
    if (_currentScreenType != screen) {
      _currentScreenType = screen;
      switch (screen) {
        case MainScreenType.check:
          _currentScreen = const CheckScreen();
          break;
        case MainScreenType.manufacturer:
          _currentScreen = ManufacturerScreen();
          break;
        case MainScreenType.settings:
          _currentScreen = SettingsScreen();
          break;
      }
    }
    return _currentScreen;
  }
}
