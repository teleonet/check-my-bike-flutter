import 'package:check_my_bike_flutter/domain/bloc/bike/bike_bloc.dart';
import 'package:check_my_bike_flutter/domain/bloc/bike/state/bike_state.dart';
import 'package:check_my_bike_flutter/domain/entity/bike_entity.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/details/details_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/info/info_item_with_status.dart';
import 'package:flutter/material.dart';
import 'package:isolate_bloc/isolate_bloc.dart';

import '../../../../domain/bloc/bike/event/load_serial_event.dart';
import '../../../validator/validator.dart';
import '../../../widgets/input_form/input_form.dart';
import '../base/base_check_screen.dart';

class SerialScreen extends BaseCheckScreen {
  static show(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return IsolateBlocProvider<BikeBloc, BikeState>(child: const SerialScreen());
    }));
  }

  const SerialScreen({Key? key}) : super("serial", key: key);

  @override
  List<Widget> getWidgets(BuildContext context) {
    return [_buildInputForm(context)];
  }

  Widget _buildInputForm(BuildContext context) {
    return SliverToBoxAdapter(
        child: InputForm("serial number", (textToSearch) {
      _loadBikes(textToSearch ?? "", context);
    }, (textForValidator) {
      return Validator.moreThenFourSymbols(textForValidator);
    }, "Please enter more then 4 symbols"));
  }

  void _loadBikes(String query, BuildContext context) {
    IsolateBlocProvider.of<BikeBloc, BikeState>(context).add(LoadSerialEvent(query));
  }

  @override
  Widget getListView(BuildContext context, List<BikeEntity> bikes) {
    return _buildListView(context, bikes);
  }

  Widget _buildListView(BuildContext context, List<BikeEntity> bikes) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return _buildItem(context, bikes[index]);
    }, childCount: bikes.length));
  }

  Widget _buildItem(BuildContext context, BikeEntity bike) {
    return InfoItemWithStatus(bike,
        onPressedInfo: (bike) => DetailsScreen.show(context, bike), onPressedFavorite: (bike) {});
  }
}
