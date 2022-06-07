import 'package:check_my_bike_flutter/domain/bloc/manufacturer/manufacturer_bloc.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/state/manufacturer_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/navigation/event/scroll_screen_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/navigation/navigation_bloc.dart';
import 'package:check_my_bike_flutter/domain/bloc/navigation/state/manufacturer_screen_state.dart';
import 'package:check_my_bike_flutter/presentation/screen/manufacturers/all/manufacturers_all_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/manufacturers/search/manufacturers_search_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/manufacturers/tab/sliver_manufacturers_tab_controller.dart';
import 'package:check_my_bike_flutter/presentation/scroll/scroll_controller_with_listener.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isolate_bloc/isolate_bloc.dart';

import '../../../domain/bloc/navigation/event/manufacturer_screen_event.dart';
import '../../../domain/bloc/navigation/state/navigation_state.dart';
import '../../../resources/colors_res.dart';
import '../../widgets/header.dart';
import 'base/base_manufacturers_screen.dart';
import 'favorites/manufacturers_favorites_screen.dart';

class ManufacturersScreen extends StatelessWidget {
  BaseManufacturersScreen _currentScreen = ManufacturersAllScreen();

  ManufacturersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IsolateBlocBuilder<NavigationBloc, NavigationState>(builder: (context, state) {
      return Container(
          height: MediaQuery.of(context).size.height,
          decoration: _buildGradientDecoration(),
          child: CustomScrollView(
              controller: ScrollControllerWithListener()
                ..addScrolledBottomListener(() {
                  _currentScreen.scrolledBottom(context);
                })
                ..addScrollBottomListener(() {
                  _sendScrollEvent(context, ScrollDirectionType.bottom);
                })
                ..addScrollTopListener(() {
                  _sendScrollEvent(context, ScrollDirectionType.top);
                }),
              slivers: [
                const SliverToBoxAdapter(child: Header("Manufacturers")),
                _buildTabController(context),
                IsolateBlocProvider<ManufacturerBloc, ManufacturerState>(
                    child: state is ManufacturerScreenState
                        ? _buildCurrentScreen(context, state)
                        : _currentScreen)
              ]));
    }, buildWhen: (prev, next) {
      return next is ManufacturerScreenState;
    });
  }

  BoxDecoration _buildGradientDecoration() {
    return BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ColorsRes.startGradient, ColorsRes.endGradient]));
  }

  Widget _buildTabController(BuildContext context) {
    return SliverManufacturersTabController((index) {
      ManufacturerScreenType screen = _getScreenByIndex(index);
      context.isolateBloc<NavigationBloc, NavigationState>().add(ManufacturerScreenEvent(screen));
    });
    // key: _tabControllerKey);
  }

  ManufacturerScreenType _getScreenByIndex(int index) {
    ManufacturerScreenType screen = ManufacturerScreenType.all;
    if (index == 1) {
      screen = ManufacturerScreenType.search;
    } else if (index == 2) {
      screen = ManufacturerScreenType.favorites;
    }
    return screen;
  }

  BaseManufacturersScreen _buildCurrentScreen(BuildContext context, ManufacturerScreenState state) {
    if (state.screen == ManufacturerScreenType.all) {
      _currentScreen = ManufacturersAllScreen();
    } else if (state.screen == ManufacturerScreenType.search) {
      _currentScreen = ManufacturersSearchScreen();
    } else if (state.screen == ManufacturerScreenType.favorites) {
      _currentScreen = ManufacturersFavoritesScreen();
    }
    return _currentScreen!;
  }

  void _sendScrollEvent(BuildContext context, ScrollDirectionType scrollType) {
    context.isolateBloc<NavigationBloc, NavigationState>().add(ScrollScreenEvent(scrollType));
  }
}
