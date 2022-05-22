import 'package:check_my_bike_flutter/domain/bloc/manufacturer/events/manufacturer_event.dart';
import 'package:check_my_bike_flutter/domain/entity/pagination_entity.dart';

class LoadAllEvent extends ManufacturerEvent {
  final PaginationEntity _pagination;

  get pagination => _pagination;

  LoadAllEvent(this._pagination);
}
