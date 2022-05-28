import 'package:check_my_bike_flutter/domain/entity/location_entity.dart';

import 'load_event.dart';

class LoadLocationEvent extends LoadEvent {
  final LocationEntity _location;

  get location => _location;

  final int _distance;

  get distance => _distance;

  LoadLocationEvent(this._location, this._distance);
}
