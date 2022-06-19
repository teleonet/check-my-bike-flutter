import 'package:check_my_bike_flutter/domain/bloc/manufacturer/event/favorite/add_favorite_event.dart';
import 'package:check_my_bike_flutter/domain/entity/manufacturer_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/pagination_entity.dart';
import 'package:check_my_bike_flutter/presentation/screen/manufacturers/base/base_manufacturers_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:isolate_bloc/isolate_bloc.dart';

import '../../../../domain/bloc/manufacturer/event/favorite/remove_favorite_event.dart';
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
    return InputForm('manufacturer_screen.manufacturer_name'.tr(), (textToSearch) {
      _query = textToSearch ?? "";
      loadNextPage(context, PaginationEntity());
    }, (textForValidator) {
      return Validator.isMoreOneSymbol(textForValidator);
    }, 'common.more_then_x_symbol'.tr(args: ["1"]));
  }

  @override
  void addFavorite(BuildContext context, ManufacturerEntity entity) {
    context.isolateBloc<ManufacturerBloc, ManufacturerState>().add(AddFavoriteEvent(entity));
  }

  @override
  void removeFavorite(BuildContext context, ManufacturerEntity entity) {
    context.isolateBloc<ManufacturerBloc, ManufacturerState>().add(RemoveFavoriteEvent(entity));
  }

  @override
  void loadNextPage(BuildContext context, PaginationEntity pagination) {
    context
        .isolateBloc<ManufacturerBloc, ManufacturerState>()
        .add(LoadByNameEvent(_query, pagination));
  }
}
