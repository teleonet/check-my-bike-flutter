import 'package:check_my_bike_flutter/domain/bloc/bike/event/favorite/add_favorite_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/bike/event/favorite/remove_favorite_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/bike/event/load/load_manufacturer_event.dart';
import 'package:check_my_bike_flutter/domain/entity/bike_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/pagination_entity.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/base/base_check_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/details/details_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/info/info_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:isolate_bloc/isolate_bloc.dart';

import '../../../../domain/bloc/bike/bike_bloc.dart';
import '../../../../domain/bloc/bike/state/bike_state.dart';
import '../../../validator/validator.dart';
import '../../../widgets/input_form/input_form.dart';

class ManufacturerScreen extends BaseCheckScreen {
  static show(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return IsolateBlocProvider<BikeBloc, BikeState>(child: ManufacturerScreen());
    }));
  }

  String _query = "";

  ManufacturerScreen({Key? key}) : super('bike_screen.manufacturer'.tr(), key: key);

  @override
  List<Widget> buildInheritorWidgets(BuildContext context) {
    return [_buildInputForm(context)];
  }

  Widget _buildInputForm(BuildContext context) {
    return SliverToBoxAdapter(
        child: InputForm('bike_screen.manufacturer'.tr().toLowerCase(), (textToSearch) {
      _query = textToSearch ?? "";
      _loadBikes(context, PaginationEntity());
    }, (textForValidator) {
      return Validator.isMoreTwoSymbols(textForValidator);
    }, 'common.more_then_x_symbol'.tr(args: ["2"])));
  }

  void _loadBikes(BuildContext context, PaginationEntity pagination) {
    context.isolateBloc<BikeBloc, BikeState>().add(LoadManufacturerEvent(_query, pagination));
  }

  @override
  Widget buildListItem(BuildContext context, BikeEntity bike) {
    return InfoItem(bike, (bike) => DetailsScreen.show(context, bike), (bike) {
      bike.favorite ? _removeFavorite(context, bike) : _addFavorite(context, bike);
    });
  }

  void _addFavorite(BuildContext context, BikeEntity bike) {
    context.isolateBloc<BikeBloc, BikeState>().add(AddFavoriteEvent(bike));
  }

  void _removeFavorite(BuildContext context, BikeEntity bike) {
    context.isolateBloc<BikeBloc, BikeState>().add(RemoveFavoriteEvent(bike));
  }

  @override
  void loadNextPage(BuildContext context, PaginationEntity pagination) {
    _loadBikes(context, pagination);
  }
}
