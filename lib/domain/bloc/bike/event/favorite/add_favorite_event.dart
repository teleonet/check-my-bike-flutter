import 'package:check_my_bike_flutter/domain/bloc/bike/event/favorite/favorite_event.dart';
import 'package:check_my_bike_flutter/domain/entity/bike_entity.dart';

class AddFavoriteEvent extends FavoriteEvent {
  AddFavoriteEvent(BikeEntity bike) : super(bike);
}
