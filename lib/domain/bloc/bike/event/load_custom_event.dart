import 'package:check_my_bike_flutter/domain/bloc/bike/event/bike_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/bike/event/load_event.dart';

class LoadCustomEvent extends LoadEvent {
  final String _custom;

  get custom => _custom;

  LoadCustomEvent(this._custom);
}
