import 'package:check_my_bike_flutter/domain/bloc/bike/bike_bloc.dart';
import 'package:check_my_bike_flutter/domain/bloc/bike/event/favorite/add_favorite_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/bike/event/favorite/remove_favorite_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/bike/state/bike_state.dart';
import 'package:check_my_bike_flutter/domain/entity/bike_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/pagination_entity.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/details/details_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/info/info_item_with_status.dart';
import 'package:flutter/material.dart';
import 'package:isolate_bloc/isolate_bloc.dart';

import '../../../../domain/bloc/bike/event/load/load_serial_event.dart';
import '../../../validator/validator.dart';
import '../../../widgets/input_form/input_form.dart';
import '../base/base_check_screen.dart';

class SerialScreen extends BaseCheckScreen {
  static show(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return IsolateBlocProvider<BikeBloc, BikeState>(child: SerialScreen());
    }));
  }

  String _query = "";

  SerialScreen({Key? key}) : super("serial", key: key);

  @override
  List<Widget> buildInheritorWidgets(BuildContext context) {
    return [_buildInputForm(context)];
  }

  Widget _buildInputForm(BuildContext context) {
    return SliverToBoxAdapter(
        child: InputForm("serial number", (textToSearch) {
      _query = textToSearch ?? "";
      _loadBikes(context, PaginationEntity());
    }, (textForValidator) {
      return Validator.moreThenFourSymbols(textForValidator);
    }, "Please enter more then 4 symbols"));
  }

  void _loadBikes(BuildContext context, PaginationEntity pagination) {
    context.isolateBloc<BikeBloc, BikeState>().add(LoadSerialEvent(_query, pagination));
  }

  @override
  Widget buildListItem(BuildContext context, BikeEntity bike) {
    return InfoItemWithStatus(bike, (bike) => DetailsScreen.show(context, bike), (bike) {
      bike.favorite ? _removeFavorite(bike, context) : _addFavorite(bike, context);
    });
  }

  void _addFavorite(BikeEntity bike, BuildContext context) {
    context.isolateBloc<BikeBloc, BikeState>().add(AddFavoriteEvent(bike));
  }

  void _removeFavorite(BikeEntity bike, BuildContext context) {
    context.isolateBloc<BikeBloc, BikeState>().add(RemoveFavoriteEvent(bike));
  }

  @override
  void loadNextPage(BuildContext context, PaginationEntity pagination) {
    _loadBikes(context, pagination);
  }
}
