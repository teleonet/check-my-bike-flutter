import 'package:check_my_bike_flutter/domain/bloc/bike/event/load/load_event.dart';

import '../../../../entity/pagination_entity.dart';

class LoadFavoritesEvent extends LoadEvent {
  LoadFavoritesEvent(PaginationEntity? pagination) : super(pagination);
}
