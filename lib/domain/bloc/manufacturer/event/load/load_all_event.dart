import 'package:check_my_bike_flutter/domain/bloc/manufacturer/event/load/load_event.dart';
import 'package:check_my_bike_flutter/domain/entity/pagination_entity.dart';

class LoadAllEvent extends LoadEvent {
  LoadAllEvent(PaginationEntity? pagination) : super(pagination);
}
