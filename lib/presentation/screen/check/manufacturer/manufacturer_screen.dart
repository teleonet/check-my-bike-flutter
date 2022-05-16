import 'package:check_my_bike_flutter/domain/entity/bike_entity.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/base/base_check_state.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/details/details_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/info/info_item.dart';
import 'package:flutter/material.dart';

import '../../../validator/validator.dart';
import '../../../widgets/input_form/input_form.dart';

class ManufacturerScreen extends StatefulWidget {
  static show(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ManufacturerScreen()));
  }

  const ManufacturerScreen({Key? key}) : super(key: key);

  @override
  _ManufacturerScreenState createState() => _ManufacturerScreenState();
}

class _ManufacturerScreenState extends BaseCheckState<ManufacturerScreen> {
  List<BikeEntity> _bikes = [];

  _ManufacturerScreenState() : super("manufacturer") {
    _bikes = _buildBikes();
  }

  //todo: only for development
  List<BikeEntity> _buildBikes() {
    return [];
  }

  @override
  List<Widget> getWidgets() {
    return [_buildInputForm(), _buildListView()];
  }

  Widget _buildInputForm() {
    return SliverToBoxAdapter(
        child: InputForm("manufacturer", (textToSearch) {
      //todo: bloc
    }, (textForValidator) {
      return Validator.moreThenFourSymbols(textForValidator);
    }, "Please enter more then 4 symbols"));
  }

  Widget _buildListView() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return _buildInfoItem(_bikes[index]);
    }, childCount: _bikes.length));
  }

  Widget _buildInfoItem(BikeEntity bike) {
    return InfoItem(bike,
        onPressedInfo: (bike) => DetailsScreen.show(context, bike), onPressedFavorite: (bike) {});
  }
}
