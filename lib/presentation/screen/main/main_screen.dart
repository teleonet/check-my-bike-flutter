import 'package:check_my_bike_flutter/domain/bloc/navigation/state/navigation_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/navigation/state/show_screen_state.dart';
import 'package:check_my_bike_flutter/presentation/screen/manufacturers/manufacturers_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/settings/settings_screen.dart';
import 'package:check_my_bike_flutter/resources/colors_res.dart';
import 'package:flutter/material.dart';
import 'package:isolate_bloc/isolate_bloc.dart';

import '../../../domain/bloc/navigation/navigation_bloc.dart';
import '../../router/slide_right_route.dart';
import '../check/check_screen.dart';
import 'navigation_bottom_bar/navigation_bottom_bar.dart';

class MainScreen extends StatelessWidget {
  static showAndClearStack(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context, SlideRightRoute(const MainScreen()).createRoute(), (_) => false);
  }

  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IsolateBlocProvider<NavigationBloc, NavigationState>(
        child: Scaffold(
            extendBody: true,
            bottomNavigationBar: NavigationBottomBar(),
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

  Widget _buildScreen(Screen screen) {
    switch (screen) {
      case Screen.check:
        return const CheckScreen();
      case Screen.manufacturer:
        return _buildManufacturerScreen();
      case Screen.settings:
        return const SettingsScreen();
    }
  }

  Widget _buildManufacturerScreen() {
    return ManufacturersScreen(
        onScrollTop: () {
          // _bottomBarKey.currentState?.show();
          // _bottomBarKey.currentState?.changeToOpacityColor();
        },
        onScrollBottom: () => {} /*_bottomBarKey.currentState?.hide()*/,
        onScrolledTop: () => {} /*_bottomBarKey.currentState?.changeToGradientColor()*/,
        onClickedTab: () => {} /*_bottomBarKey.currentState?.show()*/);
  }
}
