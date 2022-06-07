import 'package:check_my_bike_flutter/domain/bloc/manufacturer/event/favorite/favorite_event.dart';

import '../../../../entity/manufacturer_entity.dart';

class RemoveFavoriteEvent extends FavoriteEvent {
  bool _deleteFromResult = false;

  get deleteFromResult => _deleteFromResult;

  RemoveFavoriteEvent(ManufacturerEntity entity, {bool deleteFromResult = false}) : super(entity) {
    _deleteFromResult = deleteFromResult;
  }
}
