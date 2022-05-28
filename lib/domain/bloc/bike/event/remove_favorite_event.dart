import 'package:check_my_bike_flutter/domain/bloc/bike/event/bike_event.dart';

import '../../../entity/bike_entity.dart';

class RemoveFavoriteEvent extends BikeEvent {
  final BikeEntity _bikeEntity;

  get bike => _bikeEntity;

  RemoveFavoriteEvent(this._bikeEntity);
}
