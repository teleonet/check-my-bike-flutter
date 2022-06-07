import 'package:check_my_bike_flutter/domain/bloc/manufacturer/event/favorite/favorite_event.dart';
import 'package:check_my_bike_flutter/domain/entity/manufacturer_entity.dart';

class AddFavoriteEvent extends FavoriteEvent {
  AddFavoriteEvent(ManufacturerEntity entity) : super(entity);
}
