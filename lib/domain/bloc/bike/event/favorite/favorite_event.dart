import 'package:check_my_bike_flutter/domain/bloc/bike/event/bike_event.dart';
import 'package:check_my_bike_flutter/domain/entity/bike_entity.dart';

class FavoriteEvent extends BikeEvent {
  final BikeEntity _bike;

  get bike => _bike;

  FavoriteEvent(this._bike);
}
