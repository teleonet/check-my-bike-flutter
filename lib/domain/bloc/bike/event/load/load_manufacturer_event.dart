import 'package:check_my_bike_flutter/domain/bloc/bike/event/load/load_event.dart';

import '../../../../entity/pagination_entity.dart';

class LoadManufacturerEvent extends LoadEvent {
  final String _manufacturer;

  get manufacturer => _manufacturer;

  LoadManufacturerEvent(this._manufacturer, PaginationEntity? pagination) : super(pagination);
}
