import 'package:check_my_bike_flutter/domain/entity/bike_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/location_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/pagination_entity.dart';
import 'package:check_my_bike_flutter/presentation/dialogs/yes_no_dialog.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/base/base_check_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/details/details_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/info/info_item.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/map/map_screen.dart';
import 'package:check_my_bike_flutter/presentation/widgets/shake_button.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:isolate_bloc/isolate_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../domain/bloc/bike/bike_bloc.dart';
import '../../../../domain/bloc/bike/event/favorite/add_favorite_event.dart';
import '../../../../domain/bloc/bike/event/favorite/remove_favorite_event.dart';
import '../../../../domain/bloc/bike/event/load/load_location_event.dart';
import '../../../../domain/bloc/bike/state/bike_state.dart';
import '../../../dialogs/distance/distance_dialog.dart';

class LocationScreen extends BaseCheckScreen {
  static show(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return IsolateBlocProvider<BikeBloc, BikeState>(child: LocationScreen());
    }));
  }

  LocationEntity? _location;
  int? _distance;

  LocationScreen({Key? key}) : super("location", key: key);

  @override
  List<Widget> buildInheritorWidgets(BuildContext context) {
    return [_buildLocationButton(context)];
  }

  Widget _buildLocationButton(BuildContext context) {
    GlobalKey<ShakeButtonState> _buttonKey = GlobalKey<ShakeButtonState>();
    return SliverToBoxAdapter(
        child: Container(
            padding: const EdgeInsets.only(top: 10),
            child: ShakeButton("choose location", onPressed: () async {
              bool isPermissionGranted = await _checkPermission();
              if (isPermissionGranted) {
                _buttonKey.currentState?.setNormalState();
                _location = await _getLocation();
                _showMapScreen(context);
              } else {
                _showErrorDialog(context, () => _buttonKey.currentState?.setErrorState());
              }
            }, key: _buttonKey)));
  }

  Future<bool> _checkPermission() async {
    bool isGranted = true;
    PermissionStatus status = await Permission.locationWhenInUse.status;
    if (!status.isGranted) {
      Map<Permission, PermissionStatus> statuses = await [Permission.locationWhenInUse].request();
      statuses.forEach((key, value) {
        if (value == PermissionStatus.denied || value == PermissionStatus.permanentlyDenied) {
          isGranted = false;
        }
      });
    }
    return isGranted;
  }

  void _showErrorDialog(BuildContext context, Function() pressedNo) {
    YesNoDialog(() => openAppSettings(), () => pressedNo.call()).show(
        context,
        "Permission error."
        "\nThe map functionality requires location permission."
        "\n\nDo you want to open settings screen to approve permissions?");
  }

  Future<LocationEntity> _getLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    return LocationEntity(position.latitude, position.longitude);
  }

  void _showMapScreen(BuildContext context) {
    MapScreen.show(context, _location!, (location) {
      _location = location;
      _showDistanceDialog(context);
    }, MapMode.modify, zoom: 7);
  }

  void _showDistanceDialog(BuildContext context) {
    DistanceDialog((value) {
      _distance = value;
      _loadBikes(context, PaginationEntity());
    }).show(context, "Choose distance");
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
