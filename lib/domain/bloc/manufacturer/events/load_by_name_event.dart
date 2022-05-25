import 'package:check_my_bike_flutter/domain/bloc/manufacturer/events/manufacturer_event.dart';

class LoadByNameEvent extends ManufacturerEvent {
  final String _query;

  get query => _query;

  LoadByNameEvent(this._query);
}
