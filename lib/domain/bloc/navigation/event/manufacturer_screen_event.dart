import 'package:check_my_bike_flutter/domain/bloc/navigation/event/navigation_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/navigation/navigation_bloc.dart';

class ManufacturerScreenEvent extends NavigationEvent {
  final ManufacturerScreenType _screen;

  get screen => _screen;

  ManufacturerScreenEvent(this._screen);
}
