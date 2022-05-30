import 'package:check_my_bike_flutter/domain/bloc/navigation/event/navigation_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/navigation/event/scroll_screen_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/navigation/event/show_screen_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/navigation/state/navigation_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/navigation/state/scroll_screen_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/navigation/state/show_screen_state.dart';
import 'package:isolate_bloc/isolate_bloc.dart';

enum Screen { check, manufacturer, settings }

enum Direction { top, bottom, topComplete }

class NavigationBloc extends IsolateBloc<NavigationEvent, NavigationState> {
  static init() {
    register<NavigationBloc, NavigationState>(create: () => NavigationBloc());
  }

  NavigationBloc() : super(ShowScreenState(Screen.check));

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    if (event is ShowScreenEvent) {
      emit(ShowScreenState(event.screen));
    }
    if (event is ScrollScreenEvent) {
      emit(ScrollScreenState(event.direction));
    }
  }
}