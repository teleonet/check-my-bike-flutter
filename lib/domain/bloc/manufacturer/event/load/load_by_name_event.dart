import 'package:check_my_bike_flutter/domain/bloc/manufacturer/event/load/load_event.dart';

import '../../../../entity/pagination_entity.dart';

class LoadByNameEvent extends LoadEvent {
  final String _query;

  get query => _query;

  LoadByNameEvent(this._query, PaginationEntity? pagination) : super(pagination);
}
