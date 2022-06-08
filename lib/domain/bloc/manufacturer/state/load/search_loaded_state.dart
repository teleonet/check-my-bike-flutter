import 'package:check_my_bike_flutter/domain/bloc/manufacturer/state/load/loaded_state.dart';
import 'package:check_my_bike_flutter/domain/entity/manufacturer_entity.dart';

import '../../../../entity/pagination_entity.dart';

class SearchLoadedState extends LoadedState {
  SearchLoadedState(List<ManufacturerEntity> entities, PaginationEntity pagination)
      : super(entities, pagination);
}
