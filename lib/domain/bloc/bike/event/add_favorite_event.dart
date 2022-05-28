import 'package:check_my_bike_flutter/domain/bloc/bike/event/bike_event.dart';
import 'package:check_my_bike_flutter/domain/entity/bike_entity.dart';

class AddFavoriteEvent extends BikeEvent {
  final BikeEntity _bikeEntity;

  get bike => _bikeEntity;

  AddFavoriteEvent(this._bikeEntity);
}
