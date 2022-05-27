import 'package:check_my_bike_flutter/domain/bloc/navigation/event/navigation_event.dart';

import '../navigation_bloc.dart';

class ScrollScreenEvent extends NavigationEvent {
  final Direction _direction;

  get direction => _direction;

  ScrollScreenEvent(this._direction);
}
