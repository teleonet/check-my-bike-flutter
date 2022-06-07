import 'package:check_my_bike_flutter/domain/entity/manufacturer_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/pagination_entity.dart';
import 'package:check_my_bike_flutter/presentation/screen/manufacturers/base/base_manufacturers_screen.dart';
import 'package:flutter/material.dart';
import 'package:isolate_bloc/isolate_bloc.dart';

import '../../../../domain/bloc/manufacturer/manufacturer_bloc.dart';
import '../../../../domain/bloc/manufacturer/state/manufacturer_state.dart';

class ManufacturersFavoritesScreen extends BaseManufacturersScreen {
  static IsolateBlocProvider<ManufacturerBloc, ManufacturerState> getInstance() {
    return IsolateBlocProvider<ManufacturerBloc, ManufacturerState>(
        child: ManufacturersFavoritesScreen());
  }

  @override
  void loadManufacturers(BuildContext context) {
    // IsolateBlocProvider.of<ManufacturerBloc, ManufacturerState>(context).add(LoadFavoritesEvent());
  }

  @override
  List<Widget> getTopWidgets() {
    return [];
  }

  @override
  void addFavorite(ManufacturerEntity entity) {
    /*IsolateBlocProvider.of<ManufacturerBloc, ManufacturerState>(context)
        .add(AddFavoriteEvent(entity));
    loadManufacturers();*/
  }

  @override
  void removeFavorite(ManufacturerEntity entity) {
    // IsolateBlocProvider.of<ManufacturerBloc, ManufacturerState>(context)
    //     .add(RemoveFavoriteEvent(entity));
    // loadManufacturers();
  }

  @override
  List<Widget> buildInheritorWidgets(BuildContext context) {
    return [];
  }

  @override
  void loadNextPage(BuildContext context, PaginationEntity pagination) {
    // TODO: implement loadNextPage
  }
}
