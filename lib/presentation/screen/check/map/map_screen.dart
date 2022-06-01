import 'package:check_my_bike_flutter/domain/bloc/navigation/event/tapped_map_screen_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/navigation/navigation_bloc.dart';
import 'package:check_my_bike_flutter/domain/bloc/navigation/state/navigation_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/navigation/state/tapped_map_screen_state.dart';
import 'package:check_my_bike_flutter/domain/entity/location_entity.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:isolate_bloc/isolate_bloc.dart';

import '../../../../resources/colors_res.dart';

enum MapMode { modify, static }

class MapScreen extends StatelessWidget {
  static show(BuildContext context, LocationEntity location,
      Function(LocationEntity) _onSelectedLocation, MapMode mapMode,
      {double zoom = 10}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return IsolateBlocProvider<NavigationBloc, NavigationState>(
          child: MapScreen(location, _onSelectedLocation, mapMode, zoom));
    }));
  }

  LocationEntity _location;
  final Function(LocationEntity) _onSelectedLocation;
  final MapMode _mapMode;
  final double _zoom;

  MapScreen(this._location, this._onSelectedLocation, this._mapMode, this._zoom, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IsolateBlocBuilder<NavigationBloc, NavigationState>(builder: (context, state) {
      if (state is TappedMapScreenState) {
        _location = state.location;
      }
      return Container(
          decoration: _buildGradientDecoration(),
          child: Stack(children: [
            _buildGoogleMap(context, _buildMarker(_location)),
            Column(children: [
              _buildAppBar(context),
              const Spacer(),
              _mapMode == MapMode.modify ? _buildApplyButton(context) : const SizedBox.shrink()
            ])
          ]));
    }, buildWhen: (prev, next) {
      return next is TappedMapScreenState;
    });
  }

  BoxDecoration _buildGradientDecoration() {
    return BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ColorsRes.startGradient, ColorsRes.endGradient]));
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 65,
      backgroundColor: ColorsRes.darkGreyOpacity75,
      shadowColor: Colors.transparent,
      shape: _buildAppBarBorder(),
      title: const Text("map"),
      centerTitle: true,
      iconTheme: IconThemeData(color: ColorsRes.green, size: 30),
      titleTextStyle: TextStyle(fontFamily: 'Roboto Thin', color: ColorsRes.green, fontSize: 35),
      leading: _buildBackButton(context),
    );
  }

  OutlinedBorder _buildAppBarBorder() {
    return RoundedRectangleBorder(
        side: BorderSide(width: 1, color: ColorsRes.green),
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)));
  }

  Widget _buildBackButton(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios, color: ColorsRes.green, size: 25.0),
        onPressed: () => Navigator.pop(context));
  }

  Marker _buildMarker(LocationEntity location) {
    return Marker(
        markerId: MarkerId(location.toString()),
        position: LatLng(location.latitude, location.longitude));
  }

  GoogleMap _buildGoogleMap(BuildContext context, Marker marker) {
    return GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(target: marker.position, zoom: _zoom),
        markers: {marker},
        zoomControlsEnabled: false,
        trafficEnabled: false,
        onTap: (location) => _onMapPressed(context, location),
        onLongPress: (location) => _onMapPressed(context, location));
  }

  void _onMapPressed(BuildContext context, LatLng latLng) {
    if (_mapMode == MapMode.modify) {
      LocationEntity location = LocationEntity(latLng.latitude, latLng.longitude);
      context.isolateBloc<NavigationBloc, NavigationState>().add(TappedMapScreenEvent(location));
    }
  }

  Widget _buildApplyButton(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        decoration: _buildButtonDecoration(),
        child: TextButton(
            child: _buildText("Apply selected location"),
            onPressed: () {
              Navigator.pop(context);
              _onSelectedLocation.call(_location);
            }));
  }

  BoxDecoration _buildButtonDecoration() {
    return BoxDecoration(
        color: ColorsRes.darkGreyOpacity75,
        border: Border.all(color: ColorsRes.green, width: 2),
        borderRadius: const BorderRadius.all(Radius.elliptical(10, 10)));
  }

  Widget _buildText(String title) {
    return Text(title,
        style: TextStyle(fontFamily: 'Roboto Thin', color: ColorsRes.green, fontSize: 20));
  }
}
