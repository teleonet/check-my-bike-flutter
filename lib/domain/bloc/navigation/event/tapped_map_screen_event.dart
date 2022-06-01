import 'package:check_my_bike_flutter/domain/bloc/navigation/event/navigation_event.dart';

import '../../../entity/location_entity.dart';

class TappedMapScreenEvent extends NavigationEvent {
  final LocationEntity _location;

  get location => _location;

  TappedMapScreenEvent(this._location);
}
