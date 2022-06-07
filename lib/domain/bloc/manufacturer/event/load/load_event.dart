import 'package:check_my_bike_flutter/domain/bloc/manufacturer/event/manufacturer_event.dart';
import 'package:check_my_bike_flutter/domain/entity/pagination_entity.dart';

class LoadEvent extends ManufacturerEvent {
  final PaginationEntity? _pagination;

  get pagination => _pagination;

  LoadEvent(this._pagination);
}
