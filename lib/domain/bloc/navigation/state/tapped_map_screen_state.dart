import 'package:check_my_bike_flutter/domain/entity/location_entity.dart';

import '../../../entity/distance_entity.dart';
import 'navigation_state.dart';

class TappedMapScreenState extends NavigationState {
  final LocationEntity _location;

  get location => _location;

  final DistanceEntity _distance;

  get distance => _distance;

  TappedMapScreenState(this._location, this._distance);
}
