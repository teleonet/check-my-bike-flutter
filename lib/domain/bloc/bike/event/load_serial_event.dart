import 'package:check_my_bike_flutter/domain/bloc/bike/event/load_event.dart';

class LoadSerialEvent extends LoadEvent {
  final String _serial;

  get serial => _serial;

  LoadSerialEvent(this._serial);
}
