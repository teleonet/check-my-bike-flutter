import 'package:check_my_bike_flutter/domain/bloc/bike/event/bike_event.dart';
import 'package:check_my_bike_flutter/domain/entity/pagination_entity.dart';

class LoadEvent extends BikeEvent {
  final PaginationEntity? _pagination;

  get pagination => _pagination;

  LoadEvent(this._pagination);
}
