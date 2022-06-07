import 'package:check_my_bike_flutter/domain/bloc/manufacturer/event/manufacturer_event.dart';
import 'package:check_my_bike_flutter/domain/entity/manufacturer_entity.dart';

class FavoriteEvent extends ManufacturerEvent {
  final ManufacturerEntity _manufacturer;

  get manufacturer => _manufacturer;

  FavoriteEvent(this._manufacturer);
}
