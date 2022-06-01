import 'package:check_my_bike_flutter/domain/entity/location_entity.dart';

import 'navigation_state.dart';

class TappedMapScreenState extends NavigationState {
  final LocationEntity _location;

  get location => _location;

  TappedMapScreenState(this._location);
}
