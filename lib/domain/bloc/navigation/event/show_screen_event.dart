import 'package:check_my_bike_flutter/domain/bloc/navigation/event/navigation_event.dart';

import '../navigation_bloc.dart';

class ShowScreenEvent extends NavigationEvent {
  final Screen _screen;

  get screen => _screen;

  ShowScreenEvent(this._screen);
}
