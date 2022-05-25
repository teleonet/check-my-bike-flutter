import 'package:check_my_bike_flutter/data/repository/manufacturer/manufacturer_repository.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/event/add_favorite_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/event/load_all_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/event/load_by_name_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/event/remove_favorite_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/state/loaded_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/state/manufacturer_state.dart';
import 'package:check_my_bike_flutter/domain/entity/manufacturer_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/pagination_entity.dart';
import 'package:isolate_bloc/isolate_bloc.dart';

import 'event/load_favorites_event.dart';
import 'event/manufacturer_event.dart';

class ManufacturerBloc extends IsolateBloc<ManufacturerEvent, ManufacturerState> {
  final ManufacturerRepository _repository;

  ManufacturerBloc(this._repository) : super(LoadedState([]));

  @override
  Stream<ManufacturerState> mapEventToState(ManufacturerEvent event) async* {
    if (event is LoadAllEvent) {
      List<ManufacturerEntity> entities = await _loadAll(event.pagination);
      emit(LoadedState(entities));
    } else if (event is LoadByNameEvent) {
      List<ManufacturerEntity> entities = await _loadByName(event.query);
      emit(LoadedState(entities));
    } else if (event is LoadFavoritesEvent) {
      List<ManufacturerEntity> entities = await _loadFavorites();
      emit(LoadedState(entities));
    } else if (event is AddFavoriteEvent) {
      _addFavorite(event.entity);
    } else if (event is RemoveFavoriteEvent) {
      _removeFavorite(event.entity);
    }
  }

  Future<List<ManufacturerEntity>> _loadAll(PaginationEntity pagination) async {
    List<ManufacturerEntity> loadedEntities =
        await _repository.loadFromRestAll(pagination.currentPage);

    List<ManufacturerEntity> filteredEntities =
        loadedEntities.where((element) => element.companyUrl.toString().isNotEmpty).toList();

    List<ManufacturerEntity> favorites = await _loadFavorites();

    for (var element in filteredEntities) {
      element.isFavorite = await _isFavorite(favorites, element);
    }

    return filteredEntities;
  }

  Future<List<ManufacturerEntity>> _loadByName(String query) async {
    ManufacturerEntity? entity = await _repository.loadFromRestByName(query);
    if (entity != null) {
      List<ManufacturerEntity> favorites = await _loadFavorites();
      entity.isFavorite = await _isFavorite(favorites, entity);
    }
    return entity != null ? [entity] : [];
  }

  Future<List<ManufacturerEntity>> _loadFavorites() async {
    return await _repository.loadFromDatabase();
  }

  Future<void> _addFavorite(ManufacturerEntity entity) async {
    return await _repository.saveToDatabase([entity]);
  }

  Future<void> _removeFavorite(ManufacturerEntity entity) async {
    return await _repository.deleteFromDatabase([entity]);
  }

  Future<bool> _isFavorite(List<ManufacturerEntity> favorites, ManufacturerEntity entity) async {
    Iterable<ManufacturerEntity> foundEntities = favorites.where((element) {
      return element.companyUrl == entity.companyUrl;
    });
    return foundEntities.isNotEmpty;
  }
}
