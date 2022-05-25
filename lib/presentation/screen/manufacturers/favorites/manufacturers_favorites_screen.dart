import 'package:check_my_bike_flutter/domain/bloc/manufacturer/event/load_favorites_event.dart';
import 'package:check_my_bike_flutter/domain/entity/manufacturer_entity.dart';
import 'package:check_my_bike_flutter/presentation/screen/manufacturers/base/manufacturers_base_state.dart';
import 'package:flutter/material.dart';
import 'package:isolate_bloc/isolate_bloc.dart';

import '../../../../domain/bloc/manufacturer/event/add_favorite_event.dart';
import '../../../../domain/bloc/manufacturer/event/remove_favorite_event.dart';
import '../../../../domain/bloc/manufacturer/manufacturer_bloc.dart';
import '../../../../domain/bloc/manufacturer/state/manufacturer_state.dart';

class ManufacturersFavoritesScreen extends StatefulWidget {
  const ManufacturersFavoritesScreen({Key? key}) : super(key: key);

  @override
  _ManufacturersFavoritesScreenState createState() => _ManufacturersFavoritesScreenState();
}

class _ManufacturersFavoritesScreenState
    extends ManufacturersBaseState<ManufacturersFavoritesScreen> {
  @override
  void loadManufacturers() {
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
}
