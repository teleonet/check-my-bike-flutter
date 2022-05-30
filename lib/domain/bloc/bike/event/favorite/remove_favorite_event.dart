import 'package:check_my_bike_flutter/domain/bloc/bike/event/favorite/favorite_event.dart';

import '../../../../entity/bike_entity.dart';

class RemoveFavoriteEvent extends FavoriteEvent {
  bool _deleteFromResult = false;

  get deleteFromResult => _deleteFromResult;

  RemoveFavoriteEvent(BikeEntity bike, {bool deleteFromResult = false}) : super(bike) {
    _deleteFromResult = deleteFromResult;
  }
}
