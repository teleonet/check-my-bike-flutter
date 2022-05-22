import 'package:check_my_bike_flutter/data/repository/manufacturer/manufacturer_repository.dart';
import 'package:check_my_bike_flutter/domain/entity/manufacturer_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/pagination_entity.dart';
import 'package:check_my_bike_flutter/domain/event/manufacturer/load_first_event.dart';
import 'package:check_my_bike_flutter/domain/event/manufacturer/load_next_event.dart';
import 'package:check_my_bike_flutter/domain/state/manufacturer/loaded_state.dart';
import 'package:check_my_bike_flutter/domain/state/manufacturer/manufacturer_state.dart';
import 'package:isolate_bloc/isolate_bloc.dart';

import '../event/manufacturer/manufacturer_event.dart';

class ManufacturerBloc extends IsolateBloc<ManufacturerEvent, ManufacturerState> {
  final ManufacturerRepository _repository;
  final PaginationEntity _pagination = PaginationEntity();

  ManufacturerBloc(this._repository) : super(LoadedState([], PaginationEntity()));

  @override
  Stream<ManufacturerState> mapEventToState(ManufacturerEvent event) async* {
    if (event is LoadFirstEvent) {
      _pagination.firstPage();
      List<ManufacturerEntity> entities = await _loadManufacturers(_pagination);
      emit(LoadedState(entities, _pagination));
    }
    if (event is LoadNextEvent) {
      _pagination.nextPage();
      List<ManufacturerEntity> entities = await _loadManufacturers(_pagination);
      emit(LoadedState(entities, _pagination));
    }
  }

  Future<List<ManufacturerEntity>> _loadManufacturers(PaginationEntity pagination) async {
    List<ManufacturerEntity> loadedEntities =
        await _repository.loadFromRestAll(pagination.currentPage);
    return loadedEntities.where((element) => element.companyUrl.toString().isNotEmpty).toList();
  }
}
