import 'package:check_my_bike_flutter/domain/bloc/bike/event/favorite/favorite_event.dart';

import '../../../../entity/bike_entity.dart';

class RemoveFavoriteEvent extends FavoriteEvent {
  RemoveFavoriteEvent(BikeEntity bike) : super(bike);
}
