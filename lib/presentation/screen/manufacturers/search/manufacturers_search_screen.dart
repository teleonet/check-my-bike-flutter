import 'package:check_my_bike_flutter/domain/entity/manufacturer_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/pagination_entity.dart';
import 'package:check_my_bike_flutter/presentation/screen/manufacturers/base/base_manufacturers_screen.dart';
import 'package:flutter/material.dart';
import 'package:isolate_bloc/isolate_bloc.dart';

import '../../../../domain/bloc/manufacturer/event/load/load_by_name_event.dart';
import '../../../../domain/bloc/manufacturer/manufacturer_bloc.dart';
import '../../../../domain/bloc/manufacturer/state/manufacturer_state.dart';
import '../../../validator/validator.dart';
import '../../../widgets/input_form/input_form.dart';

class ManufacturersSearchScreen extends BaseManufacturersScreen {
  String _query = "";

  @override
  List<Widget> buildInheritorWidgets(BuildContext context) {
    return [_buildInputForm(context)];
  }

  Widget _buildInputForm(BuildContext context) {
    return InputForm("Manufacturer's name", (textToSearch) {
      _query = textToSearch ?? "";
      loadManufacturers(context);
    }, (textForValidator) {
      return Validator.moreThenOneSymbol(textForValidator);
    }, "Please enter more then 1 symbols");
  }

  @override
  void loadManufacturers(BuildContext context) {
    IsolateBlocProvider.of<ManufacturerBloc, ManufacturerState>(context)
        .add(LoadByNameEvent(_query, PaginationEntity()));
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

  @override
  void loadNextPage(BuildContext context, PaginationEntity pagination) {
    // TODO: implement loadNextPage
  }
}
