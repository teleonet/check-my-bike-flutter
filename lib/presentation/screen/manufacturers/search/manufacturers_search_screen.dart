import 'package:check_my_bike_flutter/domain/bloc/manufacturer/events/load_by_name_event.dart';
import 'package:check_my_bike_flutter/domain/entity/manufacturer_entity.dart';
import 'package:check_my_bike_flutter/presentation/screen/manufacturers/base/manufacturers_base_state.dart';
import 'package:flutter/material.dart';
import 'package:isolate_bloc/isolate_bloc.dart';

import '../../../../domain/bloc/manufacturer/events/add_favorite_event.dart';
import '../../../../domain/bloc/manufacturer/events/remove_favorite_event.dart';
import '../../../../domain/bloc/manufacturer/manufacturer_bloc.dart';
import '../../../../domain/bloc/manufacturer/state/manufacturer_state.dart';
import '../../../validator/validator.dart';
import '../../../widgets/input_form/input_form.dart';

class ManufacturersSearchScreen extends StatefulWidget {
  const ManufacturersSearchScreen({Key? key}) : super(key: key);

  @override
  _ManufacturersSearchScreenState createState() => _ManufacturersSearchScreenState();
}

class _ManufacturersSearchScreenState extends ManufacturersBaseState<ManufacturersSearchScreen> {
  String _query = "";

  @override
  List<Widget> getTopWidgets() {
    return [_buildInputForm()];
  }

  @override
  void loadManufacturers() {
    /*IsolateBlocProvider.of<ManufacturerBloc, ManufacturerState>(context)
        .add(LoadByNameEvent(_query));*/
  }

  Widget _buildInputForm() {
    return InputForm("Manufacturer's name", (textToSearch) {
      _query = textToSearch ?? "";
      loadManufacturers();
    }, (textForValidator) {
      return Validator.moreThenOneSymbol(textForValidator);
    }, "Please enter more then 1 symbols");
  }

  @override
  void addFavorite(ManufacturerEntity entity) {
    /*IsolateBlocProvider.of<ManufacturerBloc, ManufacturerState>(context)
        .add(AddFavoriteEvent(entity));
    loadManufacturers();*/
  }

  @override
  void removeFavorite(ManufacturerEntity entity) {
    /*IsolateBlocProvider.of<ManufacturerBloc, ManufacturerState>(context)
        .add(RemoveFavoriteEvent(entity));
    loadManufacturers();*/
  }
}
