import 'package:check_my_bike_flutter/domain/bloc/bike/event/load_manufacturer_event.dart';
import 'package:check_my_bike_flutter/domain/entity/bike_entity.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/base/base_check_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/details/details_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/info/info_item.dart';
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

  const ManufacturerScreen({Key? key}) : super("manufacturer", key: key);

  @override
  List<Widget> getWidgets(BuildContext context) {
    return [_buildInputForm(context)];
  }

  Widget _buildInputForm(BuildContext context) {
    return SliverToBoxAdapter(
        child: InputForm("manufacturer", (textToSearch) {
      _loadBikes(textToSearch ?? "", context);
    }, (textForValidator) {
      return Validator.moreThenTwoSymbols(textForValidator);
    }, "Please enter more then 2 symbols"));
  }

  void _loadBikes(String query, BuildContext context) {
    IsolateBlocProvider.of<BikeBloc, BikeState>(context).add(LoadManufacturerEvent(query));
  }

  @override
  Widget getListView(BuildContext context, List<BikeEntity> bikes) {
    return _buildListView(context, bikes);
  }

  Widget _buildListView(BuildContext context, List<BikeEntity> bikes) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return _buildInfoItem(context, bikes[index]);
    }, childCount: bikes.length));
  }

  Widget _buildInfoItem(BuildContext context, BikeEntity bike) {
    return InfoItem(bike, (bike) => DetailsScreen.show(context, bike), (bike) {});
  }
}
