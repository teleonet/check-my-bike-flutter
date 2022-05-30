import 'package:check_my_bike_flutter/domain/bloc/bike/event/load/load_custom_event.dart';
import 'package:check_my_bike_flutter/domain/entity/bike_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/pagination_entity.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/base/base_check_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/details/details_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/info/info_item.dart';
import 'package:flutter/material.dart';
import 'package:isolate_bloc/isolate_bloc.dart';

import '../../../../domain/bloc/bike/bike_bloc.dart';
import '../../../../domain/bloc/bike/state/bike_state.dart';
import '../../../validator/validator.dart';
import '../../../widgets/input_form/input_form.dart';

class CustomScreen extends BaseCheckScreen {
  static show(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return IsolateBlocProvider<BikeBloc, BikeState>(child: CustomScreen());
    }));
  }

  String _query = "";

  CustomScreen({Key? key}) : super("custom", key: key);

  @override
  List<Widget> buildInheritorWidgets(BuildContext context) {
    return [_buildInputForm(context)];
  }

  Widget _buildInputForm(BuildContext context) {
    return SliverToBoxAdapter(
        child: InputForm("parameter", (textToSearch) {
      _query = textToSearch ?? "";
      _loadBikes(context, PaginationEntity());
    }, (textForValidator) {
      return Validator.moreThenTwoSymbols(textForValidator);
    }, "Please enter more then 2 symbols"));
  }

  void _loadBikes(BuildContext context, PaginationEntity pagination) {
    context.isolateBloc<BikeBloc, BikeState>().add(LoadCustomEvent(_query, pagination));
  }

  @override
  Widget buildListItem(BuildContext context, BikeEntity bike) {
    return InfoItem(bike, (bike) => DetailsScreen.show(context, bike),
        (bike) => print("pressed favorite: ${bike.manufacturerName}"));
  }

  @override
  void loadNextPage(BuildContext context, PaginationEntity pagination) {
    _loadBikes(context, pagination);
  }
}
