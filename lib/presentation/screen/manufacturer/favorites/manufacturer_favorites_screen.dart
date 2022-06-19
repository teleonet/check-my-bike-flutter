import 'package:check_my_bike_flutter/domain/bloc/manufacturer/event/load/load_favorites_event.dart';
import 'package:check_my_bike_flutter/domain/entity/manufacturer_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/pagination_entity.dart';
import 'package:check_my_bike_flutter/presentation/screen/manufacturer/base/base_manufacturer_screen.dart';
import 'package:flutter/material.dart';
import 'package:isolate_bloc/isolate_bloc.dart';

import '../../../../domain/bloc/manufacturer/event/favorite/add_favorite_event.dart';
import '../../../../domain/bloc/manufacturer/event/favorite/remove_favorite_event.dart';
import '../../../../domain/bloc/manufacturer/manufacturer_bloc.dart';
import '../../../../domain/bloc/manufacturer/state/manufacturer_state.dart';

class ManufacturerFavoritesScreen extends BaseManufacturerScreen {
  ManufacturerFavoritesScreen({Key? key}) : super(key: key);

  @override
  List<Widget> buildInheritorWidgets(BuildContext context) {
    return [];
  }

  @override
  void addFavorite(BuildContext context, ManufacturerEntity entity) {
    context.isolateBloc<ManufacturerBloc, ManufacturerState>().add(AddFavoriteEvent(entity));
  }

  @override
  void removeFavorite(BuildContext context, ManufacturerEntity entity) {
    context
        .isolateBloc<ManufacturerBloc, ManufacturerState>()
        .add(RemoveFavoriteEvent(entity, deleteFromResult: true));
  }

  @override
  void loadNextPage(BuildContext context, PaginationEntity pagination) {
    context
        .isolateBloc<ManufacturerBloc, ManufacturerState>()
        .add(LoadFavoritesEvent(PaginationEntity()));
  }
}
