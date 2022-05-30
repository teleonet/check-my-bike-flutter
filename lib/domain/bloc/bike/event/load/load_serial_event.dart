import 'package:check_my_bike_flutter/domain/bloc/bike/event/load/load_event.dart';

import '../../../../entity/pagination_entity.dart';

class LoadSerialEvent extends LoadEvent {
  final String _serial;

  get serial => _serial;

  LoadSerialEvent(this._serial, PaginationEntity? pagination) : super(pagination);
}
