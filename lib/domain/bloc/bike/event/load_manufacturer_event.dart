import 'package:check_my_bike_flutter/domain/bloc/bike/event/load_event.dart';

class LoadManufacturerEvent extends LoadEvent {
  final String _manufacturer;

  get manufacturer => _manufacturer;

  LoadManufacturerEvent(this._manufacturer);
}
