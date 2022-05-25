import 'package:check_my_bike_flutter/domain/bloc/manufacturer/events/load_all_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/manufacturer_bloc.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/state/manufacturer_state.dart';
import 'package:check_my_bike_flutter/domain/entity/manufacturer_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/pagination_entity.dart';
import 'package:flutter/material.dart';
import 'package:isolate_bloc/isolate_bloc.dart';

import '../../../../domain/bloc/manufacturer/events/add_favorite_event.dart';
import '../base/manufacturers_base_state.dart';

class ManufacturersAllScreen extends StatefulWidget {
  const ManufacturersAllScreen({Key? key}) : super(key: key);

  @override
  _ManufacturersAllScreenState createState() => _ManufacturersAllScreenState();
}

class _ManufacturersAllScreenState extends ManufacturersBaseState<ManufacturersAllScreen> {
  final PaginationEntity _pagination = PaginationEntity();

  @override
  List<Widget> getTopWidgets() {
    return [];
  }

  @override
  void loadManufacturers() {
    /*IsolateBlocProvider.of<ManufacturerBloc, ManufacturerState>(context)
        .add(LoadAllEvent(_pagination));*/
  }

  @override
  void addFavorite(ManufacturerEntity entity) {
    /*IsolateBlocProvider.of<ManufacturerBloc, ManufacturerState>(context)
        .add(AddFavoriteEvent(entity));*/
  }

  @override
  void removeFavorite(ManufacturerEntity entity) {
    // TODO: implement removeFavorite
  }
}
