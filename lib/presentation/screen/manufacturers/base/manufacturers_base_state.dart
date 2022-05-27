import 'package:check_my_bike_flutter/domain/bloc/manufacturer/manufacturer_bloc.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/state/loaded_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/state/manufacturer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isolate_bloc/isolate_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../domain/entity/manufacturer_entity.dart';
import '../../../base/base_screen_state.dart';
import '../manufacturer_item.dart';

abstract class ManufacturersBaseState<T extends StatefulWidget> extends BaseScreenState<T> {
  @protected
  void loadManufacturers();

  @protected
  List<Widget> getTopWidgets();

  @protected
  void addFavorite(ManufacturerEntity entity);

  @protected
  void removeFavorite(ManufacturerEntity entity);

  @override
  void initState() {
    loadManufacturers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IsolateBlocBuilder<ManufacturerBloc, ManufacturerState>(builder: (context, state) {
      List<ManufacturerEntity> entities = (state as LoadedState).entities;
      List<Widget> widgets = getTopWidgets();
      return SliverList(
          delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        //todo: need to find more better solution
        if (index == 0) {
          for (Widget item in widgets) {
            return item;
          }
        }
        return _buildManufacturerItem(entities[index - widgets.length]);
      }, childCount: widgets.length + entities.length));
    });
  }

  Widget _buildManufacturerItem(ManufacturerEntity manufacturer) {
    String companyUrl = manufacturer.companyUrl;
    bool isFavorite = manufacturer.isFavorite;

    return ManufacturerItem(
        manufacturer,
        (manufacturer) => isFavorite ? removeFavorite(manufacturer) : addFavorite(manufacturer),
        (manufacturer) => _openURL(companyUrl));
  }

  void _openURL(String url) async {
    try {
      //todo: need add parameters for Android and IOS => https://pub.dev/packages/url_launcher
      await launch(url);
    } on MissingPluginException catch (e) {
      print("ERROR: $e");
    }
  }
}
