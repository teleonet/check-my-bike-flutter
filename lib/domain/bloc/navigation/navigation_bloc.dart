import 'package:check_my_bike_flutter/data/repository/settings/settings_repository.dart';
import 'package:check_my_bike_flutter/domain/bloc/navigation/event/localization_screen_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/navigation/event/navigation_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/navigation/event/scroll_screen_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/navigation/event/show_screen_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/navigation/event/tapped_map_screen_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/navigation/state/localization_screen_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/navigation/state/manufacturer_screen_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/navigation/state/navigation_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/navigation/state/scroll_screen_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/navigation/state/show_screen_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/navigation/state/tapped_map_screen_state.dart';
import 'package:check_my_bike_flutter/domain/entity/distance_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/location_entity.dart';
import 'package:isolate_bloc/isolate_bloc.dart';

import 'event/manufacturer_screen_event.dart';

enum MainScreenType { check, manufacturer, settings }

enum ManufacturerScreenType { all, search, favorites }

enum ScrollDirectionType { top, bottom }

class NavigationBloc extends IsolateBloc<NavigationEvent, NavigationState> {
  static init(SettingsRepository repository) {
    register<NavigationBloc, NavigationState>(create: () => NavigationBloc(repository));
  }

  final SettingsRepository _repository;

  NavigationBloc(this._repository) : super(ShowScreenState(MainScreenType.check));

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    if (event is ShowScreenEvent) {
      emit(ShowScreenState(event.screen));
    } else if (event is ScrollScreenEvent) {
      emit(ScrollScreenState(event.direction));
    } else if (event is TappedMapScreenEvent) {
      LocationEntity location = LocationEntity(event.location.latitude, event.location.longitude);
      DistanceEntity distance = await _repository.loadDistanceFromDatabase();
      emit(TappedMapScreenState(location, distance));
    } else if (event is ManufacturerScreenEvent) {
      emit(ManufacturerScreenState(event.screen));
    } else if (event is LocalizationScreenEvent) {
      emit(LocalizationScreenState());
    }
  }
}
