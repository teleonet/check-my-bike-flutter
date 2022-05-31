import 'package:check_my_bike_flutter/domain/entity/bike_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/location_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/pagination_entity.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/base/base_check_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/details/details_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/info/info_item.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/map/map_screen.dart';
import 'package:check_my_bike_flutter/presentation/widgets/shake_button.dart';
import 'package:flutter/material.dart';
import 'package:isolate_bloc/isolate_bloc.dart';

import '../../../../domain/bloc/bike/bike_bloc.dart';
import '../../../../domain/bloc/bike/event/favorite/add_favorite_event.dart';
import '../../../../domain/bloc/bike/event/favorite/remove_favorite_event.dart';
import '../../../../domain/bloc/bike/event/load/load_location_event.dart';
import '../../../../domain/bloc/bike/state/bike_state.dart';

class LocationScreen extends BaseCheckScreen {
  static show(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return IsolateBlocProvider<BikeBloc, BikeState>(child: LocationScreen());
    }));
  }

  LocationEntity? _location;
  int? _distance;
  final GlobalKey? _locationButtonKey = GlobalKey<ShakeButtonState>();

  LocationScreen({Key? key}) : super("location", key: key);

  @override
  List<Widget> buildInheritorWidgets(BuildContext context) {
    return [
      _buildLocationButton(context) /*, _buildSearchButton(context)*/
    ];
  }

  Widget _buildLocationButton(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
            padding: const EdgeInsets.only(top: 10),
            //TODO: need to change to simple button instead of ShakeButton
            child: ShakeButton("choose location", onPressed: () async {
              MapScreen.show(context);
              /*_location = await Future.delayed(const Duration(seconds: 1), () {
                return LocationEntity(39.73, -104.98);
              });
              if (_location != null) {
                DistanceDialog((value) {
                  _distance = value;
                  _loadBikes(context, PaginationEntity());
                }).show(context, "Choose distance");
              }*/
            }),
            key: _locationButtonKey));
  }

  void _loadBikes(BuildContext context, PaginationEntity pagination) {
    context
        .isolateBloc<BikeBloc, BikeState>()
        .add(LoadLocationEvent(_location!, _distance!, pagination));
  }

  @override
  Widget buildListItem(BuildContext context, BikeEntity bike) {
    return InfoItem(bike, (bike) => DetailsScreen.show(context, bike),
        (bike) => bike.favorite ? _removeFavorite(bike, context) : _addFavorite(bike, context));
  }

  @override
  void loadNextPage(BuildContext context, PaginationEntity pagination) {
    _loadBikes(context, pagination);
  }

  void _addFavorite(BikeEntity bike, BuildContext context) {
    context.isolateBloc<BikeBloc, BikeState>().add(AddFavoriteEvent(bike));
  }

  void _removeFavorite(BikeEntity bike, BuildContext context) {
    context.isolateBloc<BikeBloc, BikeState>().add(RemoveFavoriteEvent(bike));
  }
}
