import 'package:check_my_bike_flutter/presentation/dialogs/distance/distance_dialog.dart';
import 'package:check_my_bike_flutter/domain/entity/bike_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/location_entity.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/base/base_check_state.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/details/details_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/info/info_item.dart';
import 'package:check_my_bike_flutter/presentation/widgets/bordered_button.dart';
import 'package:check_my_bike_flutter/presentation/widgets/shake_button.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  static show(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const LocationScreen()));
  }

  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends BaseCheckState<LocationScreen> {
  LocationEntity? _location;
  List<BikeEntity> _bikes = [];

  final GlobalKey? _locationButtonKey = GlobalKey<ShakeButtonState>();

  _LocationScreenState() : super("location") {
    // _location = Location(39.73, -104.98);
    _bikes = _buildBikes();
  }

  //todo: only for development
  List<BikeEntity> _buildBikes() {
    return [];
  }

  @override
  List<Widget> getWidgets() {
    return [_buildLocationButton(), _buildSearchButton(), _buildListView()];
  }

  Widget _buildLocationButton() {
    return SliverToBoxAdapter(
        child: Container(
            padding: const EdgeInsets.only(top: 10),
            child: ShakeButton("choose location",
                onPressed: () => DistanceDialog((value) => print("Choose distance $value"))
                    .show(context, "Choose distance"),
                key: _locationButtonKey)));
  }

  Widget _buildSearchButton() {
    return SliverToBoxAdapter(
        child: Container(
            padding: const EdgeInsets.only(top: 10),
            child: BorderedButton("search", onPressed: () {
              ShakeButtonState? buttonState = _locationButtonKey?.currentState as ShakeButtonState?;
              if (_location != null) {
                buttonState?.changeToNormalState();
              } else {
                buttonState?.changeToErrorState();
                //todo: add bloc request location
              }
            })));
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
