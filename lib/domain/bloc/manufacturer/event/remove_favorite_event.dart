import 'package:check_my_bike_flutter/domain/bloc/manufacturer/event/manufacturer_event.dart';

import '../../../entity/manufacturer_entity.dart';

class RemoveFavoriteEvent extends ManufacturerEvent {
  final ManufacturerEntity _entity;

  get entity => _entity;

  RemoveFavoriteEvent(this._entity);
}
