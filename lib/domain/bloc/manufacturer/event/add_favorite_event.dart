import 'package:check_my_bike_flutter/domain/bloc/manufacturer/event/manufacturer_event.dart';
import 'package:check_my_bike_flutter/domain/entity/manufacturer_entity.dart';

class AddFavoriteEvent extends ManufacturerEvent {
  final ManufacturerEntity _entity;

  get entity => _entity;

  AddFavoriteEvent(this._entity);
}
