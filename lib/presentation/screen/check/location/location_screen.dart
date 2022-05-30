import 'dart:async';

import 'package:check_my_bike_flutter/domain/entity/bike_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/location_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/pagination_entity.dart';
import 'package:check_my_bike_flutter/presentation/dialogs/distance/distance_dialog.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/base/base_check_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/details/details_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/info/info_item.dart';
import 'package:check_my_bike_flutter/presentation/widgets/bordered_button.dart';
import 'package:check_my_bike_flutter/presentation/widgets/shake_button.dart';
import 'package:flutter/material.dart';
import 'package:isolate_bloc/isolate_bloc.dart';

import '../../../../domain/bloc/bike/bike_bloc.dart';
import '../../../../domain/bloc/bike/event/load/load_location_event.dart';
import '../../../../domain/bloc/bike/state/bike_state.dart';

class LocationScreen extends BaseCheckScreen {
  static show(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => LocationScreen()));
  }

  LocationEntity? _location;
  int? _distance;
  final GlobalKey? _locationButtonKey = GlobalKey<ShakeButtonState>();

  LocationScreen() : super("location");

  @override
  List<Widget> buildInheritorWidgets(BuildContext context) {
    return [_buildLocationButton(context), _buildSearchButton(context)];
  }

  Widget _buildLocationButton(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
            padding: const EdgeInsets.only(top: 10),
            child: ShakeButton("choose location", onPressed: () async {
              _location = await Future.delayed(const Duration(seconds: 1), () {
                return LocationEntity(39.73, -104.98);
              });
              if (_location != null) {
                DistanceDialog((value) => _distance = value).show(context, "Choose distance");
              }
            }),
            key: _locationButtonKey));
  }

  Widget _buildSearchButton(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
            padding: const EdgeInsets.only(top: 10),
            child: BorderedButton("search", onPressed: () {
              ShakeButtonState? buttonState = _locationButtonKey?.currentState as ShakeButtonState?;
              if (_location != null && _distance != null) {
                buttonState?.setNormalState();
                _loadBikes(context, PaginationEntity());
              } else {
                buttonState?.setErrorState();
              }
            })));
  }

  void _loadBikes(BuildContext context, PaginationEntity pagination) {
    context
        .isolateBloc<BikeBloc, BikeState>()
        .add(LoadLocationEvent(_location!, _distance!, pagination));
  }

  @override
  Widget buildListItem(BuildContext context, BikeEntity bike) {
    return InfoItem(bike, (bike) => DetailsScreen.show(context, bike), (bike) {});
  }

  @override
  void loadNextPage(BuildContext context, PaginationEntity pagination) {
    _loadBikes(context, pagination);
  }
}
